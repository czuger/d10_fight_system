require 'active_record'

require_relative '../items/item_skill'
require_relative '../core/damage'

class Skill < ActiveRecord::Base

  include ItemSkill

  belongs_to :damage, optional: true

  def level
    xp / 50 / 2
  end

  def print
    "#{name} : #{level}"
  end

end