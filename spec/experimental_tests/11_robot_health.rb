require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @laser = Laser.new
  end

  
  describe "#heal!" do
    it "should throw error if robot is dead (health = 0)" do
      @robot.wound(100)
     # @robot.heal!(20)
      expect {@robot.heal!(20)}.to raise_error Robot::RobotAlreadyDead
    end

    it "doesn't increase health over 100" do
      @robot.heal(10)
      expect(@robot.health).to eq(100)
    end
  end

  describe "#attack" do
    it "wounds other robot with weak default attack (5 hitpoints)" do
      robot2 = Robot.new

      # Create an expectation that by the end of this test,
      # the second robot will have had #wound method called on it
      # and 5 (the default attack hitpoints) will be passed into that method call
      expect(robot2).to receive(:wound).with(5)

      # This is what will trigger the wound to happen on robot2
      @robot.attack(robot2)
    end
  end
end
