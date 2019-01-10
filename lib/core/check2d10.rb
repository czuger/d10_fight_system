require_relative 'check'

class Check2d10 < Check

  private

  def set_results
    @score = @kept_dices.inject(:+)
    target = 10+@bonus
    @success = (score >= target)
    @critic = false

    if @kept_dices[0] == @kept_dices[1]
      case @roll_type
        when :advantage
          if @roll.count == 3 && @success == false && (@roll[0] != @roll[1] || @roll[2] != @roll[1])
            @critic = false
          else
            @critic = true
          end
        when :disadvantage
          if @roll.count == 3 && @success == true && (@roll[0] != @roll[1] || @roll[2] != @roll[1])
            @critic = false
          else
            @critic = true
          end
        else
          @critic = true
      end
    end

    if @kept_dices == [1, 1]
      @success = false
      @critic = true
    end

    if @kept_dices == [10, 10]
      @success = true
      @critic = true
    end
  end

  def roll_dices(roll)
    case @roll_type
      when :advantage
        @roll ||= Hazard.s3d10.rolls
        @kept_dices = roll.sort.reverse.first(2)
      when :disadvantage
        @roll ||= Hazard.s3d10.rolls
        @kept_dices = roll.sort.first(2)
      else
        @roll ||= Hazard.s2d10.rolls
        @kept_dices = roll.first(2)
    end
  end

  # def keep_dices_in_exceptional_case(roll)
  #   kept_rolls = { roll_keeping_score: -1 }
  #   roll.combination(2).each do |comb|
  #     r = compute_results(comb)
  #     if r[:roll_keeping_score] > kept_rolls[:roll_keeping_score]
  #       kept_rolls = r
  #     end
  #   end
  #   kept_rolls[:dices]
  # end
  #
  # def compute_results(dices)
  #   _, success, critic = check_results(dices)
  #
  #   roll_keeping_score = 0
  #
  #   roll_keeping_score = 2 if !success
  #   roll_keeping_score = 1 if !success && critic
  #
  #   roll_keeping_score = 3 if success
  #   roll_keeping_score = 4 if success && critic
  #
  #   { dices: dices, roll_keeping_score: roll_keeping_score }
  # end
  #
  # def check_results(dices)
  #   score = dices.reduce(:+)
  #   target = 10+@bonus
  #   success = (score >= target)
  #
  #   critic = dices[0] == dices[1]
  #
  #   if dices[0] == dices[1] && dices[1] == 1
  #     success = false
  #     critic = true
  #   end
  #
  #   if dices[0] == dices[1] && dices[1] == 10
  #     success = true
  #     critic = true
  #   end
  #
  #   [ score, success, critic ]
  # end
end