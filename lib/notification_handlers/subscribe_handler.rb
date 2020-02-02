# frozen_string_literal: true

module NotificationHandlers
  class SubscribeHandler
    def handle(notification)
      url = URI(notification['SubscribeURL'])
      Net::HTTP.get_response(url).kind_of? Net::HTTPSuccess
    end
  end
end
