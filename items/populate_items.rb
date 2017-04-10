require 'yaml'
require 'active_record'
require_relative 'weapon'
require_relative '../core/damage'
require_relative '../skills/skill'

# class PopulateItems
#
#   ITEMS = {
#     bow: Weapon.new( :bow, 2, :shoot, 2, Damage.new( 8 ), 10 ),
#     sword: Weapon.new( :sword, 6, :melee, 2, Damage.new( 6 ), 1 ),
#     shield: Tool.new( :shield, 4, :shield, 2 )
#   }
#
#   def self.get( item_name )
#     raise "Item #{item_name} does not exist" unless ITEMS.has_key?( item_name)
#     ITEMS[ item_name ].clone
#   end
#
# end

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

_1d8 = Damage.find_or_create_by!( dices_side: 8, nb_dices: 1, bonus: 0 )
shoot = Skill.find_by( name: :shoot )
Weapon.find_or_create_by!( name: :bow, difficulty: 2, hp: 2, skill_id: shoot.id, damage_id: _1d8.id, reach: 10 )

