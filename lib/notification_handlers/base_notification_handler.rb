# frozen_string_literal: true

module NotificationHandlers
  class BaseNotificationHandler
    def initialize(notification)
      @notification = notification
    end

    private

    def message
      @message ||= Message.find_by_tracking_id! @notification.tracking_id
    end
  end
end
