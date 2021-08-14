# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: %i[edit update]

  def index
    @subscriptions = Subscription.includes(:subscriber, :topic).page(params[:page]).per(15)
  end

  def update
    if @subscription.update(subscription_params)
      flash["success"] = t("updated")
      redirect_to edit_subscription_path(@subscription.client_id)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find params[:id]
  end

  def subscription_params
    params.require(:subscription).permit(:status, :memo)
  end
end
