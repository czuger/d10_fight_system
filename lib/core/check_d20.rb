require_relative 'check'

class CheckD20 < Check

  private

  def set_results( strict_superiority: false )
    @score = @kept_dices
    target = 10+@bonus
    @success = strict_superiority ? (@score >= target) : (@score > target)
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
        roll ||= Hazard.s2d20.rolls
        @kept_dices = roll.sort.reverse.first
      when :disadvantage
        roll ||= Hazard.s2d20.rolls
        @kept_dices = roll.sort.first
      else
        roll ||= Hazard.s1d20.rolls
        @kept_dices = roll.first
    end
  end
end