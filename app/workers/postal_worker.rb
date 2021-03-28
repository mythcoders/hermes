# frozen_string_literal: true

# Takes a MessageID and sends the message to the approperate destination
class PostalWorker
  include Sidekiq::Worker

  def perform(tracking_id)
    @tracking_id = tracking_id

    return if message.sent?

    message.recipients.each do |r|
      ApiMailer.with(message: build_params(message, r))
        .send_message
        .deliver_now
    end

    message.processed!
  end

  private

  def message
    @message ||= Message.includes(:recipients).find_by_tracking_id @tracking_id
  end

  def build_params(message, recipient)
    OpenStruct.new(
      from: message.sender ||= ApplicationMailer::DEFAULT_FROM,
      html_body: message.html_body,
      priority: message.priority,
      # reply_to: ApplicationMailer::DEFAULT_REPLY,
      subject: message.subject,
      text_body: message.text_body,
      to: recipient.email,
      tracking_id: message.tracking_id
    )
  end
end
