require "#{Rails.root}/app/helpers/json_response_helper"

module Api
  class MuchoAmigosRegistrationsController < Devise::RegistrationsController
    before_action :set_devise_mapping
    include Devise::Controllers::Helpers
    include JsonResponseHelper

    respond_to :json

    before_action :authenticate_mucho_amigo!, except: [:index, :show, :create]
    before_action :set_devise_mapping, except: [:new, :edit, :index, :show]
    before_action :configure_permitted_parameters, if: :devise_controller?

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
      build_resource  # This will use the sanitized params
    
      if resource.save
        sign_up(resource_name, resource)  # Devise method to handle sign up
        render json: {
          status: 'success',
          message: 'Registration successful, mi amigo.',
          data: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
        }, status: :created
      else
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end   
    
    # PUT or PATCH /resource/
    def update
      # This retrieves the current resource
      self.resource = send(:"current_#{resource_name}")
    
      # Update the resource with provided password for confirmation
      if resource.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
        render json: { status: 'success', message: 'Profile updated successfully.' }, status: :ok
      else
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    # DELETE /mucho_amigos/:id
    def destroy
      @mucho_amigo = MuchoAmigo.find(params[:id])

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

    def mucho_amigo_signed_in?
      Rails.logger.debug "Session while checking if amigo is signed in: #{session.inspect}"
      !current_mucho_amigo.nil?
    end
    
    
    def current_mucho_amigo
      Rails.logger.debug "Session when getting current mucho amigo: #{session.inspect}"
      @current_mucho_amigo ||= MuchoAmigo.find_by(id: session["warden.user.mucho_amigo.key"][0][0]) if session["warden.user.mucho_amigo.key"]
    end  

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
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
      ])

      devise_parameter_sanitizer.permit(:account_update, keys: [
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
      ])
    end

    private

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
        return
      end
    end

    def authenticate_mucho_amigo!
      Rails.logger.debug "Session before authentication check: #{session.inspect}"
      unless mucho_amigo_signed_in?
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
    def set_devise_mapping
      request.env["devise.mapping"] = Devise.mappings[:mucho_amigo]
    end
  end
end