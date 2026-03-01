class CreateHabitTags < ActiveRecord::Migration[8.1]
  def change
    create_table :habit_tags do |t|
      t.timestamps
    end
  end
end
