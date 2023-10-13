require "application_responder"
require 'action_controller'
# protect_from_forgery with: :exception

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionView::Layouts
  include ActionController::Flash
  include ActionController::Helpers

  self.responder = ApplicationResponder
  respond_to :json

  # code shared between application_conbtroller and registrations_controller
  helper_method :generate_country_data

  # Rescue from parse errors
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error

  # Run this before action only for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

  def generate_country_data(country)
    {
      name: country.translations&.[](I18n.locale.to_s) || country.name,
      alpha2: country.alpha2,
      states: (country.states || []).map do |state_info|
        state_code, state = state_info
        {
          abbr: state_code,
          name: state.translations&.[](I18n.locale.to_s) || state.name
        }
      end
    }
  end

  # Define a custom route for country_data
  def country_data
    begin
      countries = ISO3166::Country.all.map { |country| generate_country_data(country) }
      render json: countries
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  protected

  # Configure permitted parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  private

  # Handle parameter parse errors
  def handle_parse_error(exception)
    render json: { error: 'There was a problem parsing the request', details: exception.message }, status: 400
  end
end