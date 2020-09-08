# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[show]

  def index
    @messages = Message.order(created_at: :desc).page(params[:page]).per(15)
  end

  private

  def set_message
    @message = Message.find_by_tracking_id(params[:tracking_id])
  end
end
