# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[show edit update new_email messages subscribers]

  def index
    @clients = Client.order(name: :desc).page(params[:page]).per(15)
  end

  def new
    @client = Client.new(api_secret: SecureRandom.urlsafe_base64(64), api_key: SecureRandom.urlsafe_base64(64))
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash["success"] = t("created")
      redirect_to client_path(@client)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      flash["success"] = t("updated")
      redirect_to client_path(@client)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def new_email
    @message = AdhocEmailForm.new
  end

  def send_email
    @message = AdhocEmailForm.new(email_params)

    if @message.save!
      flash["success"] = t("updated")
      redirect_to client_path(params[:client_id])
    else
      flash["error"] = "Correct the errors"
      render "new_email", status: :unprocessable_entity
    end
  end

  def messages
    @messages = @client.messages.order(created_at: :desc).page(params[:page])
  end

  def subscribers
    @subscribers = @client.subscribers.order(created_at: :desc).page(params[:page])
  end

  private

  def set_client
    @client = Client.find(params[:id] || params[:client_id])
  end

  def client_params
    params.require(:client).permit(:id, :name, :owner, :reroute_email, :reply_to_email, :api_secret, :api_key,
      :is_active)
  end

  def email_params
    params.require(:adhoc_email_form).permit(:mailing_topic_id, :template_id, :environment_id, :subject, :html_body,
      :text_body)
  end
end
