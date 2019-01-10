require_relative 'check'

class CheckD20 < Check

  private

  def set_results
    @score = @kept_dices
    target = 10+@bonus
    @success = (score >= target)
    @critic = false

    if @kept_dices == 1
      @success = false
      @critic = true
    end

    if @kept_dices == 20
      @success = true
      @critic = true
    end
  end

  def roll_dices(roll)
    if @advantage
      @kept_dices = roll.sort.reverse.first
    else
      @kept_dices = roll.first
    end
  end
end