#!/usr/bin/ruby
#item classes for creep drops

class Squishy < Item
  def initialize()
    name = "Squishy"
    effect_desc = "Often dropped by slimes"
    effect = "do_nothing"
    amount = 0
    consumable = false
    use_message = "You squeeze the squishy **SKWISH**"
    super(name, effect_desc, effect, amount, consumable, use_message)
  end
end