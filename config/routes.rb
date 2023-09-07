Rails.application.routes.draw do
 resources :mucho_amigos, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  # post '/amigos/', to: 'mucho_amigos#create'
  # put '/amigos/:id', to: 'mucho_amigos#update'
  # delete '/amigos/:id', to: 'mucho_amigos#destroy'
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "mucho_amigos#index"

  resources :mucho_parties, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  # post '/parties/', to: 'mucho_parties#create'
  # put '/parties/:id', to: 'mucho_parties#update'
  # delete '/parties/:id', to: 'mucho_parties#destroy'
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "mucho_parties#index"

  resources :mucho_guests, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  # post '/guests/', to: 'mucho_guests#create'
  # put '/guestss/:id', to: 'mucho_guests#update'
  # delete '/guestss/:id', to: 'mucho_guests#destroy'
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "mucho_guests#index"

  resources :mucho_locations, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  # post '/locations/', to: 'mucho_locations#create'
  # put '/locations/:id', to: 'mucho_locations#update'
  # delete '/locations/:id', to: 'mucho_locations#destroy'
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "mucho_locations#index"
end