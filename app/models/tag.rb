class Tag < ApplicationRecord
    has_and_belongs_to_many :habits
    validates :name, uniqueness: true, presence: true
    validates :color, presence: true
end
