require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get habits_path
    assert_response :success
  end

  test "should get show" do
    get habit_path(1)
    assert_response :success
  end
end
