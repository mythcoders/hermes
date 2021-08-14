# frozen_string_literal: true

# Takes a MessageID and begins inital sorting of the message
class MailSortJob < ApplicationJob
  def perform(tracking_id)
    @tracking_id = tracking_id

    ActiveRecord::Base.transaction do
      if message.text_body.blank?
        message.text_body = PlainText.from_html(message.html_body)
        message.save!
      end

      if emails_are_rerouted?
        reroute_message
        # elsif emails_are_whitelisted?
        #   remove_non_whitelisted_recipients
      end
    end

    return message.held! if emails_are_held?
    return message.ignored! if emails_are_ignored?

    PostalWorkerJob.perform_later(tracking_id)
  end

  private

  def message
    @message ||= Message.find_by_tracking_id @tracking_id
  end

  def remove_non_whitelisted_recipients
    whitelisted_emails = []
    message.recipients.where.not(email: whitelisted_emails).destroy_all
  end

  def reroute_message
    # prevent us from changing the subject and body twice
    return if message.rerouted?

    message.html_body = rerouted_body("html")
    message.text_body = rerouted_body("text")
    message.subject = "[REROUTED] #{message.subject}"
    message.sender = ApplicationMailer::DEFAULT_FROM
    message.recipients.destroy_all
    message.recipients << message.client.reroute_recipient
    message.rerouted!
  end

  def rerouted_body(type)
    template = ApplicationController.render(
      template: "api_mailer/reroute_message.#{type}",
      assigns: {message: message},
      layout: false
    )
    return template unless type == "html"

    message.html_body.html_safe.gsub(/^*<body[^>]*>/, "\\0 #{template}")
  end

  def emails_are_rerouted?
    message.client_environment.status == "rerouted"
  end

  def emails_are_whitelisted?
    message.client_environment.status == "whitelisted"
  end

  def emails_are_held?
    message.client_environment.status == "hold"
  end

  def emails_are_ignored?
    message.client_environment.status == "ignored"
  end
end
