# frozen_string_literal: true

class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :validate_api_credentials
  before_action :set_mail

  def send_mail
    return head :bad_request unless @mail.valid?

    if @mail.was_rerouted
      ApiMailer.with(mail: @mail).reroute.deliver_now
    else
      ApiMailer.with(mail: @mail).regular.deliver_now
    end

    if @mail.save
      head :created
    else
      head :error
    end
  end

  private

  def set_mail
    @mail = MailLog.new(mail_params.merge(client: @current_user))
    @mail.was_rerouted = !@mail.client.are_emails_sent
  end

  def mail_params
    params.permit(:content_type, :subject, :body, :to, :from, cc: [], bcc: [])
  end

  def validate_api_credentials
    @current_user = authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    return head :unauthorized unless @current_user

    head :forbidden unless @current_user.is_active
  end
end
