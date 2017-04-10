require_relative 'monster'

class Imp < Monster

  def initialize

    @str = 2
    @coo = 8
    @will = 6
    @mem = 6

    @hp = 2

    @def_mode = PopulateSkills.get(:dodge )
    @current_weapon = PopulateSkills.get(:imp_blast )
    @current_position = 3

  end

end