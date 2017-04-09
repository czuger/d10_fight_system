require_relative '../items/item_skill'

class Skill

  attr_accessor :xp

  include ItemSkill

  def initialize( name, trait, difficulty )
    @xp = 0
    @name = name
    @trait = trait
    @difficulty_value = difficulty
  end

  def level
    @xp / 50 / 2
  end

  def print
    "#{@name} : #{level}"
  end

end