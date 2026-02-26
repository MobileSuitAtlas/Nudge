class AddCategoryAndPromptToHabits < ActiveRecord::Migration[8.1]
  def change
    add_column :habits, :category, :string
    add_column :habits, :prompt, :string
  end
end
