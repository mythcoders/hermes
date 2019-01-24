# frozen_string_literal: true

class Api::MailController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :validate_api_credentials
  before_action :validate_params

  def new
    if ApiMailer.send_message(mail_params.merge(client: @current_user)).deliver_now
      head :created
    else
      head :error
    end
  end

  private

  def mail_params
    params.require(:mail).permit(:environment, :content_type, :subject, :body, :from, to: [], cc: [], bcc: [])
  end

  def validate_api_credentials
    @current_user = authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    return head :unauthorized unless @current_user
    # TODO: Add rate limiting
    head :forbidden unless @current_user.is_active
  end

  def validate_params
    return head :bad_request unless mail_params[:to].present?
    return head :bad_request unless mail_params[:subject].present?
    return head :bad_request unless mail_params[:environment].present?
  end
end
