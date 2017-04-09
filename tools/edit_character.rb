require_relative '../interface/characters/set_data'

character_hash = {}
Dir.glob( '../data/characters/*.cha' ).each_with_index do |f, i|
  character_hash[ i ] = f
  puts "#{i} -> #{File.basename( f, '.cha' ) }"
end

input = gets.to_i
if character_hash.has_key?( input )
  c = Marshal.load( File.open( character_hash[ input ] ).read )
  c.print
  set_data( c )
else
  puts 'Bad input !!!'.red
end
c

if c
  File.open( "../data/characters/#{c.name}.cha", 'w' ) do |f|
    f.puts( Marshal.dump( c ) )
  end
end
