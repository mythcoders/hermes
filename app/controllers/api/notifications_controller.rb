# frozen_string_literal: true

module Api
  class NotificationsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :verify_notification

    def new
      NotificationWorker.perform_async(params)

      head :ok
    end

    private

    def verify_notification
      return head :bad_request unless Aws::SNS::MessageVerifier.new.authentic?(request.raw_post)
    end
  end
end
