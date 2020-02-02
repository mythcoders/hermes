# frozen_string_literal: true

module NotificationHandlers
  class BaseNotificationHandler
    def handle(_request)
      false
    end

    private

    def destination
      @raw_request.mail.destination
    end
  end
end
