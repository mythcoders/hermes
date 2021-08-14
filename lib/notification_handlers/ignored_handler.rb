# frozen_string_literal: true

module NotificationHandlers
  class IgnoredHandler < BaseNotificationHandler
    def handle
      Sentry.capture_exception("Ignored EmailCallback of type #{@notification.type}", level: :info)

      true
    end
  end
end
