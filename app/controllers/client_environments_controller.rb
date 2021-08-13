# frozen_string_literal: true

class ClientEnvironmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_environment, only: %i[show edit update]

  def new
    @environment = ClientEnvironment.new(client_id: params[:client_id])
  end

  def create
    @environment = ClientEnvironment.new(environment_params)
    if @environment.save
      flash["success"] = t("created")
      redirect_to client_path(@environment.client_id)
    else
      render "new"
    end
  end

  def update
    if @environment.update(environment_params)
      flash["success"] = t("updated")
      redirect_to client_path(@environment.client_id)
    else
      render "edit"
    end
  end

  private

  def set_environment
    @environment = ClientEnvironment.find params[:id]
  end

  def environment_params
    params.require(:client_environment).permit(:client_id, :name, :status, :regex)
  end
end
