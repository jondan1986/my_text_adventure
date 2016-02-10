#!/usr/bin/ruby
#Item class

class Item
  attr_accessor :name, :location, :effect_desc, :effect, :amount, :consumable, \
                :use_message, :use_with_list, :visible, :gettable
  
  def initialize(name, effect_desc, effect, amount, consumable, use_message, \
    use_with_list = Array.new, visible = true, gettable = true)
    @name = name
    @effect_desc = effect_desc
    @effect = effect
    @amount = amount
    @consumable = consumable
    @use_message = use_message
    @use_with_list = use_with_list
    @visible = visible
    @gettable = gettable
  end
  
  def to_s
    return self.name
  end
  
  def print_stat_sheet
    puts "----------------------------------"
    puts "Name:        #{self.name}"
    puts "----------------------------------"
    puts "Effect:      #{self.effect_desc}"
    puts "----------------------------------"
  end
  
  def is_alive
    return false
  end
  
  def use_with_check(item)
    self.use_with_list.each do |list_item|
      if list_item == item
        return true
      end
    end
    return false
  end
end