require 'active_record'

class Item < ActiveRecord::Base


  def print
    "#{name} : ( hp:#{hp} ) "
  end

end