require_relative '../creatures/character'
require_relative '../creatures/monsters/kobold'

class Battleground

  def initialize
    @creatures = [ Character.new( :magic ), Character.new( :bowman ), Character.new( :fighter ), Kobold.new, Kobold.new ]
  end

  def round
    isc = order_by_initiative

    isc.each do |creature|
      creature.fight( bg )
    end
  end

  private

  def reachable_enemies( attacker )
    re = []
    isc.each do |creature|
      next if creature == attacker
      re << attacker if attacker.side != creature.side && attacker.distance( creature ) <= attacker.current_weapon.reach
    end
  end

  def order_by_initiative
    @creatures.map{ |c| [ c.initiative, c ] }.sort.map{ |c| c }
  end

end