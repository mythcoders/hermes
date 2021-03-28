# frozen_string_literal: true

module NotificationHandlers
  class DeliveredHandler < BaseNotificationHandler
    def handle
      recipients.each do |recipient|
        create_activity recipient
      end

      true
    end

    private

    def create_activity(email)
      recipient = message.recipients.where("email LIKE ?", "%#{email}%").first!
      recipient.delivered_at = timestamp
      recipient.activities << MessageActivity.new(activity_type: :delivered,
        message: message,
        notification_timestamp: timestamp,
        smtp_response: smtp_response,
        reporting_mta: reporting_mta)
      recipient.save
    end

    def timestamp
      @timestamp ||= DateTime.parse @notification.message["delivery"]["timestamp"]
    end

    def smtp_response
      @smtp_response ||= @notification.message["delivery"]["smtpResponse"]
    end

    def reporting_mta
      @reporting_mta ||= @notification.message["delivery"]["reportingMTA"]
    end

    def recipients
      @recipients ||= @notification.message["delivery"]["recipients"]
    end
  end
end
