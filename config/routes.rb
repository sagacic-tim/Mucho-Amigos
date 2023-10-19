Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :mucho_amigos, only: [:index, :show, :create, :update, :destroy]
    resources :countries_regions, only: [:index]

    # Specify the controller name without "_controller"
    devise_for :mucho_amigos, controllers: {
      registrations: 'amigos_registrations',
      sessions: 'mucho_amigos_sessions',
      confirmations: 'mucho_amigos_confirmations',
      passwords: 'mucho_amigos_passwords'
      # omniauth_callbacks: 'mucho_amigos_omniauth_callbacks'
    }

    devise_scope :mucho_amigo do
      # Devise registration routes
      resources :mucho_amigos,
        only: [:index, :show, :create, :update, :destroy],
        controller: 'amigos_registrations',
        defaults: { format: 'json' } do
          member do
            get 'associated_parties'
            get 'parties_by_this_amigo_as_host'
            get 'locations_for_host'
          end
        end
    
      # Custom sessions routes
      post '/mucho_amigos/sign_in', to: 'mucho_amigos_sessions#create'
      delete '/mucho_amigos/sign_out', to: 'mucho_amigos_sessions#destroy'
      # ... other custom routes as needed ...
    end

    # Define a custom route for country_data
    get 'country_data', to: 'application#country_data'
    get 'favicon.ico', to: 'application#favicon'

    # This creates standard RESTful routes (index, show,
    # create, update, and destroy). Specifying 'json format
    # streamlines the API by making it less necessary to
    # appendb'.json' to URLs when making requests.
    resources :mucho_parties, only: [:index, :show, :create, :update, :destroy],
      defaults: { format: 'json' } do
      # member routes operate on a single instance specified
      # by the ID in the URL, i.e. /mucho_parties/1/party_location
      member do
        # This route would presumably return information about the
        # location where this specific party is hosted or who the
        # host is. This would allow a GET request to be made to a
        # URL like /mucho_parties/1/party_location. It also returns
        # all guests associated with a particular party
        get 'party_location'
        get 'party_host'
        get 'party_guests', to: 'mucho_parties#mucho_guests'
        get 'other_parties_by_party_host'
      end
    end
    
    resources :mucho_guests,
      only: [:index, :show, :create, :update, :destroy],
      defaults: { format: 'json' } do
      member do
        get 'party_guest_details'
        get 'associated_parties', to: 'mucho_guests#associated_parties'
      end
    end

    resources :mucho_locations,
      only: [:index, :show, :create, :update, :destroy],
      defaults: { format: 'json' } do
      member do
        get 'parties_at_this_location', to: 'mucho_locations#parties_at_this_location'
      end
    end
    # Use a catch-all route for non-API requests, let React handle routing
    get '*path', to: 'home#index', via: :all
  end
end