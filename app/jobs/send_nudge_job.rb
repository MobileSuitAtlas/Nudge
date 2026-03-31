class SendNudgeJob < ApplicationJob
  queue_as :default

  def perform(habit_id)
    habit = Habit.find_by(id: habit_id)

    return unless habit
    return unless habit.needs_nudge?

    # Send ntfy.sh notification
    NtfyService.send_notification(
      habit.nudge_notification_message,
      title: "Nudge - #{habit.name}",
      tags: category_tag(habit.category),      
    )

    #Mark that a nudge was sent to avoid spamming.
    Rails.cache.write("nudge_sent_#{habit.id}_#{Date.today}", true, expires_in: 24.hours)
  end

  private
  def category_tag(category)
    {
      "Reading" => "books",
      "Writing" => "pencil",
      "Workout" => "muscle", 
      "Drawing" => "art"
    }[category] || "bell"
  end
end
