Rails.application.routes.draw do
  # This creates standard RESTful routes (index, show,
  # create, update, and destroy). Specifying 'json format
  # streamlines the API by making it less necessary to
  # appendb'.json' to URLs when making requests.
  resources :mucho_parties,
      only: [:index, :show, :create, :update, :destroy],
      defaults: { format: 'json' } do
    # member routes operate on a single instance specified
    # by the ID in the URL, i.e. /mucho_parties/1/party_location
    member do
      # This route would presumably return information about the
      # location where this specific party is hosted or who the
      # host is. This would allow a GET request to be made to a
      # URL like /mucho_parties/1/party_location
      get 'party_location'
      get 'party_host'
    end
  end
  
  resources :mucho_guests,
    only: [:index, :show, :create, :update, :destroy],
    defaults: { format: 'json' } do
    member do
      get 'mucho_amigos'
      get 'mucho_parties'
    end
  end

  resources :mucho_amigos,
    only: [:index, :show, :create, :update, :destroy],
    defaults: { format: 'json' }

  resources :mucho_locations,
    only: [:index, :show, :create, :update, :destroy],
    defaults: { format: 'json' }
end