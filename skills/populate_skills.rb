require_relative 'skill'
require_relative 'magic'
require_relative 'protection_skill'

db_info = YAML.load( File.open( 'db/config.yml' ).read )
ActiveRecord::Base.establish_connection( db_info[ 'development' ] )

Skill.find_or_create_by!( name: :melee, trait: :str, difficulty: 2 )
Skill.find_or_create_by!( name: :shoot, trait: :coo, difficulty: 2 )

_1d4 = Damage.find_or_create_by!( dices_side: 4, nb_dices: 1, bonus: 0 )
m = Magic.find_or_create_by!( name: :magic_missile, trait: :mem, difficulty: 2, damage_id: _1d4.id, reach: 5 )

_1d2 = Damage.find_or_create_by!( dices_side: 4, nb_dices: 1, bonus: 0 )
m = Magic.find_or_create_by!( name: :imp_blast, trait: :mem, difficulty: 2, damage_id: _1d2.id, reach: 5 )

ProtectionSkill.find_or_create_by!( name: :dodge, trait: :coo, difficulty: 0 )
ProtectionSkill.find_or_create_by!( name: :shield, trait: :str, difficulty: 2 )
ProtectionSkill.find_or_create_by!( name: :parry, trait: :str, difficulty: 2 )

