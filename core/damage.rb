require 'active_record'

class Damage < ActiveRecord::Base

  def roll
    sum = 0
    nb_dices.times do
      sum += rand( 1 .. dices_side )
    end
    sum + bonus
  end

end