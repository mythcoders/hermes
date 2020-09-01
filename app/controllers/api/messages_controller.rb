# frozen_string_literal: true

module Api
  class MessagesController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :validate_api_credentials

    rescue_from ActionController::ParameterMissing do
      head :bad_request
    end

    def new
      message = Message.build(mail_params, @current_user)
      return render(json: message.errors, status: :bad_request) unless message.valid?
      return head :error unless message.received!

      MailSortWorker.perform_async message.tracking_id
      head :created
    end

    private

    def mail_params
      params.require(:message).permit(:environment, :subject, :html_body, :text_body, :sender, to: [], cc: [], bcc: [])
    end

    def validate_api_credentials
      @current_user = authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
      return head :unauthorized unless @current_user

      # TODO: Add rate limiting
      head :forbidden unless @current_user.is_active
    end
  end
end
