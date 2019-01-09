require 'hazard'
require 'pp'

require_relative '../core/check2d10'
require_relative '../core/check_d20'

class ModelCompare
  
  def initialize( advantage= false )
    @results= {}    
    @advantage= advantage
  end


  def compute_results( steps_enumerator )
    steps_enumerator.each do |target|
      permutations_d20.each do |roll|
        check_d20(target, 20, roll)
      end

      permutations_d10.each do |roll|
        check_2d10(target, 10, roll)
      end
    end
  end

  def print_results
    keys = @results.keys.sort
    puts "\t" + keys.map{ |k| k[4..-1] }.join( "\t" )

    [:critical_failure, :failure, :success, :critical_success].each do |status|
      puts "#{status.capitalize.to_s.gsub( '_', ' ' )}\t" + keys.map{ |k| (@results[k][status]/@results[k][:sum]).round(3).to_s.gsub( '.', ',' ) }.join( "\t" )
    end
  end
  
  private

  def permutations_d20
    if @advantage
      1.upto(20).to_a.repeated_permutation(2)
    else
      1.upto(20).to_a.repeated_permutation(1)
    end
  end

  def permutations_d10
    if @advantage
      1.upto(10).to_a.repeated_permutation(3)
    else
      1.upto(10).to_a.repeated_permutation(2)
    end
  end

  def increase_hashes_value(target, dice, result)
    label = target_key(target, dice)
    @results[label] ||= {}
    @results[label][result.status] ||= 0.0
    @results[label][result.status] += 1.0

    @results[label][:sum] ||= 0.0
    @results[label][:sum] += 1.0

  end

  def check_2d10(target, dice, roll)
    result = Check2d10.new.roll( target: target, advantage: true, rolls: roll )
    increase_hashes_value target, dice, result
  end

  def check_d20(target, dice, roll)
    result = CheckD20.new.roll( target: target, advantage: true, rolls: roll )
    increase_hashes_value target, dice, result
  end
  
  def target_key(target, dice)
    dice_name = (dice==10) ? '2d10' : 'd20'
    '%2d%2d Target %2d, %s' % [ target, dice, target, dice_name ]
  end
  
end