class ApiController < ApplicationController
  InvalidApiClientError = Class.new(StandardError)

  before_action :validate_api_credentials

  rescue_from InvalidApiClientError, with: :invalid_api_credentials

  def send
    head :ok
  end

  private

  def mail_params
    params.require(:mail).permit(
      :api_secret,
      :api_key,
      :cc,
      :bcc,
      :type,
      :subject,
      :body,
      :to,
      :from,
      cc: [],
      bcc: []
    )
  end

  def validate_api_credentials
    return if Client.valid?(mail_params[:api_key], mail_params[:api_secret])

    raise InvalidApiClientError
  end

  def invalid_api_credentials

  end
end
