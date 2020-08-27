class SharedsongsController < ApplicationController

    def explore

        explore_songs = []
        sorted_list = Sharedsong.all.sort { |a, b| b.shares.length <=> a.shares.length}
        topthree = sorted_list.slice(0,3)
        render json: {explore_songs: topthree}.to_json( :include => [:shares])


        
    end 


    def destroy
        sharedsong = Sharedsong.find(params[:id].to_i)
        sharedsong.destroy
        render json: {message: "destroyed"}
    end 
end
