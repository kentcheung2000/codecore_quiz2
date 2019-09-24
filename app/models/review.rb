class Review < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes


  validates :rating, presence: true
  validates_numericality_of(:rating, :only_integer =>true,:greater_than =>0,:less_than => 6,:message =>'rating should be integer and between 1 to 5')


end
