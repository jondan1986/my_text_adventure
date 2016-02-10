#!/usr/bin/ruby
#Area Class
#one area is a location on the map, where stuff can happen
#can contain creeps, players, items, and story elements

class Area
  attr_accessor :description, :name, :deep_description
  
  def self.START(gameworld)
    return Game::find_area(gameworld, "Field1")
  end
  
  def initialize(name = "Default", description = "Default Description", container = Array.new, links = Array.new, deep_description = "Default in Depth description")
    @name = name
    @description = description
    @container = Array.new
    container.each do |entity|
      self.add_element(entity)
    end
    @links = links #paths to new areas
    @deep_description = deep_description
  end
  
  def add_element(object)
    @container.push(object)
    object.location = self
  end
  
  def remove_element(object)
    return @container.delete(object)
  end
  
  def list_elements
    puts "Things at this location:"
    element_list = Array.new(@container) #create a copy so we don't modify @container
    #delete hidden elements
    element_list.keep_if { |entity| entity.visible}
    names = element_list.map { |item| item.to_s }
    for item in names.uniq do
      if(names.count(item) > 1)
        puts "  " + item.to_s + " (" + names.count(item).to_s + ")"
      else
        puts "  " + item.to_s
      end
    end
    puts
    (element_list.keep_if {|entity| entity.is_a?(Creep) and entity.is_hostile}).each do |creep|
      puts "#{creep} is about to attack!"
    end
    puts
    self.display_links
    return
  end
  
  def print_elements
    self.elements.each do |entity|
      print " #{entity}" if entity.visible
    end
  end
  
  def links
    return @links 
  end
  
  def add_link(area)
    @links.push(area) 
  end
  
  def print_links
    self.links.each do |link|
      print " #{link.name}"
    end
    print "\n"
  end
  
  def display_links
    puts "Places you can go:"
    self.links.each do |link|
      puts "  #{link.name}"
    end
    puts
  end
  
  def get_object(object)
    #returns the object if found in area, otherwise returns nil
    if object.is_a?(String)
      #match name of object
      for entity in self.elements do
        if entity.name.downcase == object
          return entity
        end
      end
      return nil
    else
      #match object itself
      for entity in self.elements do
        if entity == object
          return entity
        end
      end
      return nil
    end
  end
  
  def elements
    return @container
  end
  
  def attack_list
    list = Array.new
    for entity in list_type(Creep) do
      if entity.is_alive
        list.push(entity)
      end
    end
    return list
  end
  
  def list_type(klass)
    list = Array.new
    self.elements.each do |entity|
      if entity.is_a?(klass) then list.push(entity) end
    end
    return list
  end
  
  def get_elements_string
    str = ""
    self.elements.each do |entity|
      str += " #{entity}" if entity.visible
    end
    return str
  end
  
  def get_links_string
    str = ""
    self.links.each do |link|
      str += " #{link}"
    end
    return str
  end
  
  def is_a_link(name)
    if(name.is_a?(String))
      self.links.each do |link|
        if link.name.downcase == name
          return true
        end
      end
    else
      self.links.each do |link|
        if link == name
          return true
        end
      end
    end
    return false
  end
  
  def view_deep
    puts "You take a better look of the area"
    puts self.deep_description
    
    #unhide hidden items
    @container.each do |item|
      if item.is_a?(Item)
        if not item.visible
          item.visible = true
          puts "You find: #{item}"
        end
      end
    end
    self.list_elements
    puts
  end
  
  def to_s
    return self.name
  end
end