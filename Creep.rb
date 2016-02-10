#!/usr/bin/ruby
#creep class

class Creep < Character
  attr_accessor :xp, :is_hostile
  
  def initialize(name, atk, hp, xp, hostile)
    super(name)
    @xp = xp
    @max_hp = hp
    @hp = @max_hp
    @base_attack = atk
    @is_hostile = hostile
  end
  
  def print_stat_sheet
    puts "----------------------------------"
    puts "Name:        #{self.name}"
    puts "----------------------------------"
    puts "Health:      #{self.hp} / #{self.max_hp}"
    puts "Base Attack: #{self.base_attack}"
    puts "XP Reward:   #{self.xp}"
    puts "Items:       #{self.inventory_to_s}"
    puts "----------------------------------"
  end    
  
  def kill(killer)
    puts "#{killer.name} killed #{self.name}!"
    @alive = false
    self.drop_items
    self.name += " (Dead)"
    self.hp = 0
    self.is_hostile = false
    if killer.is_a?(Player)
      killer.gain_experience(self.xp)
    end
  end
  
  def attack(other)
    if self.is_hostile and self.is_alive
      super(other)
    end
  end
  
  def print_name
    puts "This creep is a #{self.name}"
  end
  
  def generate_item(item,spawn_rate)
    if(Random.new.rand(100) < spawn_rate)
      self.get_item(item)
    end
  end
end