require 'hazard'

class Check

  attr_reader :success, :critic, :score, :roll, :status, :kept_dices

  RESULT_COLORS = { success: :blue, critical_success: :green,
                    critical_failure: :red, failure: :yellow }.freeze

  def initialize(attribute = 10, skill = 0)
    @attribute = attribute
    @skill = skill
    @success = @critic = nil
  end

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

  def success?
    @success
  end

  def failure?
    !@success
  end

  def critical_success?
    @success && @critic
  end

  def critical_failure?
    !@success && @critic
  end

  def set_status
    @status = @success ? 'success' : 'failure'
    @status = (@critic ? 'critical_' : '') + @status
    @status = @status.to_sym
  end


  def to_s
    # final_string = "roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, roll bonus: #{@attribute-10}+#{@skill}+#{@misc_bonus}=#{@bonus}, "
    # final_string += "roll malus = #{@malus}, #{@roll.result}+#{@bonus}-> >= 10+#{@malus} : "
    result_string = [ (:critical if @critic), @success ? :success : :failure ].compact.join( ' ' )

    final_string = result_string.colorize( color: RESULT_COLORS[result_string] ) + ': '

    final_string += "#{@roll.result}+" + "#{@bonus}".colorize(:blue) + '-' + "#{@malus}".colorize(:red)

    final_string += '=' + "#{@roll.result+@bonus-@malus}".colorize( color: RESULT_COLORS[result_string] )

    final_string += " (roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, "

    final_string += "bonus: #{@attribute-10}+#{@skill}+#{@misc_bonus}=#{@bonus}".colorize(:blue)

    final_string += ', ' + "malus: #{@malus})".colorize(:red)

    final_string
  end

end