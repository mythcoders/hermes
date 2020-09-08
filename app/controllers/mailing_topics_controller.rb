# frozen_string_literal: true

class MailingTopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show edit update]

  def index
    @topics = MailingTopic.page(params[:page]).per(15)
  end

  def new
    @topic = MailingTopic.new
  end

  def create
    @topic = MailingTopic.new(topic_params)
    if @topic.save
      flash['success'] = t('created')
      redirect_to mailing_topics_path
    else
      render 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      flash['success'] = t('updated')
      redirect_to mailing_topics_path
    else
      render 'edit'
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
