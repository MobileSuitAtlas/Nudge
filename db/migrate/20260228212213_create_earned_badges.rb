class CreateEarnedBadges < ActiveRecord::Migration[8.1]
  def change
    create_table :earned_badges do |t|
      t.timestamps
    end
  end
end
