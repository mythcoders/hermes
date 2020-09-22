# frozen_string_literal: true

class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: %i[show edit update]

  def new
    @template = Template.new(client_id: params[:client_id])
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      flash['success'] = t('created')
      redirect_to client_path(@template.client_id)
    else
      render 'new'
    end
  end

  def update
    if @template.update(template_params)
      flash['success'] = t('updated')
      redirect_to client_path(@template.client_id)
    else
      render 'edit'
    end
  end

  private

  def set_template
    @template = Template.find params[:id]
  end

  def template_params
    params.require(:template).permit(:client_id, :name, :sender_name, :sender_address, :html_body, :text_body,
                                     :json_layout, :active)
  end
end
