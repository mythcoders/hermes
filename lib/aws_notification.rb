# frozen_string_literal: true

class AwsNotification
  IGNORED_MESSAGE = "Successfully validated SNS topic for Amazon SES event publishing."

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def type
    @type ||= if @raw_data["Type"] == "Notification"
      return "SubscriptionValidation" if @raw_data["Message"] == IGNORED_MESSAGE

      # treat the eventType as the notificationType
      message["eventType"].strip
    else
      @raw_data["Type"]
    end
  end

  def tracking_id
    @tracking_id ||= headers.find { |header| header["name"] == "X-Hermes-ID" }["value"]
  end

  def message
    @message ||= JSON.parse(@raw_data["Message"])
  end

  def subscribe_url
    @subscribe_url ||= @raw_data["SubscribeURL"]
  end

  private

  def headers
    @headers ||= message["mail"]["headers"]
  end
end
