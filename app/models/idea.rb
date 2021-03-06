class Idea < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    validates(:title, presence: true, uniqueness: true, case_sensitive: false)
    validates(:description, presence: true, length: { minimum: 10 })

    before_save :capitalize_product_title

    private

    def capitalize_product_title
        self.title.capitalize!
    end


end
