require_relative 'item'
require_relative 'damage_item'
require_relative 'item_skill'

class Tool < Item

  include DamageItem

end