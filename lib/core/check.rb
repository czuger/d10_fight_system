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

  def roll(target: 0, roll_type: :regular, rolls: nil)
    @bonus = @attribute - 10 + @skill + target - 10
    @roll_type = roll_type

    roll_dices(rolls)

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


  # def to_s
  #   # final_string = "roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, roll target: #{@attribute-10}+#{@skill}+#{@misc_target}=#{@target}, "
  #   # final_string += "roll malus = #{@malus}, #{@roll.result}+#{@target}-> >= 10+#{@malus} : "
  #   result_string = [ (:critical if @critic), @success ? :success : :failure ].compact.join( ' ' )
  #
  #   final_string = result_string.colorize( color: RESULT_COLORS[result_string] ) + ': '
  #
  #   final_string += "#{@roll.result}+" + "#{@target}".colorize(:blue) + '-' + "#{@malus}".colorize(:red)
  #
  #   final_string += '=' + "#{@roll.result+@target-@malus}".colorize( color: RESULT_COLORS[result_string] )
  #
  #   final_string += " (roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, "
  #
  #   final_string += "target: #{@attribute-10}+#{@skill}+#{@misc_target}=#{@target}".colorize(:blue)
  #
  #   final_string += ', ' + "malus: #{@malus})".colorize(:red)
  #
  #   final_string
  # end

end