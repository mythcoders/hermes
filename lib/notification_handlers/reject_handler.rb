# frozen_string_literal: true

module NotificationHandlers
  class RejectHandler < BaseNotificationHandler
    def handle
      MessageActivity.create!(message: message,
        callback_type: :reject,
        callback_timestamp: Time.zone.now,
        reject_reason: reject_reason)
    end

    private

    def reject_reason
      @reject_reason ||= aws_callback.message["reject"]["reason"]
    end
  end
end
