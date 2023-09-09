Rails.application.routes.draw do
  resources :mucho_parties,
      only: [:index, :show, :create, :update, :destroy],
      defaults: { format: 'json' } do
    member do
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