class Robot

attr_reader :position, :items, :items_weight, :health
attr_accessor :equipped_weapon

def initialize
  @position = [0,0]
  @items = []
  @items_weight = 0
  @health = 100
  @hitpoints = 5
  @equipped_weapon = nil
end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def can_pick_up?(item)
      (@items_weight + item.weight) <= 250
  end

  def pick_up(item)
    (@equipped_weapon = item) if item.kind_of? Weapon
    if can_pick_up?(item)
      feed_box(item)
      @items << item
      @items_weight += item.weight
    end
  end 

  def wound(damage)
      if @health - damage < 0
        damage_to_robot = @health
      else
        damage_to_robot = damage
      end
    @health -= damage_to_robot
  end

  def heal!(hearts)
    begin
      raise RobotAlreadyDead if health == 0
      heal(hearts)
    rescue
      puts "Robot is dead, no zombie robots allowed!"
    end  
  end

 def heal(hearts)
      if @health + hearts > 100
        hearts_to_robot = 100 - @health
      else
        hearts_to_robot = hearts
      end
    @health += hearts_to_robot
  end

   def attack!(robot)
     begin
       raise EnemyNotRobot if robot.is_a? Robot
       attack(robot)
     rescue
       puts  "You can only attack other robots"
     end  
   end

  def attack(robot)
    if @equipped_weapon
        if grenade_range?(robot) && (@equipped_weapon.instance_of? Grenade)
          @equipped_weapon.hit(robot)
        elsif in_range?(robot) && !(@equipped_weapon.instance_of? Grenade)
          @equipped_weapon.hit(robot)
        end
    elsif in_range?(robot)
          robot.wound(@hitpoints)
    else
      false
    end
      drop_grenade
  end

  def in_range?(robot)
    x_range = -1..1
    y_range = -1..1
    (x_range.include?(robot.position[0]) && y_range.include?(robot.position[1]))
  end

  def grenade_range?(robot)
    x_range = -2..2
    y_range = -2..2
    (x_range.include?(robot.position[0]) && y_range.include?(robot.position[1]))
  end

  def drop_grenade
    @equipped_weapon = nil if equipped_weapon.is_a?(Grenade)
  end

  def feed_box(item)
    if ( item.kind_of?(BoxOfBolts) && health <= 80 )
      item.feed(self)  
      return
    end
  end






end
