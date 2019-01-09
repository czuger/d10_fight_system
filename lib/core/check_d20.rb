require_relative 'check'

class CheckD20 < Check

  private

  def set_results
    @score = @kept_dices + @bonus
    @success = @score >= 10
    @critic = [ 1, 20 ].include?( @kept_dices )
  end

  def roll_dices(roll)
    if @advantage
      @kept_dices = roll.sort.reverse.first
    else
    @kept_dices = roll.is_a?(Array) ? roll.first : roll
    end
  end
end