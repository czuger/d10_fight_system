require 'hazard'
require 'pp'

require_relative 'lib/core/check2d10'
require_relative 'lib/core/check_d20'

$results = {}

runs = 50000
$advantage = true

def increase_hashes_value(difficulty, dice, result)
  label = 'Difficulty %2d, dice %2d' % [ difficulty, dice ]
  $results[label] ||= {}
  $results[label][result.status] ||= 0
  $results[label][result.status] += 1
end

def check_2d10(difficulty, dice)
    result = Check2d10.new.roll( difficulty: difficulty, advantage: $advantage )
    increase_hashes_value difficulty, dice, result
end

def check_d20(difficulty, dice)
  result = CheckD20.new.roll( difficulty: difficulty, advantage: $advantage )
  increase_hashes_value difficulty, dice, result
end

1.upto( runs ).each do
  check_d20(9, 20)
  check_d20(10, 20)
  check_d20(11, 20)

  check_2d10(9, 10)
  check_2d10(10, 10)
  check_2d10(11, 10)
end

keys = $results.keys.sort

puts "\t" + keys.join( "\t" )

[:critical_failure, :failure, :success, :critical_success].each do |status|
  puts "#{status.capitalize.to_s.gsub( '_', ' ' )}\t" + keys.map{ |k| (($results[k][status].to_f)/runs).round(3).to_s.gsub( '.', ',' ) }.join( "\t" )
end