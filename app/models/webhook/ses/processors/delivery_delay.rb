class Webhook::SES::Processors::DeliveryDelay < Webhook::SES::Processors::Base
  def process
    delayed_destinations.each do |destination|
      recipient.activities.create!(
        performed_at: timestamp,
        action: Delay.new(
          category: delay_type,
          expiration_time: expiration_time,
          status: destination["status"],
          diagnostic_code: destination["diagnosticCode"]
        )
      )
    end
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["deliveryDelay"]["timestamp"]
  end

  def delay_type
    @delay_type ||= notification.message["deliveryDelay"]["delayType"]
  end

  def expiration_time
    @expiration_time ||= Time.iso8601 notification.message["deliveryDelay"]["expirationTime"]
  end

  def delayed_destinations
    @delayed_destinations ||= notification.message["deliveryDelay"]["delayeddestinations"]
  end
end
