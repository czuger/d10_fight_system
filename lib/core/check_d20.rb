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
    case @roll_type
      when :advantage
        @kept_dices = roll.sort.reverse.first
      when :disadvantage
        @kept_dices = roll.sort.first
      else
        @kept_dices = roll.first
    end
  end
end