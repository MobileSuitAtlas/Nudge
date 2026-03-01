class AddReferencesToHabitTags < ActiveRecord::Migration[8.1]
  def change
    add_reference :habit_tags, :habit, null: false, foreign_key: true
    add_reference :habit_tags, :tag, null: false, foreign_key: true
  end
end
