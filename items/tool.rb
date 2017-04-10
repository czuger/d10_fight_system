require_relative 'item'
require_relative 'damage_item'
require_relative 'item_skill'

class Tool < Item

  attr_reader :skill

  include ItemSkill
  include DamageItem

  def initialize( name, hp, skill, difficulty )
    super( name, hp )
    @skill = PopulateSkills.get(skill )
    @difficulty_value = difficulty
  end

end