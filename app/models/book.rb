class Book < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :opinion, presence: true
    validates :opinion, length: { in: 1..200 }
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    ratyrate_rateable "speed", "engine", "price"
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
    def self.search(search)
    return Book.all unless search
    Book.where(['title LIKE ?', "%#{search}%"])
    end
end
