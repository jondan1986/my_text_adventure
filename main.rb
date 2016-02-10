#!/usr/bin/ruby
#main.rb
#
# Need to add commands: use, talk, move/go
# Need to add item effects, item value
# Need to add money
# npcs and npc behavior
# start writing story

require 'nokogiri'

require_relative 'Character'
require_relative 'Player'
require_relative 'Creep'
Dir[File.dirname(__FILE__) + '/Creeps/*.rb'].each {|file| require file }
require_relative 'Item'
Dir[File.dirname(__FILE__) + '/Items/*.rb'].each {|file| require file }
require_relative 'Area'
require_relative 'Game'

#gamesetup
gameworld = Array.new #for storing areas

doc = Nokogiri::XML(File.open("assets/GameWorld.xml"))
areas = doc.xpath("//Area")
areas.each do |area|
  #1. get area info, create new area object and place into gameworld
  
  area_name = area.children.css("name").first.content
  area_description = area.children.css("description").first.content
  area_deep_description = area.children.css("deep_description").first.content
  
  #build xml container for items/creeps
  container_list = Array.new
  xml_container = area.children.css("container")
  
  #add creeps
  xml_container.children.css("creeps creep").each do |creep|
    quantity = (creep.css("quantity").first.content).to_i
    for i in Range.new(1,quantity) do
      container_list.push(eval(creep.children.css("class").first.content).new(i))
    end
  end
  
  #add items
  xml_container.children.css("items item").each do |item|
    quantity = (item.css("quantity").first.content).to_i
    for i in Range.new(1,quantity) do
      container_list.push(eval(item.children.css("class").first.content).new)
    end
  end
  
  #create new area object and add it to gameworld(creating links later)
  gameworld.push(Area.new(area_name,area_description, container_list, Array.new, area_deep_description))
end

#2. create links
areas.each do |area|
  area_name = area.children.css('name').first.content
  area.children.css("links link").each do |link|
    area_link = Game::find_area(gameworld, link.content)
    if(area_link != nil)
      Game::find_area(gameworld, area_name).add_link(area_link)
    end
  end
end

#Game::list_all_areas(gameworld)

Game.new(gameworld)

puts "---Game Over---"


