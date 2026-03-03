class HabitsController < ApplicationController
  def index
    @habits = Habit.active
    @show_archived = params[:show_archived] == "true"
    @archived_habits = Habit.archived if @show_archived

    # Convert session date string to Date object for comparison
    session_date = session[:focus_habit_date].is_a?(String) ? Date.parse(session[:focus_habit_date]) : session[:focus_habit_date]

    # Load focus habit from session if set for today
    if session_date == Date.today && session[:focus_habit_id].present?
      @focus_habit = Habit.find_by(id: session[:focus_habit_id])
      # If focus habit was archived or deleted, clear it
      if @focus_habit.nil? || @focus_habit.archived?
        session[:focus_habit_id] = nil
        session[:focus_habit_date] = nil
      end
    end

    if @focus_habit.nil? && @habits.any? && session[:focus_habit_id].nil?
      session[:focus_habit_id] = @habits.first.id
      session[:focus_habit_date] = Date.today
      @focus_habit = @habits.first
    end
  end

  def check_in
    habit = Habit.find(params[:id])
    check_in = habit.check_ins.find_or_create_by(date: Date.today)

    if check_in.persisted?
      habit.check_and_award_badges!
      flash[:notice] = "Checked in for today! Keep up the great work!"
    else
      flash[:notice] = habit.encouragement_message
    end
    redirect_back fallback_location: habits_path
  end

  def create
    @habit = Habit.new(habits_params)
    @habit.set_default_prompt
    if @habit.save
      redirect_to habits_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @habit = Habit.new
  end

  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy
    redirect_to habits_path
  end

  # Archive/Unarchive methods
  def archive
    habit = Habit.find(params[:id])
    habit.archive!
    redirect_to habits_path, notice: "Habit archived"
  end

  def unarchive
    habit = Habit.find(params[:id])
    habit.unarchive!
    redirect_to habits_path, notice: "Habit has been restored"
  end

  # Nudge method
  def nudge
    habit = Habit.find(params[:id])
    if habit.milestone_message
      flash[:notice] = habit.milestone_message
    else
      flash[:notice] = Habit::ENCOURAGEMENT_NUDGES.sample
    end
    redirect_back fallback_location: habits_path
  end

  # Reminder for API
  def toggle_reminder
    habit = Habit.find(params[:id])

    if habit.reminders_enabled?
      # Disable reminders
      habit.update(reminders_enabled: false, reminder_time: nil)
      flash[:notice] = "Daily nudge disabled"
    else
      # Enable with default 12pm (noon)
      habit.update(reminders_enabled: true, reminder_time: "12:00:00")
      flash[:notice] = "Daily nudge enabled! You'll get a gentle reminder at noon"
    end

    redirect_back fallback_location: habit_path(habit)
  end

  def set_focus
    session[:focus_habit_id] = params[:id]
    session[:focus_habit_date] = Date.today
    flash[:notice] = "Focus updated for today!"
    redirect_to "/"
  end

  def reset_focus
    session[:focus_habit_id] = nil
    session[:focus_habit_date] = nil
    flash[:notice] = "Focus cleared!"
    redirect_to habits_path
  end

  def update
    @habit = Habit.find(params[:id])
    @habit.assign_attributes(habits_params)
    @habit.set_default_prompt
    if @habit.save
      redirect_to habit_path(@habit)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def today
    @habits = Habit.active

    # Load focus habit from session if set for today
    if session[:focus_habit_date] == Date.today && session[:focus_habit_id].present?
      @focus_habit = Habit.find_by(id: session[:focus_habit_id])
      # If focus habit was archived or deleted, clear it
      if @focus_habit.nil? || @focus_habit.archived?
        session[:focus_habit_id] = nil
        session[:focus_habit_date] = nil
      end
    end

    # Auto-select first habit only if no focus is set
    if @focus_habit.nil? && @habits.any? && session[:focus_habit_id].nil?
      session[:focus_habit_id] = @habits.first.id
      session[:focus_habit_date] = Date.today
      @focus_habit = @habits.first
    end
  end

  # Export for CSV
  def export
    require "csv"

    habits = Habit.active.includes(:check_ins, :entries, :tags, :badges)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << [ "Habit", "Category", "Tags", "Streaks", "Longest Streak", "Date", "Status", "Entry" ]

      habits.each do |habit|
        dates = habit.check_ins.pluck(:date)
        dates.each do |date|
          entry = habit.entries.find_by(entry_date: date)
          csv << [
            habit.name,
            habit.category,
            habit.tags.pluck(:name).join(","),
            habit.current_streak,
            habit.longest_streak,
            date,
            "✓",
            entry&.content
          ]
        end
      end
    end

    send_data csv_data,
      filename: "habit_builder_export_#{Date.today}.csv",
      type: "text/csv"
  end

  def show
    @habit = Habit.find(params[:id])
  end

  # Dark/Light Mode Toggle
  def toggle_theme
    current = session[:theme] || "light"
    session[:theme] = current == "light" ? "dark" : "light"
    redirect_to request.referrer || habits_path
  end

  # Edit
  def edit
    @habit = Habit.find(params[:id])
  end

  private

  def habits_params
    params.require(:habit).permit(:name, :description, :category, :prompt, :reminder_time, :reminders_enabled, :tag_ids)
  end
end
