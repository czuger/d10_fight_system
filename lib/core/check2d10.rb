require_relative 'check'

class Check2d10 < Check

  private

  def set_results
    @score, @success, @critic = check_results(@kept_dices)
  end

  def roll_dices(roll= nil)
    roll = roll || Hazard.s2d10.rolls
    if @advantage
      @kept_dices = keep_dices_in_advantage_case(roll)
    else
      @kept_dices = roll
    end
  end

  def keep_dices_in_advantage_case(roll)
    kept_rolls = { roll_keeping_score: -1 }
    roll.combination(2).each do |comb|
      r = compute_results(comb)
      if r[:roll_keeping_score] > kept_rolls[:roll_keeping_score]
        kept_rolls = r
      end
    end
    kept_rolls[:dices]
  end

  def compute_results(dices)
    _, success, critic = check_results(dices)

    roll_keeping_score = 0

    roll_keeping_score = 2 if !success
    roll_keeping_score = 1 if !success && critic

    roll_keeping_score = 3 if success
    roll_keeping_score = 4 if success && critic

    { dices: dices, roll_keeping_score: roll_keeping_score }
  end

  def check_results(dices)
    score = dices.reduce(:+)
    target = 10+@bonus
    success = (score >= target)

    critic = dices[0] == dices[1]

    if dices[0] == dices[1] && dices[1] == 1
      success = false
      critic = true
    end

    if dices[0] == dices[1] && dices[1] == 10
      success = true
      critic = true
    end

    [ score, success, critic ]
  end
end