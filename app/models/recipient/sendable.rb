module Recipient::Sendable
  extend ActiveSupport::Concern

  def send_now
    return unless sending_enabled? && sender_approved?
    return if banned? || sent? || message.halted?

    # Mailer

    touch(:sent_at)
  rescue Net::SMTPSyntaxError, Mail::Field::IncompleteParseError
    ban_later "Invalid email address"
  end

  def send_later(deliver_at = Time.current)
    Recipient::SendJob.perform_at(time, id)
  end
end
