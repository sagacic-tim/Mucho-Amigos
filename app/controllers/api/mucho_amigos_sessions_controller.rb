# frozen_string_literal: true

class Api::MuchoAmigosSessionsController < Devise::SessionsController
  # include RackSessionsFix
  include ActionController::RespondWith
  include Devise::Controllers::Helpers
  respond_to :json

  # before_action :configure_sign_in_params, only: [:create, :destroy]

  def create
    @mucho_amigo = MuchoAmigo.find_by_email(session_params[:email])
      
    if @mucho_amigo
      if @mucho_amigo.valid_password?(session_params[:password])
        sign_in(@mucho_amigo)
        respond_with @mucho_amigo, location: after_sign_in_path_for(@mucho_amigo)
        Rails.logger.debug "Current Mucho Amigo: #{current_mucho_amigo.inspect}"
      else
        render json: { error: 'Invalid password' }, status: :unauthorized
      end
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end
  
  # DELETE /resource/sign_out
  def destroy
    Rails.logger.debug "Current Mucho Amigo: #{current_mucho_amigo.inspect}"
    def destroy
      if current_mucho_amigo
        sign_out(:mucho_amigo)
        respond_to_on_destroy
      else
        render json: { error: 'No current user to log out.' }, status: :unauthorized
      end
    end
  end
  
  private

  def session_params
    params.require(:mucho_amigo).permit(:email, :password)
  end
  
  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.html { redirect_to after_sign_in_path_for(resource) }
      format.json do
        render json: {
          status: { code: 200, message: 'Logged in successfully.' },
          data: { user: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes] }
        }, status: :ok
      end
    end
  end

  def respond_to_on_destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json do
        error = nil
  
        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
            Rails.application.credentials.devise_jwt_secret_key!).first
          current_amigo = MuchoAmigo.find(jwt_payload['sub'])
          rescue JWT::DecodeError => e
            error = e
          rescue ActiveRecord::RecordNotFound => e
            error = e
          rescue => e
            error = e
        end
  
        case error
          when JWT::DecodeError
            render json: {
              status: 401,
              message: "Failed to decode JWT: #{error.message}"
            }, status: :unauthorized
          when ActiveRecord::RecordNotFound
            render json: {
              status: 404,
              message: "Amigo not found: #{error.message}"
            }, status: :not_found
          when StandardError # A general exception case
            render json: {
              status: 500,
              message: "An unexpected error occurred: #{error.message}"
            }, status: :internal_server_error
        else
          if signed_out
            render json: {
              status: 200,
              message: 'Logged out successfully.'
            }, status: :ok
          else
            render json: {
              status: 401,
              message: "Couldn't find an active session for this amigo."
            }, status: :unauthorized
          end
        end
      end
    end
  end   
end