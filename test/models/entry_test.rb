require "test_helper"

class EntryTest < ActiveSupport::TestCase

    # Entry Tests
    test "content should be present" do
        habit = Habit.create!(name: "Test Habit")
        entry = Entry.new(content: "", habit: habit)
        assert_not entry.valid?
        assert_includes entry.errors[:content], "can't be blank"
    end

    test "entry_date should default to today" do
        habit = Habit.create!(name: "Test Habit")
        entry = Entry.create!(content: "Test Entry", habit: habit)
        assert_equal Date.today, entry.entry_date
    end
    
    test "should belong to habit" do
        entry = Entry.create(content: "test")
        assert_not entry.valid?
    end
end

