class MuchoPartiesController < ApplicationController
  before_action :set_mucho_party, only: [:show, :update, :destroy]

  def index
    @mucho_parties = MuchoParty.all
    puts "@mucho_parties: #{@mucho_parties.inspect}"
    render :index
  end

  def show
    begin
      render :show
    rescue => error
      render json: { error: error.message }, status: :bad_request
    end
  end

  def create
    @mucho_party = MuchoParty.new(mucho_party_params)
    if @mucho_party.save
      render :create
    else
      render json: { errors: @mucho_party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @mucho_party.update(mucho_party_params)
      render :update
    else
      render json: { errors: @mucho_party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @mucho_party.destroy
      render :destroy
    else
      render json: { errors: @mucho_party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def party_location
    # Your logic to fetch and render the party location goes here
    mucho_party = MuchoParty.find(params[:id])
    location = mucho_party.party_location
    render json: { location: location }
  end

  def party_host
    # Your logic to fetch and render the party location goes here
    mucho_party = MuchoParty.find(params[:id])
    host = mucho_party.party_host
    render json: { host: host }
  end

  def party_guests
    mucho_party = MuchoParty.find(params[:id])
    party_guests = mucho_party.mucho_guests
    puts party_guests.to_a.inspect  # This will force the SQL query to execute
    render json: { party_guests: party_guests }
  end
  
  def other_parties_by_party_host
    # Find the current party by ID
    begin
      mucho_party = MuchoParty.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "No Party found for that mucho_party_id" }, status: :not_found
      return
    end

    # Get the ID of the host of the current party
    party_host_id = mucho_party.party_host_id

    # Find all other parties hosted by the same host
    other_parties_by_party_host = MuchoParty.where(party_host_id: party_host_id).where.not(id: params[:id])

    if other_parties_by_party_host.empty?
      render json: { message: "This party host is not hosting any other parties." }, status: :ok
    else
      render json: { other_parties_by_party_host: other_parties_by_party_host }, status: :ok
    end
  end
  
  private

  def set_mucho_party
    @mucho_party = MuchoParty.find(params[:id])
  end

  def mucho_party_params
    params.require(:mucho_party).permit(
      :party_name,
      :party_date,
      :party_time,
      :party_host_id,
      :party_location_id)
  end
end
