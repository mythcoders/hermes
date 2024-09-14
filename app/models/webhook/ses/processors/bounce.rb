class Webhook::SES::Processors::Bounce < Webhook::SES::Processors::Base
  def process
    ban_destination reason: "Bounced"

    # the notification could contain multiple destinations
    # but Hermes only sends emails to a single destination at a time
    bounced_destinations.each do |bounced_destination|
      destination.callbacks.create!(
        callback_type: :bounced,
        bounce_type: bounce_type,
        bounce_subtype: bounce_subtype,
        feedback_id: feedback_id,
        reporting_mta: reporting_mta,
        status: bounced_destination["status"],
        action: bounced_destination["action"],
        diagnostic_code: bounced_destination["diagnosticCode"]
      )
    end
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["bounce"]["timestamp"]
  end

  def bounce_type
    @bounce_type ||= notification.message["bounce"]["bounceType"]
  end

  def bounce_subtype
    @bounce_subtype ||= notification.message["bounce"]["bounceSubType"]
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
