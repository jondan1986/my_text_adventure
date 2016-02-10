#!/usr/bin/ruby
#class Slime, SuperSlime

class Slime < Creep
  def initialize(number)
    super("Slime"+number.to_s, 1, 10, 10, true)
    self.generate_item(Squishy.new, 90)
    self.generate_item(Potion.new, 40)
  end
end

class SuperSlime < Creep
  def initialize(number)
    super("SuperSlime"+number.to_s, 10, 20, 30, true)
    self.generate_item(Squishy.new, 90)
    self.generate_item(Potion.new, 60)
    self.generate_item(Candy.new, 10)
  end
end

