class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        if request.path == '/home/index'
          render 'home/index'  # Renders app/views/home/index.html.erb
        else
          render 'mucho_welcome/index'  # Renders app/views/mucho_welcome/index.html.erb
        end
      end
      format.json do
        @mucho_amigos = MuchoAmigo.all
        render json: { info: "API info", mucho_amigos: @mucho_amigos }
      end
    end
  end
end
