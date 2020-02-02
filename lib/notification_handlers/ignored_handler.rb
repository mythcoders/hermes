# frozen_string_literal: true

module NotificationHandlers
  class IgnoredHandler < BaseNotificationHandler
    def handle
      true
    end
  end
end
