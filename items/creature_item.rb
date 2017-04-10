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

end