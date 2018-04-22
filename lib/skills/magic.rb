require_relative 'skill'
require_relative '../core/damage'
require_relative '../items/old/damage_item'

class Magic < Skill

  include DamageItem

  def distance
    reach > 1
  end

end
