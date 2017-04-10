require 'yaml'
require 'active_record'
require_relative '../interface/characters/set_data'

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

c = Character.generate

# p c
#
c.print
# c = set_data( c )