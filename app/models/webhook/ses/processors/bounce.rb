class Webhook::SES::Processors::Bounce < Webhook::SES::Processors::Base
  def process
    ban_recipient reason: "Bounced"

    # the notification could contain multiple destinations
    # but Hermes only sends emails to a single recipient at a time
    bounced_destinations.each do |bounced_destination|
      recipient.activities.build(
        actioned_at: timestamp,
        actionable: Bounce.new(
          category: category,
          sub_category: sub_category,
          feedback_id: feedback_id,
          reporting_mta: reporting_mta,
          status: bounced_destination["status"],
          action: bounced_destination["action"],
          diagnostic_code: bounced_destination["diagnosticCode"]
        )
      )
      recipient.save!
    end
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["bounce"]["timestamp"]
  end

  def category
    @category ||= notification.message["bounce"]["bounceType"]
  end

  def sub_category
    @sub_category ||= notification.message["bounce"]["bounceSubType"]
  end

  def reporting_mta
    @reporting_mta ||= notification.message["bounce"]["reportingMTA"]
  end

  def bounced_destinations
    @bounced_destinations ||= notification.message["bounce"]["bounceddestinations"]
  end

  def feedback_id
    @feedback_id ||= notification.message["bounce"]["feedbackId"]
  end
end
