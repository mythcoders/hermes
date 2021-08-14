# frozen_string_literal: true

# Processes notifications recived from AWS
class NotificationProcessor
  UnknownNotificationError = Class.new(StandardError)
  HANDLER_MAPPINGS = {
    "SubscriptionConfirmation" => "SubscribeHandler",
    "SubscriptionCancellation" => "IgnoredHandler",
    "SubscriptionValidation" => "IgnoredHandler",
    "Send" => "SendHandler",
    "Bounce" => "BounceHandler",
    "Delivery" => "DeliveredHandler",
    "Click" => "ClickHandler",
    "Open" => "OpenedHandler",
    "Complaint" => "ComplaintHandler",
    "Reject" => "RejectHandler",
    "RenderingFailure" => "RenderingFailureHandler"
  }.freeze

  def initialize(raw_data)
    @notification = AwsNotification.new raw_data
    raise UnknownNotificationError unless valid_notification?
  end

  def process
    handler.handle
  end

  private

  def handler
    @handler ||= "NotificationHandlers::#{handler_name}".constantize.new(@notification)
  end

  def handler_name
    HANDLER_MAPPINGS[@notification.type]
  end

  def valid_notification?
    HANDLER_MAPPINGS.key?(@notification.type)
  end
end
