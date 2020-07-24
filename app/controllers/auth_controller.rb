class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if @user
      render json: {user: @user}.to_json( :include => [:follows, :followed_by])
    else 
      render json: {message: 'Invalid username or password'}
    end 
  end
end
