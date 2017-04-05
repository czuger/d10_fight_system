require_relative 'monster'
require_relative '../../items/items'

class Kobold < Monster

  def initialize

    @str = 8
    @coo = 12
    @will = 6
    @mem = 2

    @hp = 4

    @def_mode = Skills.get( :dodge )
    @current_weapon = Items.get( :sword )
    @current_position = 1

  end

end