# frozen_string_literal: true

module NotificationHandlers
  class BounceHandler < BaseNotificationHandler
    def handle
      new_callback.tap do |callback|
        bounced_recipients.each do |bounced_recipient|
          recipient = message.recipients.find_by_email(bounced_recipient["emailAddress"]).first
          next if recipient.nil?

          callback.recipients << MessageActivityRecipient.new(
            recipient: recipient,
            status: bounced_recipient["status"],
            action: bounced_recipient["action"],
            diagnostic_code: bounced_recipient["diagnosticCode"]
          )
        end

        callback.save!
      end
    end

    private

    def new_callback
      MessageActivity.new(activity_type: :bounce,
        message: message,
        notification_timestamp: timestamp,
        bounce_type: bounce_type,
        bounce_subtype: bounce_subtype,
        feedback_id: feedback_id,
        reporting_mta: reporting_mta)
    end

    def timestamp
      @timestamp ||= DateTime.parse @notification.message["bounce"]["timestamp"]
    end

    def bounce_type
      @bounce_type ||= @notification.message["bounce"]["bounceType"]
    end

    def bounce_subtype
      @bounce_subtype ||= @notification.message["bounce"]["bounceSubType"]
    end

    def reporting_mta
      @reporting_mta ||= @notification.message["bounce"]["reportingMTA"]
    end

    def bounced_recipients
      @bounced_recipients ||= @notification.message["bounce"]["bouncedRecipients"]
    end

    def feedback_id
      @feedback_id ||= @notification.message["bounce"]["feedbackId"]
    end
  end
end
