require 'active_record'

require_relative '../core/bonus'

class CreatureItem < ActiveRecord::Base

  belongs_to :creature
  belongs_to :item
  belongs_to :creature_skill

  include Bonus

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

  def damage_bonus( attacker )
    if creature_skill.trait == 'str'
      puts "Force used, damage bonus : #{attacker.str - 10}"
      return attacker.str - 10
    end
    0
  end

  private

  def get_skill_link
    creature_skill
  end

end