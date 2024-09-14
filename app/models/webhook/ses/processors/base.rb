class Webhook::SES::Processors::Base
  def initialize(notification)
    @notification = notification
  end

  def self.run(notification)
    new(notification).process
  end

  private

  attr_reader :notification

  def destination
    @destination ||= Destination.find_by_tracking_id! notification.tracking_id
  rescue ActiveRecord::RecordNotFound
    raise Webhook::SES::EmailNotFoundError, notification.tracking_id
  end

  def ban_destination(reason:)
    Ban.log_later destination.address, reason
  end
end
