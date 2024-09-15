class Webhook < ApplicationRecord
  enum :status, %w[pending errored finished].index_by(&:itself), default: :pending

  validates :status, presence: true
  validates :subject, presence: true
  validates :raw_data, presence: true

  after_create_commit :process_later

  def process_now
    return if finished? || errored?

    if processor.process_now
      finished!
    else
      errored!
    end
  rescue Webhook::SES::MessageNotFoundError
    finished!
  end

  def process_later
    Webhook::ProcessJob.perform_later(id)
  end

  private

  def processor
    case subject
    when "aws-ses"
      Webhook::SES::Notification.new(raw_data)
    else
      raise StandardError, "VendorWebhook subject is unknown: #{subject}"
    end
  end
end
