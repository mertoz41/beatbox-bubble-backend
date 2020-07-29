class SharedsongsController < ApplicationController
    def destroy
        sharedsong = Sharedsong.find(params[:id].to_i)
        sharedsong.destroy
        render json: {message: "destroyed"}
    end 
end
