class CreateCheckIns < ActiveRecord::Migration[8.1]
  def change
    create_table :check_ins do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
