# frozen_string_literal: true

module Api
  class NotificationsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :verify_notification

    def new
      NotificationProcessor.new(request_data).process

      head :ok
    rescue => e
      head :internal_server_error
      raise e
    end

    private

    def request_data
      if request.content_type == "text/plain"
        JSON.parse request.raw_post
      else
        params
      end
    end

    def verify_notification
      return if Rails.env.development?

      return head :bad_request unless Aws::SNS::MessageVerifier.new.authentic?(request.raw_post)
    end
  end
end
