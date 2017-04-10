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

end