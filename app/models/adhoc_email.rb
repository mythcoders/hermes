class AdhocEmail
  include ActiveModel::Model
  attr_accessor :mailing_topic_id, :send_time, :template_id, :environment_id, :subject, :html_body, :text_body

  def save
    message = Message.build(mail_params, @current_user)

    message.received!
  rescue ActiveRecord::StatementInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)

    false
  end

  private

  def mail_params
    {
      environment: environment.name,
      subject: subject,
      html_body: full_html_body,
      text_body: full_text_body,
      sender: template.sender,
      bcc: recipients
    }
  end

  def full_html_body
    html_body + template.html_body
  end

  def full_text_body
    text_body + template.text_body
  end

  def recipients
    mailing_topic.subscriptions.active.map do |_sub|
      subscription.subscriber.formatted_address
    end
  end

  def mailing_topic
    @mailing_topic ||= MailingTopic.find mailing_topic_id
  end

  def template
    @template ||= Template.find template_id
  end

  def environment
    @environment ||= ClientEnvironment.find environment_id
  end
end
