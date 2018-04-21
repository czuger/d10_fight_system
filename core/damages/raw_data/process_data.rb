require 'pp'
require 'yaml'

damages = {}
rolls = {}

File.open('damages_table.txt','r') do |file|
  file.readlines.each_with_index do |line, index|
    line = line.chomp.split( "\t" )
    if index == 0
      line.shift
      line.each_with_index do |roll, index|
        rolls[index] = roll.to_i
      end
    else
      strength = line.shift.to_i
      damages[strength] = {}
      line.each_with_index do |wound, index|
        damages[strength][rolls[index]] = wound == '-' ? nil : wound
      end
    end
  end
end

File.open('../damages_table.yaml','w') do |f|
  f.write(damages.to_yaml)
end