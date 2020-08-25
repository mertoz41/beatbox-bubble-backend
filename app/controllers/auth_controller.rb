class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    
    
        
        



    if @user && @user.authenticate(params[:password])
      payload = {user_id: @user.id}
      token = encode(payload)
      
      sharedsongswithcounts = []
        @user.sharedsongs.each do |song| 

          obj = {}
          obj = song.attributes
          
          obj['share_count'] = song.shares.length
          sharedsongswithcounts.push(obj)
        end 
      render json: {user: @user, token: token, sharedsongswithcounts: sharedsongswithcounts}.to_json( :include => [:follows, :followed_by, :shares, :sharedsongs, :songs])
    else 
      render json: {message: 'Invalid username or password'}
    end 
  end

  def checking
    token = request.headers["Authentication"]
    payload = decode(token)
    user = User.find(payload["user_id"])
    render json: {user: user}.to_json( :include => [:follows, :followed_by, :shares, :sharedsongs, :songs])
    
  end
end
