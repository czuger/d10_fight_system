require 'hazard'
require 'pp'

_2d10 = {}
_1d20 = {}

_2d10_crit = 0
_2d10_botch = 0

runs = 20000
crit_base = 10

1.upto( runs ).each do
  _1d20_result = [ Hazard.d20, Hazard.d20 ].max
  _1d20[_1d20_result] ||= 0
  _1d20[_1d20_result] += 1

  _2d10_result = [ Hazard.d10, Hazard.d10, Hazard.d10 ]

  1.upto(1).each do
    min = _2d10_result.min
    min_pos = _2d10_result.index( min )
    _2d10_result.delete_at( min_pos )
  end

  crit = true if _2d10_result.first == _2d10_result.last

  _2d10_result = _2d10_result.reduce(:+)

  _2d10_crit += 1 if crit && _2d10_result >= crit_base
  _2d10_botch += 1 if crit && _2d10_result < crit_base

  _2d10[_2d10_result] ||= 0
  _2d10[_2d10_result] += 1
end

_1d20.keys.sort.each do |k|
  puts "#{k} => #{ ( _1d20[k].to_f * 100 ) / runs }"
end

puts '*' * 20

_2d10.keys.sort.each do |k|
  puts "#{k} => #{ ( _2d10[k].to_f * 100 ) / runs }"
end

puts "crit = #{ ( _2d10_crit.to_f * 100 ) / runs }"
puts "botch = #{ ( _2d10_botch.to_f * 100 ) / runs }"