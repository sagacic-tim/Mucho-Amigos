class Api::CountriesRegionsController < ApplicationController

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
end