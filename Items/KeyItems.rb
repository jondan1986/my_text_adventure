#!/usr/bin/ruby
#item classes key game items

class ScrapMetal < Item
  def initialize()
    name = "ScrapMetal"
    effect_desc = "Remnants of a crash or explosion...or both maybe"
    effect = "do_nothing"
    amount = 0
    consumable = false
    use_message = "Maybe I could use this to build something"
    use_with_list = Array.new
    visible = false
    gettable = true
    super(name, effect_desc, effect, amount, consumable, use_message, \
          use_with_list, visible, gettable)
  end
end

class JetEngine < Item
  def initialize()
    name = "JetEngine"
    effect_desc = "Used to be a proud part of an airliner. Now, it is not"
    effect = "do_nothing"
    amount = 0
    consumable = false
    use_message = "You can't use this"
    use_with_list = Array.new
    visible = false
    gettable = false
    super(name, effect_desc, effect, amount, consumable, use_message, \
          use_with_list, visible, gettable)
  end
end
