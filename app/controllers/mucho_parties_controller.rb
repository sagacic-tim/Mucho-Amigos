class MuchoPartiesController < ApplicationController
  def index
    @mucho_parties = MuchoParty.all
    render :index
  end

  def show
    @mucho_party = MuchoParty.find(params[:id])
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
      :party_host_id
    )
  end
end