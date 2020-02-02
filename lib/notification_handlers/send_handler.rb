# frozen_string_literal: true

module NotificationHandlers
  class SendHandler < BaseNotificationHandler
    def handle(request)
      @raw_request = request

      destination.each do |_resp|
        MessageActivity.new
      end

      false
    end

    private

    def destination
      @raw_request.mail.destination
    end
  end
end
