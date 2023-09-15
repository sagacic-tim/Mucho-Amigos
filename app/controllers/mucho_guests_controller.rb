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

  def party_guest_details
    begin
      mucho_guest = MuchoGuest.find(params[:id])
      party_guest = mucho_guest.mucho_amigo # assumes mucho_amigo is accessible through mucho_guest
      if party_guest.nil?
        render json: { message: "Associated Amigo does not exist." }, status: :not_found
        return
      end
      render json: { party_guest: party_guest.as_json }
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Amigo as Party Guest not found" }, status: :not_found
    end
  end      

  def associated_parties
    # Assuming you've passed the MuchoGuest ID as :id in the route
    mucho_guest = MuchoGuest.find(params[:id])
  
    # If the record exists, find all the parties that the associated MuchoAmigo is a part of.
    if mucho_guest
      all_parties_for_amigo = mucho_guest.mucho_amigo.mucho_parties
      render json: all_parties_for_amigo
    else
      render json: { error: 'Party Guest not found' }, status: :not_found
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