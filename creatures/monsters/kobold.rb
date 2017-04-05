require_relative 'monster'
require_relative '../../items/items'

class Kobold < Monster

  @@kobold_no = 1

  def initialize

    @str = 8
    @coo = 12
    @will = 6
    @mem = 2

    @hp = 4

    @def_mode = Skills.get( :dodge )
    @current_weapon = Items.get( :sword )
    @current_position = 1

    @kobold_no = @@kobold_no
    @@kobold_no += 1

  end

  def name
    "Kobold #{@kobold_no}"
  end

end