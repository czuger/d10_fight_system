require 'yaml'
require 'active_record'
require_relative '../interface/characters/set_data'

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

c = Character.generate
p c

if File.exist?( "../data/characters/#{c.name}.cha" )
  puts 'Character already exist.'
  exit
end

c.print
c = set_data( c )

if c
  File.open( "../data/characters/#{c.name}.cha", 'w' ) do |f|
    f.puts( Marshal.dump( c ) )
  end
end
