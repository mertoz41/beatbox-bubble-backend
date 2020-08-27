class UsersController < ApplicationController
    def index
        render json: User.all.to_json(only: [:id, :username])
    end 

    def show
        
        user = User.find(params["id"].to_i)
        # arr = []
        # othearr = []

        
        

        # user.tracks.attachments.each { |track| arr.push(Rails.application.routes.url_helpers.rails_blob_path(track, only_path: true))}
        

        render json: {user: user}.to_json( :include => [:follows, :followed_by, :shares, :sharedsongs, :songs])
    end 

    def addtrack
        user = User.find(params["id"])
        name = params[:name]
        
        # track = params["formData"]["track"]
        track = {io: File.open(params[:track].to_io), filename: name}
        # photo = {io: File.open("./public/johnwall.png"), filename: "johnwall.png", content_type: "image/png"}
        
        
        
        
        user.tracks.attach(track)
        
        # arr = []
        
        # user.tracks.attachments.each { |track| arr.push(Rails.application.routes.url_helpers.rails_blob_path(track, only_path: true))}
        
        url = Rails.application.routes.url_helpers.rails_blob_path(user.tracks.last, only_path: true)
        
        # url = Rails.application.routes.url_helpers.rails_blob_path(user.tracks.all, only_path: true)

        render json: {message: "Attached to file", url: url, trackname: name}
    
    end
    
    def usertracks
        user = User.find(params["id"])

        arr = []

        user.tracks.attachments.each { |track| arr.push(Rails.application.routes.url_helpers.rails_blob_path(track, only_path: true))}

        render json: {message: "Attached to file", urls: arr}
    end 

    def timeline
        
        id = params[:id].to_i
        logging_user = User.find(id)
        followed_users = []
        logging_user.follows.each do |obj|
            followed = User.find(obj.followed_id)
            followed_users.push(followed)
        end

        # logged in users following list

        # byebug
        
        tl_tracks = []
        
        # followed_users.each do |user| 
        # user.tracks.attachments.each { |track| tl_tracks.push(Rails.application.routes.url_helpers.rails_blob_path(track, only_path: true))}
        # end 
        
        followed_users.each do |user|
            songObj = {}
            user.songs.each do |song|
                # tl_tracks.push(song)
                
                # shared_version = Sharedsong.find_by(name: song.name)
    

                # if shared_version
                #     songObj[:shared] = shared_version.shares
                # else
                #     songObj[:shared] = []
                # end 

                
                
                
                songObj = song.attributes
                songObj[:comments] = song.comments
                # songObj[:shared_version_id] = shared_version.id
                tl_tracks.push(songObj)
                
                
                
            end 
        end 

        # byebug
        user_song_obj = {}
        logging_user.songs.each do |song| 
            # shared_version = Sharedsong.find_by(name: song.name)
            

            


            user_song_obj = song.attributes
            user_song_obj[:comments] = song.comments
            tl_tracks.push(user_song_obj)
        end

        tl_tracks.each do |song|

            shared_version = Sharedsong.find_by(name: song["name"])

            if shared_version.nil?
                song["shared"] = []
            else
                song["shared"] = shared_version.shares
            end 
            
            
        end 
        
        
        

        
        
    #    tl_tracks = tl_tracks.sort_by(&:created_at)        
    
        
        render json: {tl_tracks: tl_tracks} 
        
        

    end 
end
