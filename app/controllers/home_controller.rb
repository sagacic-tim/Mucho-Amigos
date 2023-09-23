class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        render 'mucho_welcome/index'  # Renders app/views/mucho_welcome/index.html.erb
      end
      format.json do
        @mucho_amigos = MuchoAmigo.all
        render json: { info: "API info", mucho_amigos: @mucho_amigos }
      end
    end
  end
end
