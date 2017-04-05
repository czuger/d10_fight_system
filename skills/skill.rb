class Skill

  attr_reader :protection

  def initialize( name, trait )
    @xp = 0
    @protection = false
    @name = name
    @trait = trait
  end

  def level
    @xp / 50 / 2
  end

  def increase_skill
    @xp += 1
  end

  def bonus( creature )
    raise "#{creature.inspect} does not have #{@trait.inspect}" unless creature.respond_to?( @trait )
    level + creature.send( @trait )
  end

end