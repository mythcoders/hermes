class Webhook::SES::Processors::Reject < Webhook::SES::Processors::Base
  def process
    destination.activities.build(
      actioned_at: timestamp,
      actionable: Rejection.new(reason: reject_reason)
    )
    destination.save!
  end

  private

  def reject_reason
    @reject_reason ||= notification.message["reject"]["reason"]
  end
end
