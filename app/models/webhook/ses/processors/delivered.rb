class Webhook::SES::Processors::Delivered < Webhook::SES::Processors::Base
  def process
    destination.delivered_at = timestamp unless destination.delivered?
    delivery_destinations.each do |delivery_destination|
      destination.callbacks << EmailCallback.new(
        callback_type: :delivered,
        callback_timestamp: timestamp,
        smtp_response: smtp_response,
        reporting_mta: reporting_mta
      )
    end
    destination.save!
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["delivery"]["timestamp"]
  end

  def smtp_response
    @smtp_response ||= notification.message["delivery"]["smtpResponse"]
  end

  def reporting_mta
    @reporting_mta ||= notification.message["delivery"]["reportingMTA"]
  end

  def delivery_destinations
    @delivery_destinations ||= notification.message["delivery"]["destinations"]
  end
end
