class Song < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :shares

    def comment_count
        return self.comments.length
    end 

    def share_count
        return self.shares.length
    end 


end
