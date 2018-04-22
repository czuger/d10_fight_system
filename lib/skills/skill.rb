require 'active_record'

require_relative '../items/old/item_skill'
require_relative '../core/damage'

class Skill < ActiveRecord::Base

  belongs_to :damage, optional: true

  def print
    "#{name} : #{level}"
  end

end