# frozen_string_literal: true

module NotificationHandlers
  class ComplaintHandler < BaseNotificationHandler
    def handle
      new_callback.tap do |callback|
        complaint_recipients.each do |complaint_recipient|
          recipient = transaction.recipients.find_by_email(complaint_recipient["emailAddress"]).first
          next if recipient.nil?

          callback.recipients << MessageActivityRecipient.new(
            recipient: recipient
          )
        end

        callback.save!
      end
    end

    private

    def new_callback
      MessageActivity.new(activity_type: :complaint,
        message: message,
        notification_timestamp: timestamp,
        complaint_type: complaint_type,
        user_agent: user_agent,
        complaint_arrival_date: arrival_date,
        feedback_id: feedback_id)
    end

    def timestamp
      @timestamp ||= DateTime.parse @notification.message["complaint"]["timestamp"]
    end

    def arrival_date
      @arrival_date ||= DateTime.parse @notification.message["complaint"]["arrivalDate"]
    end

    def user_agent
      @user_agent ||= @notification.message["complaint"]["userAgent"]
    end

    def complaint_type
      @complaint_type ||= @notification.message["complaint"]["complaintFeedbackType"]
    end

    def feedback_id
      @feedback_id ||= @notification.message["complaint"]["feedbackId"]
    end

    def complaint_recipients
      @complaint_recipients ||= @notification.message["complaint"]["complainedRecipients"]
    end
  end
end
