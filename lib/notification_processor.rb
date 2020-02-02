# frozen_string_literal: true

# Processes notifications recived from AWS
class NotificationProcessor
  IGNORED_MESSAGE = 'Successfully validated SNS topic for Amazon SES event publishing.'
  HANDLER_MAPPINGS = {
    'SubscriptionConfirmation' => 'SubscribeHandler',
    'SubscriptionCancellation' => 'IgnoredHandler',
    'SubscriptionValidation' => 'IgnoredHandler',
    'Send' => 'SendHandler',
    'Bounce' => 'BounceHandler',
    'Delivery' => 'DeliveredHandler',
    'Click' => 'ClickHandler',
    'Open' => 'OpenedHandler',
    'Complaint' => 'ComplaintHandler',
    'Reject' => 'RejectHandler',
    'RenderingFailure' => 'RenderingFailureHandler'
  }.freeze

  def initialize(notification_request)
    @notification = notification_request
    throw "No handler for NotificationType: #{notification_type}" unless HANDLER_MAPPINGS.key?(notification_type)

    @handler = "NotificationHandlers::#{HANDLER_MAPPINGS[notification_type]}".constantize.new
  end

  def process
    @handler.handle @notification
  end

  private

  def notification_type
    if @notification['Type'] == 'Notification'
      return 'SubscriptionValidation' if @notification['Message'] == IGNORED_MESSAGE

      # treat the eventType as the notificationType
      JSON.parse(@notification['Message'])['eventType'].strip
    else
      @notification['Type']
    end
  end
end
