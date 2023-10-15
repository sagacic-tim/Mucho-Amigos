# puts $LOAD_PATH
# puts "Current ancestors: #{ancestors.inspect}"

require "#{Rails.root}/app/helpers/json_response_helper"

class AmigosRegistrationsController < Devise::RegistrationsController
  respond_to :json
  include JsonResponseHelper

  before_action :authenticate_mucho_amigo!,
                :account_params, only: [:create, :update]

  # List all Amigos
  def index
    @mucho_amigos = MuchoAmigo.all
    render :index
  end

  # Show a single Amigo mucho_amigos/:id
  def show
    @mucho_amigo = MuchoAmigo.find(params[:id])
    render :show
  end

  # POST /resource/
  def create
    @mucho_amigo = MuchoAmigo.new(account_params)

    respond_to do |format|
      if @mucho_amigo.save
        # Assuming you have a method to send confirmation instructions
        @mucho_amigo.send_confirmation_instructions
        
        format.json {
          render_json_success('Confirmation instructions sent, mi amigo.',
            MuchoAmigoSerializer.new(@mucho_amigo).serializable_hash[:data][:attributes])
        }
      else
        format.json {
          render_json_error(@mucho_amigo.errors.full_messages)
        }
      end
    end
  end

  # PATCH /resource/:id
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if resource.update(account_params)
      # Send confirmation instructions if the email was changed
      resource.send_confirmation_instructions if resource.respond_to?(:send_confirmation_instructions)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      render json: {
        status: { code: 200, message: 'Updated successfully. Confirmation instructions sent, mi amigo.' },
        data: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.json {
          render json: {
            status: { message: "This Amigo couldn't be updated successfully. #{resource.errors.full_messages.to_sentence}" }
          }, status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /mucho_amigos/:id
  def destroy
    @mucho_amigo = MuchoAmigo.find(params[:id])

    # Check authentication
    authenticate_mucho_amigo!

    # Check authorization
    authorize_user

    @mucho_amigo.destroy
    render json: { status: 'success', message: 'MuchoAmigo deleted successfully.' }, status: :ok
  end

  # ASSOCIATED_PARTIES /mucho_amigos/:id
  def associated_parties
    amigo = MuchoAmigo.find(params[:id])
    associated_parties = amigo.mucho_parties
    render json: associated_parties
  end

  # Parties Hosgted by an Amigo /mucho_amigos/:id
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

  # Locations Amogos is registered as host mucho_amigos/:id
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

  def account_params
    permitted_keys = [
      :full_name,
      :user_name,
      :email,
      :password,
      :password_confirmation,
      :phone,
      :address,
      :street_number,
      :street_name,
      :street_suffix,
      :city,
      :state_abbreviation,
      :country_code,
      :postal_code,
      :party_animal,
      :personal_bio
    ]
  
    # Permit nested attributes for mucho_amigo
    params.require(:mucho_amigo).permit(permitted_keys)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?  # user is saved
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else  # user is not saved
      render json: {
        status: {message: "Amigo couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def authorize_user
    # Check if the current user is authorized to delete the MuchoAmigo
    unless current_mucho_amigo == @mucho_amigo
      render json: { error: "You are not authorized to delete this MuchoAmigo." }, status: :forbidden
    end
  end
end 