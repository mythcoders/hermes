class Webhook::SES::Processors::Send < Webhook::SES::Processors::Base
  def process
    destination.sent_at = timestamp unless destination.sent?
    destination.callbacks << EmailCallback.new(
      callback_type: :sent,
      callback_timestamp: timestamp
    )
    destination.save!
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["mail"]["timestamp"]
  end
end
