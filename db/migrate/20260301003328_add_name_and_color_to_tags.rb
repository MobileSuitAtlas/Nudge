class AddNameAndColorToTags < ActiveRecord::Migration[8.1]
  def change
    add_column :tags, :name, :string
    add_column :tags, :color, :string
  end
end
