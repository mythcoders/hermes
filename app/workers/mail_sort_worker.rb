# frozen_string_literal: true

# Takes a MessageID and begins inital sorting of the message
class MailSortWorker
  include Sidekiq::Worker

  def perform(tracking_id)
    @tracking_id = tracking_id

    reroute_message if are_emails_rerouted?

    PostalWorker.perform_async(tracking_id)
  end

  private

  def message
    @message ||= Message.find_by_tracking_id @tracking_id
  end

  def reroute_message
    return if message.rerouted?

    message.html_body = rerouted_body('html')
    message.text_body = rerouted_body('text')
    message.subject = "[REROUTED] #{message.subject}"
    message.sender = ApplicationMailer::DEFAULT_FROM
    message.recipients.destroy_all
    message.recipients << message.client.reroute_recipient
    message.rerouted!
  end

  def rerouted_body(type)
    ApplicationController.render(
      template: "api_mailer/reroute_message.#{type}",
      assigns: { message: message },
      layout: false
    )
  end

  def are_emails_rerouted?
    ClientEnvironment.find_or_create_by_env(message.client, message.environment).status == 'rerouted'
  end
end
