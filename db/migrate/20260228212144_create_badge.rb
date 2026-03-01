class CreateBadge < ActiveRecord::Migration[8.1]
  def change
    create_table :badges do |t|
      t.timestamps
    end
  end
end
