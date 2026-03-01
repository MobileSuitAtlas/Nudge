class EarnedBadge < ApplicationRecord
  belongs_to :habit
  belongs_to :badge
end
