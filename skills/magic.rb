require_relative 'skill'
require_relative '../core/damage'

class Magic < Skill

  attr_reader :damage, :reach

  def initialize( name, trait, difficulty, damage )
    super( name, trait )
    @damage = damage
    @reach = 10
  end

end
