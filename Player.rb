#!/usr/bin/ruby
#player class

require_relative "Item.rb"

class Player < Character
  Exp_factor = 25
  Atk_factor = 1.2
  HP_factor = 1.2
  attr_accessor :level, :experience
  
  def initialize(name)
    super(name)
    @level = 1
    @experience = 0
  end
  
  def print_stat_sheet
    puts "----------------------------------"
    puts "Name:        #{self.name}"
    puts "----------------------------------"
    puts "Level:       #{self.level}"
    puts "Health:      #{self.hp} / #{self.max_hp}"
    puts "Base Attack: #{self.base_attack}"
    puts "Experience:  #{self.experience}"
    puts "Items:       #{self.inventory_to_s}"
    puts "----------------------------------"
  end
  
  def print_name
    puts "Your name is #{self.name}"
  end
  
  def pick_up_items
    items = Array.new
    
    self.location.elements.each do |item|
      if item.is_a?(Item) and item.visible
        items.push(item) if item.gettable
      end
    end
    
    while items.length > 0
      self.get_item(item = self.location.remove_element(items.pop))
      puts "#{self} picks up: #{item}"
    end
  end
  
  def pick_up(entity)
    if(entity.is_a?(Item))
      if(entity.gettable)
        self.get_item(self.location.remove_element(entity)) 
        puts "#{self} picks up: #{entity}"
      else
        puts "You cannot pick up this item"
      end
    end
  end
  
  def move_location(new_location)
    #load new location, give player new location description 
    #check if already there
    if(self.location == new_location)
      puts "#{self} is already at this location."
      return
    end
    self.location.remove_element(self)
    new_location.add_element(self)
    puts self.location.description
    puts
    self.location.list_elements
    return
  end
  
  def take_damage(damage)
    killed = super(damage)
    self.show_health
    return killed
  end
  
  def show_health
    puts "#{self} HP: #{self.hp} / #{self.max_hp}"
  end
  
  def gain_experience(amount)
    self.experience += amount
    #check for levelup
    new_level = ((Math.sqrt((Exp_factor ** 2) + ((4 * Exp_factor) * self.experience))-Exp_factor) / (2 * Exp_factor)+1)

    lvls = new_level.to_i - self.level
    #puts "lvls=#{lvls}"
    while(lvls > 0)
      self.level_up
      lvls -= 1
    end
  end
  
  def level_up
    self.level += 1
    self.base_attack = (self.base_attack * Atk_factor).to_i
    self.max_hp = (self.max_hp * HP_factor).to_i
    self.hp = self.max_hp
    puts "#{self} leveled up to #{self.level}!!! Congrats!"
    self.print_stat_sheet
  end
  

  
  def use_with(object1, object2)
    if(object1.is_a?(Item) and object2.is_a?(Item))
      puts "#{object1} does not work with #{object2}"
    else
      puts "Both things must be items"
    end
  end
end

