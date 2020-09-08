# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: %i[show edit update]

  def index
    @templates = Template.page(params[:page]).per(15)
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      flash['success'] = t('created')
      redirect_to templates_path
    else
      render 'new'
    end
  end

  def update
    if @template.update(template_params)
      flash['success'] = t('updated')
      redirect_to templates_path
    else
      render 'edit'
    end
  end

  private

  def set_template
    @template = Template.find params[:id]
  end

  def template_params
    params.require(:template).permit(:client_id, :name, :description, :active)
  end
end
