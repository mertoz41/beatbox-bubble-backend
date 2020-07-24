class User < ApplicationRecord
    has_many_attached :tracks

    has_many :comments
    has_many :postings

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id
    has_many :followeds, through: :follows, source: :followed

    validates :username, uniqueness: { case_sensitive: false }

    
end
