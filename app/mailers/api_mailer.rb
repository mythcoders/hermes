# frozen_string_literal: true

class ApiMailer < ApplicationMailer
  def send_message
    @message = params[:message]
    append_hermes_headers

    mail(mail_headers) do |format|
      format.html { render plain: @message.html_body }
      format.text { render plain: @message.text_body }
    end
  end

  private

  def append_hermes_headers
    headers 'X-Hermes-ID': @message.tracking_id
    headers 'X-Priority': "1", Importance: "high" if @message.priority.present?
    headers 'X-SES-CONFIGURATION-SET': ENV["SES_CONFIGSET"] || "Hermes"
  end

  def mail_headers
    {
      subject: @message.subject,
      from: @message.from,
      reply_to: @message.from,
      to: @message.to
    }
  end
end
