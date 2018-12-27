# frozen_string_literal: true

class ApiMailer < ApplicationMailer
  def send_message(request_params)
    mail_params = convert_request_params request_params
    @message = MailLog.build(request_params)

    mailer = mail(mail_headers(mail_params)) do |format|
                    format.html { render layout: mail_params[:layout] } if @message.html?
                    format.text { render layout: mail_params[:layout] } if @message.text?
                  end
    log_mail mail_params.merge(body: mailer.body.decoded)
  end

  private

  def log_mail(mail_params)
    MailLog.build(mail_params).save!
  end

  def mail_headers(mail_params)
    {
      to: mail_params[:to],
      from: mail_params[:from] ||= DEFAULT_FROM,
      cc: mail_params[:cc],
      bcc: mail_params[:bcc],
      subject: mail_params[:subject],
      reply_to: DEFAULT_FROM
    }
  end

  def convert_request_params(params)
    mail_params = params.merge(tracking_id: SecureRandom.uuid)
    if mail_params[:client].are_emails_sent
      mail_params[:was_rerouted] = false
      mail_params[:layout] = 'mailer'
    else
      mail_params[:was_rerouted] = true
      mail_params[:layout] = 'reroute_mailer'
      mail_params[:to] = [mail_params[:client].reroute_email]
      mail_params[:from] = DEFAULT_FROM
      mail_params[:cc] = []
      mail_params[:bcc] = []
      mail_params[:subject] = "[REROUTED] #{params[:subject]}"
    end
    mail_params
  end
end
