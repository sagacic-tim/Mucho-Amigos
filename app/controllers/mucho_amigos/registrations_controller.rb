# frozen_string_literal: true

class MuchoAmigos::RegistrationsController < Devise::RegistrationsController
  before_action :account_params, only: [:create, :update, :edit]

  # POST /resource
  def create
    super
  send_email_changed_notification
  
  # PATCH /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update(account_params)
      # Send confirmation instructions if the email was changed
      resource.send_confirmation_instructions if resource.respond_to?(:send_confirmation_instructions)

      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      render json: {
        status: { code: 200, message: 'Updated successfully. Confirmation instructions sent.' },
        data: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.json {
          render json: {
            status: { message: "Amigo couldn't be updated successfully. #{resource.errors.full_messages.to_sentence}" }
          }, status: :unprocessable_entity
        }
      end
    end
  end


  format.json { render json: @countries } # Respond with JSON data
  
  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def account_params
    permitted_keys = [
      :full_name,
      :user_name,
      :email,
      :phone,
      :address,
      :street_number,
      :street_name,
      :street_suffix,
      :city,
      :state_abbreviation,
      :country_code,
      :postal_code,
      :party_animal,
      :personal_bio
    ]

    puts "Received Parameters: #{params.inspect}"
  
    params.permit(permitted_keys)
  end
  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:permitted_keys])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  def respond_with(resource, _opts = {})
    if resource.persisted?  # user is saved
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: MuchoAmigoSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else  # user is not saved
      render json: {
        status: {message: "Amigo couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
