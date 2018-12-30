require_relative 'check'

class Check2d10 < Check

  attr_reader :kept_dices

  def roll(difficulty: 10, bonus: 0, advantage: false)
    @misc_bonus = bonus
    @bonus = @attribute - 10 + @skill + @misc_bonus
    @malus = difficulty
    @advantage = advantage

    roll_dices

    set_results
    set_status

    self
  end

  private

  def set_results
    @score = @kept_dices.reduce(:+) + @bonus
    @success = @score - @malus >= 0
    @critic = @kept_dices[0] == @kept_dices[1]
  end

  def roll_dices
    if @advantage
      @roll = Hazard.s3d10
      @kept_dices = @roll.rolls.sort.reverse[0..1]
    else
      @roll = Hazard.s2d10
      @kept_dices = @roll.rolls
    end

  end

end