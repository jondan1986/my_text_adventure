#!/usr/bin/ruby
#game class


class Game
  attr_reader :gameworld
  
  def initialize(gameworld)
    @gameworld = gameworld
    start
  end
  
  def get_input(input, query)
    print query, " >"
    input1 = gets.chomp.downcase
    puts
    #puts "input1=#{input1}"
    input1.gsub!("see","view")
    input1.gsub!("check","view")
    input1.gsub!("kill","attack")
    input1.gsub!("destroy","attack")
    input1.gsub!("quit","exit")
    input1.gsub!("pick up","get")
    input1.gsub!("take","get")
    input1.gsub!("take the","get")
    input1.gsub!("get the","get")
    input1.gsub!("everything", "all")
    input1.gsub!("stuff","inventory")
    input1.gsub!("items","inventory")
    input1.gsub!("look","view")
    input1.gsub!("around","here")
    input1.gsub!("look at","view")
    input1.gsub!("go to","go")
    input1.gsub!("move","go")
    input1.gsub!("move to","go")
    input1.gsub!("run ","go ")
    input1.gsub!("run to","go")
    #puts "input1=#{input1}"
    input += input1.split
    #puts "input=#{input}"
    return input
  end
  
  def start
      
    current_area = Area::START(gameworld)
    
    system("clear")
    puts "-"*40
    puts "Welcome to My Text Adventure"
    puts
    puts "(Type ? for help)"
    puts "-"*40
    
    puts "You wake up.\nYou do not remember who you are."
    print "You decide to call yourself >"
    
    player1 = Player.new(gets.chomp.gsub(" ","-"))
    #player1 = Player.new("Jonathan")
    player1.print_stat_sheet
    player1.move_location(current_area)
    
    #start main game loop
    gameover = false
    input = Array.new

    while(not gameover) do
      catch :new_location do
        #user's turn
        if input.length == 0
          input = self.get_input(input, "\nWhat do you want to do?")
        end
       
        while input.length > 0 and not gameover do
          input_error = true
          word = input.shift
          if (word == "exit")
            return
          end
          
          if (word == "attack")
            if current_area.attack_list.length > 0
              if input.length <= 0
                #list attackable creeps
                
                puts "You can attack:"
                current_area.attack_list.each do |creep|
                  print " #{creep}"
                end
                input = self.get_input(input, "\nAttack Who?")
              end
              input2 = input.shift
    
              #compare input to attackable creeps
              #input2 == creep.name and class == Creep
              missed = true
              for entity in current_area.elements do
                if input2 == entity.name.downcase and entity.is_a?(Creep) 
                  player1.attack(entity)
                  missed = false
                end
              end
              puts "Could not find #{input2} to attack" if missed
              input_error = false
            else
              puts "There's nobody here to attack"
              input.shift
            end
          end
            
          if (word == "view")
            if input.length <= 0
              input = self.get_input(input, "View What?")
            end
            input2 = input.shift
            
            #process view subcommands
            if input2 == "here" or input2 == "all" or input2 == "area"
              current_area.view_deep
            elsif input2 == "inventory"
              player1.list_inventory
            elsif ((entity1 = current_area.elements.detect { |entity2| entity2.name.downcase == input2} ) != nil)
              entity1.print_stat_sheet
            elsif ((entity1 = player1.inventory.detect { |entity2| entity2.name.downcase == input2} ) != nil)
              entity1.print_stat_sheet
            elsif input2 == "me"
              player1.print_stat_sheet
            else
              puts "Could not find: #{input2}"
            end
            
            input_error = false
            input = self.get_input(input, "What do you want to do?")
          end
            
          if (word == "get")
            if input.length <= 0
              input = self.get_input(input, "Get What?")
            end
            input2 = input.shift
            
            #process get subcommands
            if input2 == "all"
              player1.pick_up_items
            elsif ((entity1 = current_area.elements.detect { |entity2| entity2.name.downcase == input2} ) != nil)
              player1.pick_up(entity1)
            else
              puts "Could not find: #{input2}"
            end
            input_error = false
          end
            
          if(word == "use")
            if input.length <= 0
              input = self.get_input(input, "Use What?")
            end
            input2 = input.shift
            if input.length > 0
              if input.shift == "with"
                if input.length <= 0
                  input = self.get_input(input, "Use #{input2} with what?")
                end
                input3 = input.shift
                player1.use_with(player1.get_object(input2),player1.find_object(input3))
              end
            elsif (item = player1.get_object(input2))
              player1.use(item)
            else
              puts "Coud not find #{input2} in your inventory. Try: \"Get #{input2}\" first"
            end
            input_error = false 
          end
          
          if(word == "go")
            if input.length <= 0
              input = self.get_input(input, "Go Where?")
            end
            input2 = input.shift
            
            if (current_area.is_a_link(input2))
              new_area = get_area(input2)
              player1.move_location(new_area)
              current_area = new_area
              throw :new_location
            elsif input2 == "away"
              new_area = current_area.links[0]
              player1.move_location(new_area)
              current_area = new_area
              throw :new_location
            else
              puts "Can't go there."
              current_area.display_links
            end
            input_error = false
          end
          
          if(word == "drop")
            if input.length <= 0
              input = self.get_input(input, "Drop What?")
            end
            input2 = input.shift
            item = player1.get_object(input2)
            if (item != nil)
              #puts item
              player1.drop_item(item)
            elsif (input2 == "all")
              player1.drop_items
            else
              puts "#{input2} is not in your inventory"
            end
          
          input_error = false
          end
          
          if(word == "areas")
            Game::list_all_areas(gameworld)
          end
              
            
          if (word == "help" or word == "?")
            puts "Available commands:"
            puts "-"*40
            puts "attack [name]\t\tattacks [name]"
            puts "view [item]\t\tdisplays info on [item]"
            puts "get [item]\t\tpicks up [item] (or use 'get all')"
            puts "drop [item]\t\tdrops [item] (or use 'drop all')"
            puts "use [item]\t\tuses [item]"
            puts "go [area]\t\tmoves to new [area]. Must be available"
            puts "exit\t\t\texits game"
            puts "? or help\t\tdisplays this message"
            puts "-"*40
            
            input_error = false
            input = self.get_input(input, "What do you want to do?")
          end
            
          if input_error
            puts "#{word} is not a recognized command"
          end
        end
        
        #creeps' turn
        for entity in current_area.list_type(Creep) do
          #attack player1
          gameover = entity.attack(player1) #returns boolean is_dead for gameover
          #puts "gameover = #{gameover}"
        end
      end
    end
  end
  
  def self.find_area(gameworld, name)
    gameworld.each do |area|
      if name == area.name then return area end
    end
    return nil
  end
  
  def self.list_all_areas(gameworld)
    gameworld.each do |area|
      puts "-"*40
      puts "Name:\t\t\t#{area}"
      puts "-"*40
      puts "Description:\t\t#{area.description}"
      puts "Deep description:\t#{area.deep_description}"
      puts "Elements:\t\t #{area.get_elements_string}"
      puts "Links:\t\t\t#{area.get_links_string}"
    end
  end
  
  def get_area(area_name)
    gameworld.each do |area|
      if area.name.downcase == area_name
        return area
      end
    end
    return nil
  end
end