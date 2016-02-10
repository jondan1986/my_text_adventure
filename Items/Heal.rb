#!/usr/bin/ruby
#healing items
#def initialize(name, effect_desc, effect, amount, consumable, use_message)

class Potion < Item
  def initialize()
    name = "Potion"
    effect_desc = "Restores 50 HP"
    effect = "heal"
    amount = 50
    consumable = true
    use_message = "Restored HP!"
    super(name, effect_desc, effect, amount, consumable, use_message)
  end
end