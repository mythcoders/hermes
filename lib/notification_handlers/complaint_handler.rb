# frozen_string_literal: true

module NotificationHandlers
  class ComplaintHandler < BaseNotificationHandler
    def handle
      new_callback.tap do |callback|
        complaint_recipients.each do |complaint_recipient|
          recipient = transaction.recipients.find_by_email(complaint_recipient['emailAddress']).first
          next if recipient.nil?

          callback.email_callback_details << EmailCallbackDetail.new(
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
      @timestamp ||= DateTime.parse aws_callback.message['complaint']['timestamp']
    end

    def arrival_date
      @arrival_date ||= DateTime.parse aws_callback.message['complaint']['arrivalDate']
    end

    def user_agent
      @user_agent ||= aws_callback.message['complaint']['userAgent']
    end

    def complaint_type
      @complaint_type ||= aws_callback.message['complaint']['complaintFeedbackType']
    end

    def feedback_id
      @feedback_id ||= aws_callback.message['complaint']['feedbackId']
    end

    def complaint_recipients
      @complaint_recipients ||= aws_callback.message['complaint']['complainedRecipients']
    end
  end
end
