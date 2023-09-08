class MuchoGuestsController < ApplicationController
  def index
    @mucho_guests = MuchoGuest.all
    render :index
  end

  def show
    @mucho_guest = MuchoGuest.find(params[:id])
    render :show
  end

  def create
    @mucho_guest = MuchoGuest.new(mucho_guest_params)
    if @mucho_guest.save
      render :create
    else
      render json: { errors: @mucho_guest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @mucho_guest = MuchoGuest.find(params[:id])
    if @mucho_guest.update(mucho_guest_params)
      render :update
    else
      render json: { errors: @mucho_guest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @mucho_guest = MuchoGuest.find(params[:id])
    if @mucho_guest.delete
      render :destroy
    else
      render json: { errors: @mucho_guest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def mucho_guest_params
    params.require(:mucho_guests).permit(
      :amigo_id,
      :party_id
    )
  end
end