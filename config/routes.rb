Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    devise_scope :api_mucho_amigo do
      # Custom routes for MuchoAmigo outside of Devise's usual paths.
      resources :mucho_amigos, controller: 'mucho_amigos_registrations', except: [:new, :edit]
      post 'auth/resend_confirmation', to: 'mucho_amigos_confirmations#resend'
      
      # Muchos Amigos specific routes
      resources :mucho_amigos, except: [:new, :edit] do
        member do
          get 'associated_parties'
          get 'parties_by_this_amigo_as_host'
          get 'locations_for_host'
        end
      end
    end
  
    # Devise routes for authentication
    devise_for :mucho_amigos, path: 'auth',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        registrations: 'api/mucho_amigos_registrations',
        sessions: 'api/mucho_amigos_sessions',
        confirmations: 'api/mucho_amigos_confirmations'
      }
  
    # Mucho Parties routes
    resources :mucho_parties, except: [:new, :edit] do
      member do
        get 'party_location'
        get 'party_host'
        get 'party_guests', to: 'mucho_parties#mucho_guests'
        get 'other_parties_by_party_host'
      end
    end

    # Mucho Guests routes
    resources :mucho_guests, except: [:new, :edit] do
      member do
        get 'party_guest_details'
        get 'associated_parties'
      end
    end

    # Mucho Locations routes
    resources :mucho_locations, except: [:new, :edit] do
      member do
        get 'parties_at_this_location'
      end
    end

    # Countries and Regions
    resources :countries_regions, only: [:index]
    get 'country_data', to: 'countries_regions#country_data'

  end

  # This is a catch all route if needed.
  # get '*path', to: 'home#index', via: :all
end
