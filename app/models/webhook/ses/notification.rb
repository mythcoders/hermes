class Webhook::SES::Notification
  SUCCESSFUL_VALIDATION_MSG = "Successfully validated SNS topic for Amazon SES event publishing.".freeze
  PROCESSOR_MAPPING = {
    "AmazonSnsSubscriptionSucceeded" => Webhook::SES::Processors::Ignored,
    "Bounce" => Webhook::SES::Processors::Bounce,
    "Click" => Webhook::SES::Processors::Click,
    "Complaint" => Webhook::SES::Processors::Complaint,
    "Delivery" => Webhook::SES::Processors::Delivered,
    "DeliveryDelay" => Webhook::SES::Processors::DeliveryDelay,
    "Open" => Webhook::SES::Processors::Opened,
    "Reject" => Webhook::SES::Processors::Reject,
    "RenderingFailure" => Webhook::SES::Processors::Ignored,
    "Send" => Webhook::SES::Processors::Send,
    "SubscriptionCancellation" => Webhook::SES::Processors::Ignored,
    "SubscriptionConfirmation" => Webhook::SES::Processors::Subscribe,
    "SubscriptionValidation" => Webhook::SES::Processors::Ignored
  }.freeze

  def initialize(raw_json)
    @json_data ||= ActiveSupport::JSON.decode(raw_json).tap do |data|
      data["Message"] = ActiveSupport::JSON.decode(data["Message"])
    rescue JSON::ParserError
      {}
    end
  end

  attr_reader :json_data

  def process_now
    PROCESSOR_MAPPING[event_type].run(self)
  end

  def event_type
    @event_type ||= if json_data["Type"] == "Notification"
      return "SubscriptionValidation" if json_data["Message"] == SUCCESSFUL_VALIDATION_MSG

      if message["notificationType"]
        message["notificationType"].strip
      else
        message["eventType"].strip
      end
    else
      json_data["Type"]
    end
  end

  def tracking_id
    return nil if headers.empty?

    @tracking_id ||= tracking_header&.dig("value")
  end

  def message
    @message ||= json_data["Message"]
  end

  def headers
    return [] if event_type == "SubscriptionConfirmation"

    @headers ||= message["mail"]["headers"]
  end

  def tracking_header
    @tracking_header ||= headers.find { |h| h["name"] == "X-Hermes-DestinationId" }
  end
end
