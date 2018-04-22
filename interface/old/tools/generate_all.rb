require_relative '../skills/populate_skills'
require_relative '../items/populate_items'
require_relative '../creatures/character'
require_relative '../creatures/team'

Character.generate
Character.generate
Character.generate

team = Team.create!( name: 'The best' )

Character.all.each do |c|
  team.characters << c
end