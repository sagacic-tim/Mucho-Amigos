class ApplicationController < ActionController::API
  # Run this before action only for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def info
    render json: {
      message: "Welcome to the Mucho Amigos API! This is the app that allows us to create parties anywhere and everywhere, and to be able to invite anyone we wish.",
      version: "1.0",  # Include API version or any other relevant information
      status: "ok"
    }, status: :ok
  end

  self.responder = ApplicationResponder
  respond_to :json

  # Rescue from parse errors
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error

  protected

  # Configure permitted parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
  
  def current_mucho_amigo
    @current_mucho_amigo ||= MuchoAmigo.find_by(id: session[:mucho_amigo_id]) if session[:mucho_amigo_id]
  end
  helper_method :current_mucho_amigo

  private

  # Handle parameter parse errors
  def handle_parse_error(exception)
    render json: { error: 'There was a problem parsing the request', details: exception.message }, status: 400
  end
end