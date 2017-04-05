require_relative 'item'
require_relative '../skills/skills'
require_relative '../core/def_module'

class Tool < Item

  attr_reader :difficulty, :skill

  include DefModule

  def initialize( name, hp, skill, difficulty )
    super( name, hp )
    @skill = Skill.get( skill )
    @difficulty = difficulty
  end

end