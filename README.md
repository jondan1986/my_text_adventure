# My Text Adventure

This is a text-based adventure game written in Ruby. The player wakes up with amnesia on a mysterious island and must uncover the secrets of their surroundings.

## Story

The player awakens on an island with no memory of how they got there. A nearby sign points the way toward "answers." As the player explores, they find evidence of a plane crash and strange, glitch-like tears in the fabric of reality, marked with the letters "AAP."

After completing a series of quests for an NPC, the player pieces together the crashed plane and attempts to escape. However, they discover the island is enclosed in a digital bubble, a prison crafted by the "Anonymous Amateur Programmer." The player learns they are a digital copy of a real person, trapped in this game.

The AAP, seeing the error of his ways, offers the player a choice: gain superpowers and live forever within the game, or be terminated and find peace.

## How to Play

1.  **Install Ruby:** Make sure you have Ruby installed on your system.
2.  **Install Dependencies:** This project uses the `nokogiri` gem to parse the game world data. Install it with the following command:
    ```bash
    gem install nokogiri
    ```
3.  **Run the Game:** Start the game by running the `main.rb` script:
    ```bash
    ruby main.rb
    ```

## Game World

The game world is composed of several interconnected areas, including beaches, forests, cliffs, and mysterious "NegaWorld" and "CtrlRoom" zones.

![Game World Map](MyTextAdventure%20GameWorld.jpg)

## Game-related files
*   `Player.rb`: The player character.
*   `Creep.rb`: The base class for enemies.
*   `Item.rb`: The base class for items.
*   `Area.rb`: Represents a location in the game world.
*   `Game.rb`: The main game loop and logic.
*   `assets/GameWorld.xml`: Defines the areas, items, and creeps in the game world.
*   `Story.txt`: The full story of the game.

## Other files
This project also contains some files for a Ruby on Rails application. These files are not used for the text adventure game and can be ignored.
* `Gemfile`
* `config.ru`
* `application_controller.rb`
* `README.rdoc`
