require_relative '../core/database'
require_relative '../creatures/team'
require_relative '../core/battleground'

bg = Battleground.new( Team.first )

bg.fight_to_death