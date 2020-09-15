# frozen_string_literal: true

# Takes a MessageID and sends the message to the approperate destination
class SupscriberUploadWorker
  include Sidekiq::Worker

  def perform(attachment_id)
    @tracking_id = attachment_id

    return if message.sent?

    ApiMailer.with(message: message).send_message.deliver_now
    message.processed!
  end

  private

  def message
    @message ||= Message.find_by_tracking_id @tracking_id
  end
end
