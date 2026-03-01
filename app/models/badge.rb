class Badge < ApplicationRecord
  has_many :earned_badges
  has_many :habits, through: :earned_badges
end
