require 'active_record'

class CreatureSkill < ActiveRecord::Base

  belongs_to :creature
  belongs_to :skill

  def name
    skill.name
  end

  def level
    xp / 50 / 2
  end

  def bonus( creature )
    s = self
    raise "#{creature.inspect} does not have #{s.skill.trait.inspect}" unless creature.respond_to?( s.skill.trait )
    s.level + creature.send( s.skill.trait ) - 10
  end

  def reach
    # p skill
    skill.reach
  end

  def difficulty
    skill.difficulty
  end

  def distance
    reach > 1
  end

  def damage
    skill.damage
  end

  def trait
    skill.trait
  end

  def gain_xp
    increment!( :xp )
  end

  def damage_item
  end

end