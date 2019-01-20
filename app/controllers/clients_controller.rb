# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[show edit update]

  def index
    @clients = Client.order(name: :desc).page(params[:page]).per(15)
  end

  def new
    @client = Client.new(api_secret: Hermes::KeyGenerator.new, api_key: Hermes::KeyGenerator.new)
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash['success'] = t('created')
      redirect_to clients_path
    else
      render 'new'
    end
  end

  def update
    if @client.update(client_params)
      flash['success'] = t('updated')
      redirect_to clients_path
    else
      render 'edit'
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:id, :name, :owner, :reroute_email, :api_secret, :api_key, :is_active,
                                   :are_emails_sent)
  end
end
