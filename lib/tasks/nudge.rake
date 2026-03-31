# frozen_string_literal: true

namespace :nudge do
  desc "Send gentle nudges for habits that need them"
  task send_nudges: :environment do
    puts "Checking for habits that need nudges..."

    Habit.all.each do |habit|
      unless habit.needs_nudge?
        puts "SKIP: #{habit.name} - reminders_enabled: #{habit.reminders_enabled?}, checked_today: #{habit.checked_on?(Date.today)}, reminder_time: #{habit.reminder_time}"
        next
      end
      # Check if we already sent a nudge today
      next if Rails.cache.read("nudge_sent_#{habit.id}_#{Date.today}")

      puts "Sending nudge for: #{habit.name}"
      SendNudgeJob.perform_later(habit.id)
    end

    puts "Done checking for nudges!"
  end
end
