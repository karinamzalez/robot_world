ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/emoji'
require 'tilt/erb'
require 'capybara/dsl'

module TestHelpers
  def teardown
    robot_manager.delete_all
    super
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager_test')
    @robot_manager ||= RobotManager.new(database)
  end

  def create_robots(num)
    # @counter = 1
    num.times do |i|
      robot_manager.create({:name => "lala", city: "beep boop"})
      # @counter += 1
    end
  end
end

Capybara.app = TaskManagerApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
