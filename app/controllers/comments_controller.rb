class CommentsController < ApplicationController

    def create
        user = User.find(params[:commentObj][:user_id])
        song_id = params[:commentObj][:song_id]
        song = Song.find(song_id)
        message = params[:commentObj][:message]

        
        nu_comment = Comment.create(message: message, user_id: user.id, song_id: song_id)
        user_comments = user.comments
        
        render json: {nu_comment: song.comments.last , all_comments: user_comments}
    end 
end
