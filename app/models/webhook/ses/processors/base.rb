class Webhook::SES::Processors::Base
  def initialize(notification)
    @notification = notification
  end

  def self.run(notification)
    new(notification).process
  end

  private

  attr_reader :notification

  def recipient
    @recipient ||= Recipient.find_by_uuid! notification.tracking_id
  rescue ActiveRecord::RecordNotFound
    raise Webhook::SES::EmailNotFoundError, notification.tracking_id
  end

  def ban_recipient(reason:)
    Ban.log_later recipient.address, reason
  end
end
