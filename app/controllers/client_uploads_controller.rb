# frozen_string_literal: true

class ClientUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: %i[show edit update]

  def new
    @upload = ClientUpload.new(client_id: params[:client_id])
  end

  def upload_subscribers
    @client = Client.includes(:topics).find(params[:client_id])
    return unless params[:client_upload]

    @client.file_uploads.attach(upload_params)
    flash[:success] = "something"
    # Worker.perform_async 1
    # params[:client_upload][:file]
  end

  def create
    @upload = ClientUpload.new(upload_params)
    @upload.data_file.attach(file_blob_param)
    if @upload.save
      flash["success"] = t("created")
      redirect_to client_path(@upload.client_id)
    else
      render "new"
    end
  end

  def update
    if @upload.update(upload_params)
      flash["success"] = t("updated")
      redirect_to client_path(@upload.client_id)
    else
      render "edit"
    end
  end

  private

  def set_upload
    @upload = ClientUpload.find params[:id]
  end

  def upload_params
    params.require(:client_upload).permit(:client_id, :file_type)
  end

  def file_blob_param
    params[:client_upload][:file]
  end
end
