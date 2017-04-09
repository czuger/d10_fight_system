require_relative '../creatures/team'

FileUtils.mkpath( '../data/teams' )

puts 'Enter team name'
team_name = gets.chomp

team = Team.new( team_name )

character_hash = {}

Dir.glob( '../data/characters/*.cha' ).each_with_index do |f, i|
  character_hash[ i ] = f
  puts "#{i} -> #{File.basename( f, '.cha' ) }"
end

begin

  input = gets.to_i

  if character_hash.has_key?( input )
    puts "Adding #{character_hash[ input ]}"
    team.add( character_hash[ input ] )
  end

end while character_hash.has_key?( input )

File.open( "../data/teams/#{team_name}.team", 'w' ) do |f|
  f.write( Marshal.dump( team ) )
end