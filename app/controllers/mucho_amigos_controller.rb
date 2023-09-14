class MuchoAmigosController < ApplicationController
  def index
    @mucho_amigos = MuchoAmigo.all
    render :index
  end

  def show
    @mucho_amigo = MuchoAmigo.find(params[:id])
    render :show
  end

  def create
    @mucho_amigo = MuchoAmigo.new(mucho_amigo_params)
    if @mucho_amigo.save
      render :create
    else
      render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_party
    @mucho_party = MuchoParty.new(mucho_amigo_params)
    if @mucho_amigo.save
      render :create
    else
      render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @mucho_amigo = MuchoAmigo.find(params[:id])
    if @mucho_amigo.update(mucho_amigo_params)
      render :update
    else
      render json: { errors: @mucho_amigo.errors.full_messages }, status: :unprocessable_entity
    end
  end

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

  private

  def mucho_amigo_params
    params.require(:mucho_amigo).permit(
      :full_name,
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