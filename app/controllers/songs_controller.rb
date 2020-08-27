class SongsController < ApplicationController
    def show
        song = Song.find(params[:id].to_i)

        shared_version = Sharedsong.find_by(name: song.name)
        if shared_version
            share_count = shared_version.shares.length
        else
            share_count = 0
        end 
        
        updated_song = song.attributes
        updated_song[:share_count] = share_count
        updated_song[:comments] = song.comments
        
        
        render json: {song: updated_song}
    end 

    def create
        user = User.find(params[:id].to_i)
        track_name = params[:name]
        blob_to_be_attached = {io: File.open(params[:track].to_io), filename: track_name}
        user.tracks.attach(blob_to_be_attached)
        blob = Rails.application.routes.url_helpers.rails_blob_path(user.tracks.last, only_path: true)
        nuTrack = Song.create(name: track_name, blob: blob, user_id: user.id)
        render json: nuTrack
    end 

   
end
