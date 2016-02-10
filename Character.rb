#!/usr/bin/ruby
#class Character

#need to group multiple items-> Potion (2)

require_relative 'Item.rb'

class Character
  attr_accessor :name, :hp, :max_hp, :base_attack, :location
  attr_reader :visible
    
  def initialize(name)
    @name=name
    @max_hp = 100
    @hp = @max_hp
    @base_attack = 10
    @alive = true
    @location = Area.new
    @inventory = Array.new
    @visible = true
  end
  
  def print_name
    puts "This character's name is #{self.name}"
  end
  
  def print_stat_sheet
    puts "----------------------------------"
    puts "Name:        #{self.name}"
    puts "----------------------------------"
    puts "Health:      #{self.hp} / #{self.max_hp}"
    puts "Base Attack: #{self.base_attack}"
    puts "Items:       #{self.inventory_to_s}"
    puts "----------------------------------"
  end
  
  def attack(other)
    attackVal = self.base_attack
    if self.location == other.location
      puts "#{self} attacks #{other} for #{attackVal}!"
      killed = other.take_damage(attackVal)
    elsif not other.is_alive
      puts "#{other} is already dead."
    elsif not other.location == self.location
      puts "#{other} is not in the same location as #{self}"
    else
      puts "something went wrong..."
    end
    
    if killed then other.kill(self) end
      
    return other.is_dead
  end
  
  def take_damage(damage)
    killed = false
    self.hp -= damage
    if(self.hp <= 0)
      killed = true
    end
    return killed
  end
  
  def heal(amount)
    self.hp += amount
    if self.hp > max_hp
      self.hp = max_hp
    end
    self.show_health
  end
  
  def use(item)
    if item.is_a?(Item)
      if item.consumable
        puts "#{self} uses #{item}"
        self.inventory.delete_at(self.inventory.index(item))
      end
      puts item.use_message
      self.send(item.effect, item.amount)
    else
      puts "You cannot use #{item}, it is not an item"
    end
  end
  
  def is_alive
    return @alive
  end
  
  def is_dead
    return (not @alive)
  end
  
  def kill(killer)
    puts "#{killer.name} killed #{self.name}!"
    @alive = false
    self.name += " (Dead)"
    self.hp = 0
  end
  
  def drop_items
    while(@inventory.length > 0) do
      self.drop_item(@inventory[0])
    end
  end
  
  def drop_item(item)
    dropped_item = @inventory.delete_at(@inventory.index(self.get_object(item)))
    self.location.add_element(dropped_item)
    puts "#{self} dropped: #{item}"
    return dropped_item
  end
  
  def inventory
    return @inventory
  end
  
  def list_inventory
    puts "#{self}'s Stuff:"
    puts self.inventory_to_s
  end
  
  def inventory_to_s
    str = ""
    names = inventory.map { |item| item.to_s}
    for item in names.uniq do
      if(names.count(item) > 1)
        str += (item.to_s + " (" + names.count(item).to_s + "), ")
      else
        str += (item.to_s + ", ")
      end
    end
    return str[0..-3]
  end
  
  def get_item(item)
    @inventory.push(item)
  end
  
  def find_object(name)
    #search first through inventory
    #if not found search next through location
    #return as soon as a match is found
    #return nil if no mach is found
    self.inventory.each do |entity|
      if entity.name == name
        return entity
      end
    end
    self.location.elements.each do |entity|
      if entity.name == name
        return entity
      end
    end
    return nil
  end
  
    def get_object(object)
    #returns the object if found in inventory, otherwise returns nil
    if object.is_a?(String)
      #match name of object
      for entity in self.inventory do
        if entity.name.downcase == object
          return entity
        end
      end
      return nil
    else
      #match object itself
      for entity in self.inventory do
        if entity == object
          return entity
        end
      end
      return nil
    end
  end
  
  def do_nothing(amount)
  end
  
  def to_s
    return self.name
  end
end