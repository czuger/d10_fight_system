require_relative 'monster'

class Kobold < Monster

  def initialize

    @str = 8
    @coo = 12
    @will = 6
    @mem = 2

    @hp = 4

    @def_mode = PopulateSkills.get(:dodge )
    @current_weapon = PopulateItems.get(:sword )
    @current_position = 1

  end

end