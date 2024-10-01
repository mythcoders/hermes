class Webhook::SES::Processors::Reject < Webhook::SES::Processors::Base
  def process
    recipient.activities.build(
      performed_at: timestamp,
      action: Rejection.new(reason: reject_reason)
    )
    recipient.save!
  end

  private

  def reject_reason
    @reject_reason ||= notification.message["reject"]["reason"]
  end
end
