require 'yaml'
require 'active_record'
require_relative '../interface/characters/set_data'

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

character_hash = {}
Character.all.each_with_index do |c, i|
  character_hash[ i ] = c
  puts "#{i} -> #{c.name}"
end

input = gets.to_i
if character_hash.has_key?( input )

  c = character_hash[ input ]
  c.print
  set_data( c )

else
  puts 'Bad input !!!'.red
end