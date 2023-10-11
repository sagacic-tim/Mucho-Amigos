Rails.application.routes.draw do

  get 'mucho_welcome/index', to: 'home#index'
  get 'home/index', to: 'home#index'
  # Define a custom route for country_data
  get 'country_data', to: 'application#country_data'
  get 'favicon.ico', to: 'application#favicon'
  # put '/mucho_amigos/registrations/update', to: 'mucho_amigos/registrations#update', as: 'mucho_amigo_registration_path'
  root to: 'home#index'

  devise_for :mucho_amigos, controllers: {
    registrations: 'mucho_amigos',
    sessions: 'mucho_amigos_sessions',
    confirmations: 'mucho_amigos_confirmations',
    passwords: 'mucho_amigos_passwords'
    # omniauth_callbacks: 'mucho_amigos_omniauth_callbacks'
  }

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
      # URL like /mucho_parties/1/party_location. I alos returns
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

  resources :mucho_amigos,
    only: [:index, :show, :create, :update, :destroy],
    defaults: { format: 'json' } do
    member do
      get 'associated_parties'
      get 'parties_by_this_amigo_as_host'
      get 'locations_for_host'
    end
  end

  resources :mucho_locations,
    only: [:index, :show, :create, :update, :destroy],
    defaults: { format: 'json' } do
    member do
      get 'parties_at_this_location', to: 'mucho_locations#parties_at_this_location'
    end
  end

  # devise_for :mucho_amigos, controllers: {
  #   sessions: 'mucho_amigos/sessions',
  #   confirmations: 'mucho_amigos/confirmations',
  #   registrations: 'mucho_amigos/registrations'
  # }, path: 'mucho_amigos',
  # path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   sign_up: 'signup',
  #   confirmation: 'confirmation' 
  # }
  # This will route both the root URL (/) and the
  # /mucho_welcome/index URL to the index action of
  # MuchoWelcomeController.
end