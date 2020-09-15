# frozen_string_literal: true

class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber, only: %i[show]

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash['success'] = t('created')
      redirect_to subscribers_path
    else
      render 'new'
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      flash['success'] = t('updated')
      redirect_to subscribers_path
    else
      render 'edit'
    end
  end

  private

  def set_subscriber
    @subscriber = Subscriber.find params[:id]
  end

  def subscriber_params
    params.require(:subscriber).permit(:client_id, :name, :address)
  end
end
