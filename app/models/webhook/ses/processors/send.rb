class Webhook::SES::Processors::Send < Webhook::SES::Processors::Base
  def process
    return true if recipient.sent?

    recipient.update(sent_at: timestamp)
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["mail"]["timestamp"]
  end
end
