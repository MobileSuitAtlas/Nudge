class AddIndexToCheckInsDate < ActiveRecord::Migration[8.1]
  def change
    add_index :check_ins, :date
  end
end
