class MuchoLocationsController < ApplicationController
  def index
    @mucho_locations = MuchoLocation.all
    render :index
  end

  def show
    @mucho_location = MuchoLocation.find(params[:id])
    render :show
  end

  def create
    @mucho_location = MuchoLocation.new(mucho_location_params)
    if @mucho_location.save
      render :create
    else
      render json: { errors: @mucho_location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @mucho_location = MuchoLocation.find(params[:id])
    if @mucho_location.update(mucho_location_params)
      render :update
    else
      render json: { errors: @mucho_location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @mucho_location = MuchoLocation.find(params[:id])
    if @mucho_location.delete
      render :destroy
    else
      render json: { errors: @mucho_location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mucho_parties
    begin
      mucho_location = MuchoLocation.find(params[:id])
      parties = mucho_location.mucho_parties
      render json: { mucho_parties: parties }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "MuchoLocation with id #{params[:id]} not found" }, status: :not_found
      rescue => e
        render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
    end
  end

  private

  def mucho_location_params
    params.require(:mucho_locations).permit(
      :location_name,
      :location_description,
      :location_phone,
      :location_email,
      :location_website_url,
      :location_address,
      :location_street_number,
      :location_street_name,
      :location_street_suffix,
      :location_city,
      :location_state_abbreviation,
      :location_postal_code,
      :location_country_code,
      :location_latitude,
      :location_longitude,
      :location_available
    )
  end
end