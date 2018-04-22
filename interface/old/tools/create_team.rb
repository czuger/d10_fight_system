require 'yaml'
require 'active_record'
require_relative '../creatures/team'
require_relative '../creatures/character'

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

puts 'Enter team name'
team_name = gets.chomp

team = Team.create!( name: team_name )

character_hash = {}
Character.all.each_with_index do |c, i|
  character_hash[ i ] = c
  puts "#{i} -> #{c.name}"
end

begin

  input = gets.to_i

  if character_hash.has_key?( input )
    puts "Adding #{character_hash[ input ].name}"
    team.characters << character_hash[ input ]
  end

end while character_hash.has_key?( input )