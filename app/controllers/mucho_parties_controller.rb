class MuchoPartiesController < ApplicationController
  before_action :set_mucho_party, only: [:show, :create, :update, :destroy]

  def index
    @mucho_parties = MuchoParty.all
    puts "@mucho_parties: #{@mucho_parties.inspect}"
    render :index
  end

  def show
    # debugger
    # @mucho_party = MuchoParty.find(params[:id])
    render :show
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
    @mucho_party = MuchoParty.find(params[:id])
    if @mucho_party.update(mucho_party_params)
      render :update
    else
      render json: { errors: @mucho_party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @mucho_party = MuchoParty.find(params[:id])
    if @mucho_party.delete
      render :destroy
    else
      render json: { errors: @mucho_party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def mucho_party_params
    params.require(:mucho_party).permit(
      :party_name,
      :party_date,
      :party_time,
      :party_host_id,
      :party_location_id
    )
  end
end