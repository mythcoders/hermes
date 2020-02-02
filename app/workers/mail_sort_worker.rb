# frozen_string_literal: true

# Takes a MessageID and begins inital sorting of the message
class MailSortWorker
  include Sidekiq::Worker

  def perform(tracking_id)
    @tracking_id = tracking_id

    reroute_message unless message.client.are_emails_sent

    PostalWorker.perform_async(tracking_id)
  end

  private

  def message
    @message ||= Message.find_by_tracking_id @tracking_id
  end

  def reroute_message
    return if message.rerouted?

    message.body = rerouted_body
    message.subject = "[REROUTED] #{message.subject}"
    message.sender = ApplicationMailer::DEFAULT_FROM
    message.recipients.destroy_all
    message.recipients << message.client.reroute_recipient
    message.rerouted!
  end

  def rerouted_body
    ApplicationController.render(
      template: 'messages/reroute',
      assigns: { message: message },
      layout: false
    )
  end
end
