class Webhook::SES::Processors::Complaint < Webhook::SES::Processors::Base
  def process
    complaint_destinations.each do |complaint_destination|
      destination.complained_at = timestamp
      destination.activities.build(
        actioned_at: timestamp,
        actionable: Complaint.new(
          category: complaint_type,
          user_agent: user_agent,
          arrived_at: arrival_date,
          feedback_id: feedback_id
        )
      )
      destination.save!
    end
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["complaint"]["timestamp"]
  end

  def arrival_date
    @arrival_date ||= Time.iso8601 notification.message["complaint"]["arrivalDate"]
  end

  def user_agent
    @user_agent ||= notification.message["complaint"]["userAgent"]
  end

  def complaint_type
    @complaint_type ||= notification.message["complaint"]["complaintFeedbackType"]
  end

  def feedback_id
    @feedback_id ||= notification.message["complaint"]["feedbackId"]
  end

  def complaint_destinations
    @complaint_destinations ||= notification.message["complaint"]["complaineddestinations"]
  end
end
