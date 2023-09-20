class MuchoAmigosController < ApplicationController
  def index
    @mucho_amigos = MuchoAmigo.all
    render :index
  end

  def show
    @mucho_amigo = MuchoAmigo.find(params[:id])
    render :show
  end

  # def create
  #   @mucho_amigo = MuchoAmigo.new(mucho_amigo_params)
  #   if @mucho_amigo.save
  #     render :create
  #   else
  #     render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  def create_party
    @mucho_party = MuchoParty.new(mucho_amigo_params)
    if @mucho_amigo.save
      render :create
    else
      render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def update
  #   @mucho_amigo = MuchoAmigo.find(params[:id])
  #   if @mucho_amigo.update(mucho_amigo_params)
  #     render :update
  #   else
  #     render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @mucho_amigo = MuchoAmigo.find(params[:id])
    if @mucho_amigo.delete
      render :destroy
    else
      render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def associated_parties
    amigo = MuchoAmigo.find(params[:id])
    associated_parties = amigo.mucho_parties
    render json: associated_parties
  end

  def parties_by_this_amigo_as_host
    begin
      party_host = MuchoAmigo.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { error: "MuchoAmigo not found, dumb ass" }, status: :not_found
      return
    end

    parties_by_this_amigo_as_host = party_host.parties_by_this_amigo_as_host

    if parties_by_this_amigo_as_host.empty?
      render json: { message: "This loser MuchoAmigo is not hosting any parties, WTF" }, status: :ok
    else
      render json: { parties_by_this_amigo_as_host: parties_by_this_amigo_as_host }, status: :ok
    end
  end

  def locations_for_host
    begin
      mucho_amigo = MuchoAmigo.find(params[:id])
      hosted_parties = mucho_amigo.hosted_parties
      locations = hosted_parties.map { |party| MuchoLocation.find(party.party_location_id) }
      
      if locations.empty?
        render json: { message: "This party host is not hosting any parties at any location." }, status: :ok
      else
        render json: { locations: locations }, status: :ok
      end
      
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Party Host with MuchoAmigo id #{params[:id]} was not found" }, status: :not_found
    rescue => e
      render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
    end
  end

  private

  def mucho_amigo_params
    params.require(:mucho_amigo).permit(
      :full_name,
      :user_name,
      :email,
      :phone,
      :address,
      :street_number,
      :street_name,
      :street_suffix, 
      :city,
      :state_abbreviation, 
      :country_code, 
      :postal_code,
      :latitude, 
      :longitude,
      :party_animal,
      :personal_bio
    )
  end
end