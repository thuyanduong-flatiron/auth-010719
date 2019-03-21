require "byebug"
class Api::V1::AuthController < ApplicationController

  def create # POST /api/v1/login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #username is found AND password matches
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {
        message: "Authenticated! You are logged in",
        user: @user,
        token: token
      }, status: :accepted
    else
      #username could not be found OR password is incorrect
      render json: {
        message: "WRONG! Are you a hacker??"
      }, status: :not_acceptable
    end
  end

end
