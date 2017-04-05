require_relative 'skill'
require_relative '../core/damage'
require_relative '../items/damage_item'

class Magic < Skill

  attr_reader :damage, :reach

  include DamageItem

  def initialize( name, trait, difficulty, damage )
    super( name, trait, difficulty )
    @damage = damage
    @reach = 10
  end

  def distance
    reach > 1
  end

end
