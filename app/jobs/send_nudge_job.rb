# frozen_string_literal: true

# TODO: This job currently just logs nudges. To make it functional:
# - Fix timezone handling in Habit#needs_nudge? (uses server time, not local time)
# - Integrate with Web Push API (webpush gem) or a service like OneSignal
# - Implement actual notification delivery

class SendNudgeJob < ApplicationJob
  queue_as :default

  def perform(habit_id)
    habit = Habit.find_by(id: habit_id)

    return unless habit
    return unless habit.needs_nudge?

    # Log the nudge for now (in production, this would send the actual notification)
    # TODO: See note above - needs Web Push API integration
    Rails.logger.info "NUDGE: Sending gentle nudge for habit '#{habit.name}' - #{habit.nudge_notification_message}"

    # Store the nudge in a way the frontend can pick up
    # We'll store it in session or use a simpler approach with Redis/cache
    # For now, let's use a simple file-based approach or just log it

    # TODO: In production, integrate with:
    # - Web Push notifications (webpush gem)
    # - Action Cable for real-time updates
    # - Or a notification service like OneSignal

    # For this implementation, we'll mark that a nudge was sent today
    Rails.cache.write("nudge_sent_#{habit.id}_#{Date.today}", true, expires_in: 24.hours)
  end
end
