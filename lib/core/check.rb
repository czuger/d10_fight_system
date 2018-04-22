require 'hazard'

class Check

  attr_reader :success, :critic, :score, :roll, :status

  def initialize( attribute, skill=0 )
    @attribute = attribute
    @skill = skill
  end

  def roll( difficulty=10, bonus=0 )
    @roll = Hazard.s2d10

    @misc_bonus = bonus
    @bonus = @attribute-10 + @skill + @misc_bonus
    @malus = difficulty

    @score = @roll.result + @bonus
    @success = @score - @malus >= 10
    @critic = @roll.rolls[0] == @roll.rolls[1]

    @status = @success ? 'success' : 'failure'
    @status = ( @critic ? 'critical_' : '' ) + @status
    @status = @status.to_sym
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

  def to_s
    final_string = "roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, roll bonus: #{@attribute-10}+#{@skill}+#{@misc_bonus}=#{@bonus}, "
    final_string += "roll malus = #{@malus}, #{@roll.result}+#{@bonus}-> >= 10+#{@malus} : "
    final_string += [ ('critical' if @critic), @success ? 'success' : 'failure' ].compact.join( ' ' )
  end

  def print_roll_detail
    puts "roll: #{@roll.rolls[0]}+#{@roll.rolls[1]}=#{@roll.result}, roll bonus: #{@attribute-10}+#{@skill}+#{@misc_bonus}=#{@bonus}, roll malus: #{@malus},"
    puts "#{@roll.result}+#{@bonus}-#{@malus}=#{@roll.result+@bonus-@malus} -> " + [ ('critical' if @critic), @success ? 'success' : 'failure' ].compact.join( ' ' )
    puts
  end

end