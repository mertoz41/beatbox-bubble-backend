class SharesController < ApplicationController
    def create
        user_id = params[:shareObj][:user_id]
        song_id = params[:shareObj][:song_id]
        found_song = Song.find(song_id)

        nuShared = Sharedsong.create(name: found_song.name, blob: found_song.blob, user_id: found_song.user_id)
        Share.create(user_id: user_id, sharedsong_id: nuShared.id)

        render json: {message: "success"}
    end 

    def destroy
        id = params[:id].to_i

        share = Share.find(id)
        share.destroy
        render json: {message: "unshared"}
        

    end 
end
