require_relative 'check'

class Check2d10 < Check

  def roll(difficulty = 10, bonus = 0)
    @roll = Hazard.s2d10

    @misc_bonus = bonus
    @bonus = @attribute - 10 + @skill + @misc_bonus
    @malus = difficulty

    set_results
    set_status

    self
  end

  private

  def set_results
    p self
    @score = @roll.result + @bonus
    @success = @score - @malus >= 0
    @critic = @roll.rolls[0] == @roll.rolls[1]
  end

end