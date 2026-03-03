require "test_helper"

class BadgeTest < ActiveSupport::TestCase

    # Tests Badge
    test "requirement_days should be positive" do
        badge = Badge.new(
            name: "Test Badge",
            icon: "🏆",
            requirement_days: -1
        )
        assert_not badge.valid?
    end

    test "name should be present" do
        badge = Badge.new(requirement_days: 7)
        assert_not badge.valid?
    end
end