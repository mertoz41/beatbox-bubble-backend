class Song < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :shares, dependent: :destroy

    def comment_count
        return self.comments.length
    end 

    def share_count
        return self.shares.length
    end 


end
