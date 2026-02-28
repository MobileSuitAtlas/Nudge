class AddReminderTimeToHabits < ActiveRecord::Migration[8.1]
  def change
    add_column :habits, :reminder_time, :time
    add_column :habits, :reminders_enabled, :boolean, default: false
  end
end
