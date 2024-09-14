class Webhook::SES::Processors::Reject < Webhook::SES::Processors::Base
  def process
    destination.callbacks.create!(
      callback_type: :rejected,
      callback_timestamp: Time.current,
      reject_reason: reject_reason
    )
  end

  private

  def reject_reason
    @reject_reason ||= notification.message["reject"]["reason"]
  end
end
