require_relative 'tool'

class Weapon < Tool

  attr_reader :reach, :damage

  def initialize( name, hp, skill, difficulty, damage, reach )
    super( name, hp, skill, difficulty )
    @damage = damage
    @reach = reach
  end

  def distance
    reach > 1
  end

end