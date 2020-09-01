# frozen_string_literal: true

class ApiMailer < ApplicationMailer
  def send_message
    @message = params[:message]
    append_hermes_headers

    mail(mail_headers) do |format|
      format.html { render plain: @message.body }
      format.text { render plain: @message.body }
    end
  end

  private

  def append_hermes_headers
    headers 'X-Hermes-ID': @message.tracking_id
    headers 'X-Priority': '1', 'Importance': 'high' if @message.priority.present?
    headers 'X-SES-CONFIGURATION-SET': ENV['SES_CONFIGSET'] || 'Hermes'
  end

  def mail_headers
    {
      subject: @message.subject,
      to: @message.to.map(&:email),
      from: @message.sender ||= DEFAULT_FROM,
      cc: @message.cc.map(&:email),
      bcc: @message.bcc.map(&:email),
      reply_to: DEFAULT_REPLY
    }
  end
end
