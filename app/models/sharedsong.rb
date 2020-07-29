class Sharedsong < ApplicationRecord
    has_many :shares, dependent: :destroy
    has_many :users, through: :shares
end
