# frozen_string_literal: true

class MailingTopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: %i[show]

  def index
    @topics = MailingTopic.page(params[:page]).per(15)
  end

  private

  def set_topic
    @topic = MailingTopic.find params[:id]
  end
end
