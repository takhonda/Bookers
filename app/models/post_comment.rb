class PostComment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    ratyrate_rateable "review"
end
