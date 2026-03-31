namespace :ntfy do
    desc " Test NtfyService directly"
    task test: :environment do
        puts "Testing NtfyService..."
        result = NtfyService.send_notification(
            "Test from Nudge! Time: #{Time.current}",
            title: "Ntfy Test",
            tags: "bell"
        )
        puts "Result: #{result&.code || 'failed'}"
    end

    desc "Debug all habits nudge status"
    task debug_habits: :environment do
        Habit.all.each do |habit|
            puts "== #{habit.name} =="
            puts "  reminders_enabled?: #{habit.reminders_enabled?}"
            puts "  reminder_time: #{habit.reminder_time}"
            puts "  checked_on?(today): #{habit.checked_on?(Date.today)}"
            puts "  needs_nudge?: #{habit.needs_nudge?}"
            puts "  current_time: #{Time.current}"
            puts "  nudge_notification_messages: #{habit.nudge_notification_message}"
        end
    end 
end