# frozen_string_literal: true

class ApiMailer < ApplicationMailer
  def send_message(params, client)
    params.merge(client: client)
    @message = MailLog.build(params)
    mail_params = convert_requested_params(params, client)

    mailer = mail(to: mail_params[:to],
                  from: mail_params[:from],
                  cc: mail_params[:cc],
                  bcc: mail_params[:bcc],
                  subject: mail_params[:subject]) do |format|
                    format.html { render layout: mail_params[:layout] } if @message.html?
                    format.text { render layout: mail_params[:layout] } if @message.text?
                  end
    log_mail mailer, mail_params
  end

  private

  def log_mail(mailer, params)
    log = MailLog.build(params)
    log.body = mailer.body.decoded
    log.save!
  end

  def convert_requested_params(params, client)
    mail_params = params.merge(client: client)
    mail_params[:tracking_id] = SecureRandom.uuid
    if client.are_emails_sent
      mail_params[:was_rerouted] = false
      mail_params[:layout] = 'mailer'
    else
      mail_params[:layout] = 'reroute_mailer'
      mail_params[:to] = [client.reroute_email]
      mail_params[:from] = ApplicationMailer::DEFAULT_FROM
      mail_params[:cc] = []
      mail_params[:bcc] = []
      mail_params[:subject] = "[REROUTED] #{params[:subject]}"
      mail_params[:was_rerouted] = true
    end
    mail_params
  end
end
