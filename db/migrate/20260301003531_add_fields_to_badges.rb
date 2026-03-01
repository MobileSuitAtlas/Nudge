class AddFieldsToBadges < ActiveRecord::Migration[8.1]
  def change
    add_column :badges, :name, :string
    add_column :badges, :icon, :string
    add_column :badges, :description, :text
    add_column :badges, :requirement_days, :integer
  end
end
