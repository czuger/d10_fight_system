require_relative 'skill'
require_relative '../items/damage_item'

class ProtectionSkill < Skill

  include DamageItem

  def initialize( name, trait, difficulty )
    super( name, trait, difficulty )
  end

end
