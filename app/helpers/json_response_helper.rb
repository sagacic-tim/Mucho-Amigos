# app/helpers/json_response_helper.rb
module JsonResponseHelper
  def render_json_success(message, data = {})
    render json: { status: 'success', message: message, data: data }, status: :ok
  end

  def render_json_error(errors)
    render json: { status: 'error', errors: errors }, status: :unprocessable_entity
  end
end