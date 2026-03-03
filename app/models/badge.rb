class Badge < ApplicationRecord
  has_many :earned_badges
  has_many :habits, through: :earned_badges
  validates :name, presence: true
  validates :requirement_days, numericality: { greater_than_or_equal_to: 0 }
end
