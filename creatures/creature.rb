require_relative '../skills/protection_skill'
require_relative 'fight'

class Creature

  attr_reader :str, :coo, :will, :mem
  attr_reader :current_position, :current_weapon, :def_mode

  include Fight

  def initialize
    @str = nil
    @coo = nil
    @will = nil
    @mem = nil
    @current_position = nil
    @current_weapon = nil
    @def_mode = nil
  end

  def initiative
    r = Roll.new
    @coo + ( r.critic ? 20 : 0 ) + r.sum
  end

  def distance( creature )
    nbs = [ @current_position, creature.current_position ].sort
    nbs[ 1 ] - nbs[ 0 ]
  end

  def advance_one_step
    if side == :heroes
      @current_position -= 1
    else
      @current_position += 1
    end
  end

end