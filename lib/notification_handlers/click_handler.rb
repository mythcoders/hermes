# frozen_string_literal: true

module NotificationHandlers
  class ClickHandler < BaseNotificationHandler
    def handle
      message = Message.find_by_tracking_id @notification.tracking_id
      message.activities << MessageActivity.new(activity_type: :clicked,
        notification_timestamp: timestamp,
        ip_address: ip_address,
        user_agent: user_agent,
        link_url: link)
      message.save
    end

    private

    def timestamp
      @timestamp ||= DateTime.parse @notification.message["click"]["timestamp"]
    end

    def user_agent
      @user_agent ||= @notification.message["click"]["userAgent"]
    end

    def ip_address
      @ip_address ||= @notification.message["click"]["ipAddress"]
    end

    def link
      @link ||= @notification.message["click"]["link"]
    end
  end
end
