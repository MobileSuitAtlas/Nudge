require "test_helper"

class TagTest < ActiveSupport::TestCase

    # Tests Tags
    test "name should be unique" do
        Tag.create!(name: "Health", color: "#FF0000")
        duplicate = Tag.new(name: "Health", color: "#00FF00")
        assert_not duplicate.valid?
        assert_includes duplicate.errors[:name], "has already been taken"
    end

    test "name should be present" do
        tag = Tag.new(color: "#FF0000")
        assert_not tag.valid?
    end

    test "color should be present" do
        tag = Tag.new(name: "Health")
        assert_not tag.valid?
    end
end