# frozen_string_literal: true

# Takes a MessageID and sends the message to the approperate destination
class PostalWorker
  include Sidekiq::Worker

  def perform(tracking_id)
    @tracking_id = tracking_id

    return if message.sent?

    # TODO: Batch messages up by a max of 50 recipients

    ApiMailer.with(message: message).send_message.deliver_now
    message.processed!
  end

  private

  def message
    @message ||= Message.find_by_tracking_id @tracking_id
  end
end
