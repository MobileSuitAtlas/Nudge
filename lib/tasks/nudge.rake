# frozen_string_literal: true

# TODO: This rake task and the nudge system are not fully functional.
# Issues:
# - Uses server timezone instead of user timezone
# - Need web API integration to send notifications
# - Just logs nudges (SendNudgeJob)

namespace :nudge do
  desc "Send gentle nudges for habits that need them"
  task send_nudges: :environment do
    puts "Checking for habits that need nudges..."

    Habit.all.each do |habit|
      next unless habit.needs_nudge?

      # Check if we already sent a nudge today
      next if Rails.cache.read("nudge_sent_#{habit.id}_#{Date.today}")

      puts "Sending nudge for: #{habit.name}"
      SendNudgeJob.perform_later(habit.id)
    end

    puts "Done checking for nudges!"
  end
end
