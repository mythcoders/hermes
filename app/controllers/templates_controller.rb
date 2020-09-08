# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: %i[show]

  def index
    @templates = Template.page(params[:page]).per(15)
  end

  private

  def set_template
    @template = Template.find_by_tracking_id(params[:tracking_id])
  end
end
