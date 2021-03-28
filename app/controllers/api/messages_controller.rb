# frozen_string_literal: true

module Api
  class MessagesController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :validate_api_credentials
    before_action :validate_api_environment

    rescue_from ActionController::ParameterMissing do
      head :bad_request
    end

    def new
      message = Message.build(mail_params, @client)
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
      @client = authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
      return head :unauthorized unless @client

      head :forbidden unless @client.is_active
    end

    def validate_api_environment
      return unless mail_params[:environment]

      head :method_not_allowed if client_environment.status == "rejected"
    end

    def client_environment
      @client_environment ||= ClientEnvironment.find_or_create_by_env!(@client, mail_params[:environment])
    end
  end
end
