# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, except: %i[index]

  def index
    @messages = Message.order(created_at: :desc).page(params[:page])
  end

  def logs
    @logs = @message.user_activity.order(created_at: :desc).page(params[:page])
  end

  def preview
    render :preview, layout: false, cached: false
  end

  def recipients
    @recipients = @message.recipients.includes(:activities).order(created_at: :desc).page(params[:page])
  end

  private

  def set_message
    @message = Message.find_by_tracking_id(params[:message_tracking_id] || params[:tracking_id])
  end
end
