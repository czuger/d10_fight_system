require 'active_record'

require_relative '../core/bonus'

class CreatureSkill < ActiveRecord::Base

  belongs_to :creature
  belongs_to :skill

  include Bonus

  def name
    skill.name
  end

  def level
    xp / 50 / 2
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
    puts 'XP gain'.yellow
    increment!( :xp )
  end

  def damage_item
  end

  def damage_bonus( _ )
    0
  end

  private

  def get_skill_link
    self
  end

end