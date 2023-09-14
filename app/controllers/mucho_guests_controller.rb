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

  def mucho_amigos
    @mucho_guest = MuchoGuest.find(params[:id])
    @amigos = @mucho_guest.mucho_amigo # assumes mucho_amigo is accessible through mucho_guest
    render json: { amigos: @amigos.as_json }
  end

  def mucho_parties
    @mucho_guest = MuchoGuest.find(params[:id])
    @parties = @mucho_guest.mucho_party
    puts @parties.inspect
    render json: { parties: @parties }
  end

  def associated_parties
    # Assuming you've passed the MuchoGuest ID as :id in the route
    mucho_guest = MuchoGuest.find(params[:id])
  
    # If the record exists, find all the parties that the associated MuchoAmigo is a part of.
    if mucho_guest
      all_parties_for_amigo = mucho_guest.mucho_amigo.mucho_parties
      render json: all_parties_for_amigo
    else
      render json: { error: 'MuchoGuest not found' }, status: :not_found
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