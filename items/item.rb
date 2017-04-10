require 'active_record'

class Item < ActiveRecord::Base

  belongs_to :skill

  def print
    "#{name} : ( hp:#{hp} ) "
  end

end