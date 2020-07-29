class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    sharedsongswithcounts = []
        @user.sharedsongs.each do |song| 

          obj = {}
          obj = song.attributes
          
          obj['share_count'] = song.shares.length
          sharedsongswithcounts.push(obj)
        end 
        
        



    if @user
      render json: {user: @user, sharedsongswithcounts: sharedsongswithcounts}.to_json( :include => [:follows, :followed_by, :shares, :sharedsongs, :songs])
    else 
      render json: {message: 'Invalid username or password'}
    end 
  end
end
