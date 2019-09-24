class User < ApplicationRecord
    has_secure_password

    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify

    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :name, presence: true

end
