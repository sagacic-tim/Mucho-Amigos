Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do

    devise_for :mucho_amigos, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    }, controllers: {
      registrations: 'mucho_amigos_registrations',
      sessions: 'mucho_amigos_sessions',
      confirmations: 'mucho_amigos_confirmations',
      passwords: 'mucho_amigos_passwords'
    }

    devise_scope :mucho_amigo do
      resources :mucho_amigos, except: [:new, :edit],
      controller: 'mucho_amigos_registrations',
      defaults: { format: 'json' } do
        member do
          get 'associated_parties'
          get 'parties_by_this_amigo_as_host'
          get 'locations_for_host'
        end
        get '/api/mucho_amigos', to: 'api/mucho_amigos_registrations#index'
      end
    end

    resources :mucho_parties, except: [:new, :edit], defaults: { format: 'json' } do
      member do
        get 'party_location'
        get 'party_host'
        get 'party_guests', to: 'mucho_parties#mucho_guests'
        get 'other_parties_by_party_host'
      end
    end

    resources :mucho_guests, except: [:new, :edit], defaults: { format: 'json' } do
      member do
        get 'party_guest_details'
        get 'associated_parties', to: 'mucho_guests#associated_parties'
      end
    end

    resources :mucho_locations, except: [:new, :edit], defaults: { format: 'json' } do
      member do
        get 'parties_at_this_location', to: 'mucho_locations#parties_at_this_location'
      end
    end

    resources :countries_regions, only: [:index]
    get 'country_data', to: 'countries_regions#country_data'

    # get '*path', to: 'home#index', via: :all
  end
end