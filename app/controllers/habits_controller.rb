class HabitsController < ApplicationController
  def index
    @habits = Habit.all
    # Load focus habit from session if set for today
    if session[:focus_habit_date] == Date.today && session[:focus_habit_id].present?
      @focus_habit = Habit.find_by(id: session[:focus_habit_id])
    end
  end

  def check_in
    habit = Habit.find(params[:id])
    check_in = habit.check_ins.find_or_create_by(date: Date.today)

    if check_in.persisted?
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

  def nudge
    habit = Habit.find(params[:id])
    if habit.milestone_message
      flash[:notice] = habit.milestone_message
    else
      flash[:notice] = Habit::ENCOURAGEMENT_NUDGES.sample
    end
    redirect_back fallback_location: habits_path
  end

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
    redirect_back fallback_location: habits_path
  end

  def reset_focus
    session[:focus_habit_id] = nil
    session[:focus_habit_date] = nil
    flash[:notice] = "Focus cleared!"
    redirect_to today_habits_path
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
    @habits = Habit.all
    # If no focus is set yet, default to the first habit
    if session[:focus_habit_date] == Date.today || session[:focus_habit_id].blank?
      session[:focus_habit_id] = @habits.first&.id
      session[:focus_habit_date] = Date.today
    end

    @focus_habit = Habit.find_by(id: session[:focus_habit_id])
  end

  def show
    @habit = Habit.find(params[:id])
  end

  private

  def habits_params
    params.require(:habit).permit(:name, :description, :category, :prompt, :reminder_time, :reminders_enabled)
  end
end
