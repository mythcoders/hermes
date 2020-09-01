# frozen_string_literal: true

module NotificationHandlers
  class IgnoredHandler < BaseNotificationHandler
    def handle
      Raven.capture_message("Ignored EmailCallback of type #{aws_callback.type}", level: :info)

      true
    end
  end
end
