class API::MessagesController < API::ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :validate_api_credentials
  before_action :validate_sender_profile

  rescue_from ActionController::ParameterMissing do
    head :bad_request
  end

  def new
    message = Message.build(mail_params, @sender)
    return render(json: message.errors, status: :bad_request) unless message.valid?
    return head :error unless message.received!

    MailSortJob.perform_later message.tracking_id
    head :created
  end

  private

  def mail_params
    params.require(:message).permit(:from, :subject, :html_body, :text_body, :profile, to: [], cc: [], bcc: [])
  end

  def validate_api_credentials
    @sender = authenticate_with_http_basic { |u, p| Sender.authenticate(u, p) }
    return head :unauthorized unless @sender

    head :forbidden unless @sender.is_active
  end

  def validate_sender_profile
    return unless mail_params[:profile]

    head :method_not_allowed if profile.rejected?
  end

  def profile
    @profile ||= Profile.find_or_create_from_api(@sender, mail_params[:profile])
  end
end
