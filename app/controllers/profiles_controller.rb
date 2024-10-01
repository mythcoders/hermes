class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy]

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to @profile, notice: "Profile was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy!
    redirect_to profiles_url, notice: "Profile was successfully destroyed.", status: :see_other
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:sender_id, :name, :state, :regex, :reroute_address, :reply_to_address)
  end
end
