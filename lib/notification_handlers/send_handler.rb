# frozen_string_literal: true

module NotificationHandlers
  class SendHandler < BaseNotificationHandler
    def handle
      message.activities << MessageActivity.new(activity_type: :sent,
                                                notification_timestamp: timestamp)
      message.save
    end

    private

    def timestamp
      @timestamp ||= DateTime.parse @notification.message['mail']['timestamp']
    end
  end
end
