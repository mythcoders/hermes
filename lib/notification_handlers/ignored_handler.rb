# frozen_string_literal: true

module NotificationHandlers
  class IgnoredHandler
    def handle(_request)
      true
    end
  end
end