class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.references :habit, null: false, foreign_key: true
      t.text :content
      t.date :entry_date

      t.timestamps
    end
  end
end
