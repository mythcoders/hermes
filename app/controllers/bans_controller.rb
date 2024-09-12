class BansController < ApplicationController
  before_action :set_ban, only: %i[show edit update destroy]

  def index
    @bans = Ban.all
  end

  def new
    @ban = Ban.new
  end

  def create
    @ban = Ban.new(ban_params)

    if @ban.save
      redirect_to @ban, notice: "Ban was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ban.update(ban_params)
      redirect_to @ban, notice: "Ban was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ban.destroy!
    redirect_to bans_url, notice: "Ban was successfully destroyed.", status: :see_other
  end

  private

  def set_ban
    @ban = Ban.find(params[:id])
  end

  def ban_params
    params.require(:ban).permit(:address, :reason)
  end
end
