class API::WebhooksController < API::ApplicationController
  before_action :verify_webhook

  def new
    callback = Webhook.new(subject: subject, raw_data: request.raw_post)
    callback.save!
    head :ok
  rescue Webhook::SES::MessageNotFoundError => e
    Sentry.capture_exception e
    head :no_content
  rescue => e
    Sentry.capture_exception e
    head :internal_server_error
    raise e
  end

  private

  def subject
    @subject ||= ActiveSupport::JSON.decode(request.raw_post).tap do |data|
      case data["Subject"]
      when "Amazon SES Email Event Notification"
        return "aws-ses"
      else
        return data["Subject"]
      end
    end
  end

  def verify_webhook
    return if Rails.env.development?

    head :bad_request unless Aws::SNS::MessageVerifier.new.authentic?(request.raw_post)
  end
end
