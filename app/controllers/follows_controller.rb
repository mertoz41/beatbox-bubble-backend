class FollowsController < ApplicationController

    def create
        Follow.create(follower_id: params[:followObj][:follower], followed_id: params[:followObj][:followed])
        render json: {message: "success"}
    end 

    def destroy
        id = params[:id].to_i
        
        felow = Follow.find(id)

        felow.destroy
        render json: {message: "success", id: id}
    end 
end
