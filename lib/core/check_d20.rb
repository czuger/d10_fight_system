require_relative 'check'

class CheckD20 < Check

  private

  def set_results
    @score = @kept_dices + @bonus
    @success = @score - @malus >= 0
    @critic = [ 1, 20 ].include?( @kept_dices )
  end

  def roll_dices
    if @advantage
      @roll = Hazard.s2d20
      @kept_dices = @roll.rolls.sort.reverse.first
    else
      @roll = Hazard.d20
      @kept_dices = @roll
    end
  end
end