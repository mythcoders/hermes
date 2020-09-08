# frozen_string_literal: true

class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber, only: %i[show]

  def index
    @subscribers = Subscriber.page(params[:page]).per(15)
  end

  private

  def set_subscriber
    @subscriber = Subscriber.find params[:id]
  end
end
