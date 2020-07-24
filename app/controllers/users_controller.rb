class UsersController < ApplicationController
    def index
        render json: User.all.to_json(only: [:id, :username])
    end 

    def show
        
        user = User.find(params["id"].to_i)
        arr = []

        user.tracks.attachments.each { |track| arr.push(Rails.application.routes.url_helpers.rails_blob_path(track, only_path: true))}

        render json: {user: user, urls: arr}.to_json( :include => [:follows, :followed_by])
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
end
