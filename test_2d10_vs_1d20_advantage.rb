require 'hazard'
require 'pp'

require_relative 'lib/core/check2d10'
require_relative 'lib/core/check_d20'

$results = {}

def difficulty_key(difficulty, dice)
  '%2d%2d Bonus %2d, dice %2d' % [ difficulty, dice, difficulty-10, dice ]
end

def increase_hashes_value(difficulty, dice, result)
  label = difficulty_key(difficulty, dice)
  $results[label] ||= {}
  $results[label][result.status] ||= 0.0
  $results[label][result.status] += 1.0

  $results[label][:sum] ||= 0.0
  $results[label][:sum] += 1.0

end

def check_2d10(difficulty, dice, roll)
    result = Check2d10.new.roll( difficulty: difficulty, advantage: false, rolls: roll )
    increase_hashes_value difficulty, dice, result
end

def check_d20(difficulty, dice, roll)
  result = CheckD20.new.roll( difficulty: difficulty, advantage: false, rolls: roll )
  increase_hashes_value difficulty, dice, result
end

(-1..1).each do |difficulty|
  1.upto(20).to_a.repeated_permutation(1).each do |roll|
    check_d20(difficulty+10, 20, roll)
  end

  1.upto(10).to_a.repeated_permutation(2).each do |roll|
    check_2d10(difficulty+10, 10, roll)
  end
end

pp $results

keys = $results.keys.sort
puts "\t" + keys.map{ |k| k[4..-1] }.join( "\t" )

[:critical_failure, :failure, :success, :critical_success].each do |status|
  puts "#{status.capitalize.to_s.gsub( '_', ' ' )}\t" + keys.map{ |k| ($results[k][status]/$results[k][:sum]).round(2).to_s.gsub( '.', ',' ) }.join( "\t" )
end