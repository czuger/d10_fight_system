class Damage

  def initialize( dices_side = 6, nb_dices = 1, bonus = 0 )
    @dices_side = dices_side
    @nb_dices = nb_dices
    @bonus = bonus
  end

  def roll
    sum = 0
    @nb_dices.times do
      sum += rand( 1 .. @dices_side )
    end
    sum + @bonus
  end

end