# frozen_string_literal: true

module NotificationHandlers
  class SubscribeHandler < BaseNotificationHandler
    def handle
      Net::HTTP.get_response(subscribe_uri).is_a? Net::HTTPSuccess
    end

    private

    def subscribe_uri
      @subscribe_uri ||= URI @notification.subscribe_url
    end
  end
end
