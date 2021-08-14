# frozen_string_literal: true

class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber, only: %i[show edit update]
  before_action :set_client, only: %i[index]

  def index
    @subscribers = @client.subscribers.order(created_at: :desc).page(params[:page])
  end

  def new
    @subscriber = Subscriber.new(client_id: params[:client_id])
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash["success"] = t("created")
      redirect_to client_subscribers_path(@subscriber.client_id)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      flash["success"] = t("updated")
      redirect_to client_subscribers_path(@subscriber.client_id)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_subscriber
    @subscriber = Subscriber.find params[:id]
  end

  def subscriber_params
    params.require(:subscriber).permit(:client_id, :name, :address)
  end
end
