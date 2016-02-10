#!/usr/bin/ruby
#Special Effect items

class Candy < Item
  def initialize()
    name = "Candy"
    effect_desc = "Grants 200 Experience"
    effect = "gain_experience"
    amount = 200
    consumable = true
    use_message = "Gained Experience!"
    super(name, effect_desc, effect, amount, consumable, use_message)
  end
end
