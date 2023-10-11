# app/controllers/mucho_amigos_omniauth_callbacks_controller.rb

class MuchoAmigosOmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    handle_callback('google')
  end

  def facebook
    handle_callback('facebook')
  end

  def github
    handle_callback('github')
  end

  def linkedin
    handle_callback('linkedin')
  end

  private

  def handle_callback(provider)
    @mucho_amigo = MuchoAmigo.from_omniauth(request.env['omniauth.auth'])

    if @mucho_amigo.persisted?
      sign_in_and_redirect @mucho_amigo, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_mucho_amigo_registration_url
    end
  end
end
