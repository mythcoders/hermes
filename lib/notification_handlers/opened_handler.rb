# frozen_string_literal: true

module NotificationHandlers
  class OpenedHandler < BaseNotificationHandler
    def handle
      message.activities << MessageActivity.new(activity_type: :opened,
        notification_timestamp: timestamp,
        ip_address: ip_address,
        user_agent: user_agent)
      message.save
    end

    private

    def timestamp
      @timestamp ||= DateTime.parse @notification.message["open"]["timestamp"]
    end

    def user_agent
      @user_agent ||= @notification.message["open"]["userAgent"]
    end

    def ip_address
      @ip_address ||= @notification.message["open"]["ipAddress"]
    end
  end
end
