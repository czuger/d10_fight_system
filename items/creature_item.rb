require 'active_record'

class CreatureItem < ActiveRecord::Base

  belongs_to :creature
  belongs_to :item
  belongs_to :creature_skill

  def name
    item.name
  end

  def level
    creature_skill.level
  end

  def reach
    item.reach
  end

  def difficulty
    item.difficulty
  end

  def bonus( creature )
    s = self
    raise "#{creature.inspect} does not have #{s.creature_skill.trait.inspect}" unless creature.respond_to?( s.creature_skill.trait )
    s.level + creature.send( s.creature_skill.trait ) - 10
  end

  def distance
    reach > 1
  end

  def gain_xp
    creature_skill.gain_xp
  end

  def damage_item
    decrement!( :hp )
  end

  def damage
    # p item
    item.damage
  end

end