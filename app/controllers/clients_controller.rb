# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[show edit update send_email]

  def index
    @clients = Client.order(name: :desc).page(params[:page]).per(15)
  end

  def new
    @client = Client.new(api_secret: SecureRandom.urlsafe_base64(64), api_key: SecureRandom.urlsafe_base64(64))
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash['success'] = t('created')
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def update
    if @client.update(client_params)
      flash['success'] = t('updated')
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def mail
    @message = AdhocEmailForm.new(email_params)
  end

  def messages
    @client = Client.includes(:messages).find(params[:client_id])
  end

  def subscribers
    @client = Client.includes(:subscribers).find(params[:client_id])
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
    params.require(:message).permit(:mailing_topic_id, :send_time, :template_id, :environment_id, :subject,
                                    :html_body, :text_body)
  end
end
