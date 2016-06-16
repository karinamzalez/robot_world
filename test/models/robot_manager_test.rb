require_relative '../test_helper'

class RobotManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_robot
    create_robots(1)
    robot = robot_manager.find(1)

    assert_equal "TDD", robot.
    assert_equal "Learn to Test", robot.description
    assert_equal 1, robot.id
  end
end
