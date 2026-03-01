class AddArchiveToHabits < ActiveRecord::Migration[8.1]
  def change
    add_column :habits, :archived, :boolean
    add_column :habits, :archived_at, :datetime
  end
end
