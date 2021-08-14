# frozen_string_literal: true

class MailingTopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show edit update]

  def new
    @topic = MailingTopic.new(client_id: params[:client_id])
  end

  def create
    @topic = MailingTopic.new(topic_params)
    if @topic.save
      flash["success"] = t("created")
      redirect_to client_path(@topic.client_id)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      flash["success"] = t("updated")
      redirect_to client_path(@topic.client_id)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def set_topic
    @topic = MailingTopic.find params[:id]
  end

  def topic_params
    params.require(:mailing_topic).permit(:client_id, :name, :description, :active)
  end
end
