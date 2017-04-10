require_relative 'weapon'

class Items

  ITEMS = {
    bow: Weapon.new( :bow, 2, :shoot, 2, Damage.new( 8 ), 10 ),
    sword: Weapon.new( :sword, 6, :melee, 2, Damage.new( 6 ), 1 ),
    shield: Tool.new( :shield, 4, :shield, 2 )
  }

  def self.get( item_name )
    raise "Item #{item_name} does not exist" unless ITEMS.has_key?( item_name)
    ITEMS[ item_name ].clone
  end

end