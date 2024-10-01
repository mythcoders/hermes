class SendersController < ApplicationController
  before_action :set_sender, only: %i[show edit update destroy]

  def index
    @senders = Sender.all
  end

  def new
    @sender = Sender.new
  end

  def create
    @sender = Sender.new(sender_params)

    if @sender.save
      redirect_to @sender, notice: "Sender was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sender.update(sender_params)
      redirect_to @sender, notice: "Sender was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sender.destroy!
    redirect_to senders_url, notice: "Sender was successfully destroyed.", status: :see_other
  end

  private

  def set_sender
    @sender = Sender.find(params[:id])
  end

  def sender_params
    params.require(:sender).permit(:name, :state, :address)
  end
end
