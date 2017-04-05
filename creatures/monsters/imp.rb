require_relative 'monster'
require_relative '../../items/items'
require_relative '../../skills/skills'

class Imp < Monster

  def initialize

    @str = 2
    @coo = 8
    @will = 6
    @mem = 6

    @hp = 2

    @def_mode = Skills.get( :dodge )
    @current_weapon = Skills.get( :imp_blast )
    @current_position = 3

  end

end