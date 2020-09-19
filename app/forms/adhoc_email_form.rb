# frozen_string_literal: true

class AdhocEmailForm < ApplicationForm
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
      html_body: render_html,
      text_body: render_text,
      sender: template.sender,
      bcc: recipients
    }
  end

  def render_text
    return text_body unless template

    Mustache.render(template.text_body, { body: text_body })
  end

  def render_html
    return html_body unless template

    Mustache.render(template.html_body, { body: html_body })
  end

  def recipients
    mailing_topic.subscriptions.active.map do |sub|
      sub.subscriber.formatted_address
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
