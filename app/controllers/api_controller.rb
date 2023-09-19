class ApiController < ApplicationController
  def info
    render json: { message: "Welcome to the Mucho Amigos API! This is the app that allows us to create parties anywhere and everywhere, and to be able to invite anyone we wish." }, status: :ok
  end
end

