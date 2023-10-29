# frozen_string_literal: true

class Api::MuchoAmigosConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @resource = resource_class.confirm_by_token(params[:confirmation_token])
    super
  end

  # When the confirmatons emails isn't responded to in hte required
  # amount of time, allow the Amigo to have the confirmaton email resent.
  def resend
    @mucho_amigo = MuchoAmigo.find_by_email(params[:email])
    
    if @mucho_amigo && !@mucho_amigo.confirmed?
      @mucho_amigo.send_confirmation_instructions
      render json: { message: 'Confirmation instructions have been resent to the provided email.' }, status: :ok
    else
      render json: { error: 'Email not found or already confirmed.' }, status: :not_found
    end
  end  

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    super(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
  end
end
