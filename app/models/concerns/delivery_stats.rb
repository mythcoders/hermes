module DeliveryStats
  extend ActiveSupport::Concern

  def total_delivered_emails
    recipients.delivered.size
  end

  def total_opened_emails
    recipients.opened.size
  end

  def total_sent_emails
    recipients.sent.size
  end

  def total_clicked_emails
    recipients.clicked.size
  end

  def total_bounced_emails
    recipients.bounced.size
  end

  def total_complaint_emails
    recipients.complained.size
  end

  def delivery_rate
    return if total_sent_emails.zero?

    total_delivered_emails.to_f / total_sent_emails.to_f * 100
  end

  def open_rate
    return if total_delivered_emails.zero?

    total_opened_emails.to_f / total_delivered_emails.to_f * 100
  end

  def click_rate
    return if total_opened_emails.zero?

    total_clicked_emails.to_f / total_opened_emails.to_f * 100
  end

  def bounce_rate
    return if total_sent_emails.zero?

    total_bounced_emails.to_f / total_sent_emails.to_f * 100
  end

  def complaint_rate
    return if total_opened_emails.zero?

    total_complaint_emails.to_f / total_opened_emails.to_f * 100
  end
end
