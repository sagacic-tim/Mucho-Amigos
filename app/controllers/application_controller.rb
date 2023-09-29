require "application_responder"
require 'action_controller'

class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  include ActionView::Layouts
  include ActionController::Flash
  include ActionController::Helpers

  self.responder = ApplicationResponder
  respond_to :html

  # Rescue from parse errors
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error

  # Run this before action only for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

# Define a custom route for country_data
def country_data
  @countries = ISO3166::Country.all.map do |country|
    {
      name: country.name,
      alpha2: country.alpha2,
      states: country.states&.map { |state| { abbr: state.abbr, name: state.name } }
    }
  end

  Rails.logger.info("country_data")
  Rails.logger.info(@countries.to_json)

  render json: @countries
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