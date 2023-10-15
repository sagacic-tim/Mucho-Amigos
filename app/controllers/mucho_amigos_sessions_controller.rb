# frozen_string_literal: true

class MuchoAmigosSessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  # before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    @mucho_amigo = MuchoAmigo.find_by_email(params[:email])
    
    if @mucho_amigo&.valid_password?(params[:password])
      sign_in(@mucho_amigo)
      respond_with @mucho_amigo, location: after_sign_in_path_for(@mucho_amigo)
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    respond_to_on_destroy(signed_out)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private
  
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
        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
          Rails.application.credentials.devise_jwt_secret_key!).first
          current_amigo = MuchoAmigo.find(jwt_payload['sub'])
  
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
        rescue JWT::DecodeError => e
          render json: {
            status: 401,
            message: "Failed to decode JWT: #{e.message}"
          }, status: :unauthorized
        rescue ActiveRecord::RecordNotFound => e
          render json: {
            status: 404,
            message: "Amigo not found: #{e.message}"
          }, status: :not_found
        rescue => e
          render json: {
            status: 500,
            message: "An unexpected error occurred: #{e.message}"
          }, status: :internal_server_error
        end
      end
    end
  end  
end