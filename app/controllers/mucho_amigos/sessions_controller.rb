# frozen_string_literal: true

class MuchoAmigos::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private  def respond_with(current_amigo, _opts = {})
    render json: {
      status: { 
        code: 200, message: 'Logged in successfully.',
        data: { user: MuchoAmigoSerializer.new(current_amigo).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
  end  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
        Rails.application.credentials.devise_jwt_secret_key!).first
      current_amigo = MuchoAmigo.find(jwt_payload['sub'])
    end
    
    if current_amigo
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
