class BansController < ApplicationController
  before_action :set_ban, only: %i[show edit update destroy]

  # GET /bans
  def index
    @bans = Ban.all
  end

  # GET /bans/1
  def show
  end

  # GET /bans/new
  def new
    @ban = Ban.new
  end

  # GET /bans/1/edit
  def edit
  end

  # POST /bans
  def create
    @ban = Ban.new(ban_params)

    if @ban.save
      redirect_to @ban, notice: "Ban was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bans/1
  def update
    if @ban.update(ban_params)
      redirect_to @ban, notice: "Ban was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bans/1
  def destroy
    @ban.destroy!
    redirect_to bans_url, notice: "Ban was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ban
    @ban = Ban.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ban_params
    params.require(:ban).permit(:address, :reason)
  end
end
