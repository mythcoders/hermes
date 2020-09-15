# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = Subscription.page(params[:page]).per(15)
  end
end
