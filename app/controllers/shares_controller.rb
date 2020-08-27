class SharesController < ApplicationController
    def create
        user_id = params[:shareObj][:user_id]
        song_id = params[:shareObj][:song_id]
        found_song = Song.find(song_id)

        nu_shared_song = Sharedsong.find_or_create_by(name: found_song.name, blob: found_song.blob, user_id: found_song.user_id)
        nu_shared_obj = Share.create(user_id: user_id, sharedsong_id: nu_shared_song.id)

        render json: {message: "success", shared_song: nu_shared_song, shared_obj: nu_shared_obj}
    end 

    def destroy
        id = params[:id].to_i
        
        share = Share.find_by(user_id: id)
        share.destroy
        render json: {message: "unshared"}
        

    end 
end
