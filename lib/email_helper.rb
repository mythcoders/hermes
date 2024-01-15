module EmailHelper
  def self.delivering_email(message)
    message.to = ["justin@mythcoders.com"]
    message.subject = "[REROUTED] #{message.subject}"
  end

  def self.delivered_email(message)
    recipients = Array(message.to) + Array(message.bcc) + Array(message.cc)

    EmailLog.create!(
      subject: message.subject,
      recipients: recipients.join(", ")
    )
  end
end
