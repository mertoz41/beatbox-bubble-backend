class SharedsongsController < ApplicationController

    def explore

        shared_songs = Sharedsong.all

        sorted_songs = shared_songs.sort do |a,b|
            # byebug
            b.shares.length <=> a.shares.length
        end 


        # byebug
    end 


    def destroy
        sharedsong = Sharedsong.find(params[:id].to_i)
        sharedsong.destroy
        render json: {message: "destroyed"}
    end 
end
