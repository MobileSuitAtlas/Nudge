require "test_helper"

class HabitTest < ActiveSupport::TestCase

  test "name should be present" do
    habit = Habit.new(name: "")
    assert_not habit.valid?
    assert_includes habit.errors[:name], "can't be blank - every habit needs a name!"
  end

  # Wide Streaks Test Section

  # No check-ins
  test "current_streak returns 0 with no check-ins" do
    habit = Habit.create!(name: "Test Habit")
    assert_equal 0, habit.current_streak
  end

  # Consecutive days is correct
  test "current_streak counts consecutive days" do
    habit= Habit.create!(name: "Test Habit")

    # Create 3 tests dates
    3.times { |i| habit.check_ins.create!(date: Date.today - i) }

    assert_equal 3, habit.current_streak
  end

  # Longest streak
  test "longest_streak tracks best streak" do
    habit = Habit.create!(name: "Test Habit")
    # Test 3 day streak
    habit.check_ins.create!(date: Date.today - 10)
    habit.check_ins.create!(date: Date.today - 11)
    habit.check_ins.create!(date: Date.today - 12)
    # Test 5 day streak. Should update for longest streak
    5.times { |i| habit.check_ins.create!(date: Date.today - i) }

    assert_equal 5, habit.longest_streak
  end


  # Broken Streak Section

  # Broken Streak
  test "current_streak is 1 when only today is checked in" do
    habit = Habit.create!(name: "Test Habit")

    # Only Today
    habit.check_ins.create!(date: Date.today)

    assert_equal 1, habit.current_streak
  end

  # Broken Longest Streak
  test "longest_streak remembers past streak after reset" do
    habit = Habit.create!(name: "Test Habit")
    
    # 1st 5 day streak
    5.times { |i| habit.check_ins.create!(date: Date.today - i - 5) }
    # 3 day break of no check_ins
    # New Current Streak - Today start
    habit.check_ins.create!(date: Date.today)

    assert_equal 1, habit.current_streak  # this should be 1 for the "Today Start"
    assert_equal 5, habit.longest_streak  # this should remain 5 for "Longest Streak"
  end
end