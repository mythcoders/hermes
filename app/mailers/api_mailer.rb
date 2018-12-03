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
                    format.html { render mail_params[:template] } if mail_params[:content_type] == 'html'
                    format.text { render mail_params[:template] } if mail_params[:content_type] == 'text'
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
    if client.are_emails_sent
      mail_params[:was_rerouted] = false
      mail_params[:template] = 'regular'
    else
      mail_params[:to] = [client.reroute_email]
      mail_params[:from] = ApplicationMailer::DEFAULT_FROM
      mail_params[:cc] = []
      mail_params[:bcc] = []
      mail_params[:subject] = "[Rerouted email] #{params[:subject]}"
      mail_params[:was_rerouted] = true
      mail_params[:template] = 'reroute'
    end
    mail_params
  end
end
