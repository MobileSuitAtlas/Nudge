class AddFieldsToEarnedBadges < ActiveRecord::Migration[8.1]
  def change
    add_reference :earned_badges, :habit, null: false, foreign_key: true
    add_reference :earned_badges, :badge, null: false, foreign_key: true
    add_column :earned_badges, :earned_at, :datetime
  end
end
