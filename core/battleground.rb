require_relative '../creatures/character'
require_relative '../creatures/monsters/kobold'

class Battleground

  def initialize
    @creatures = [ Character.new( :magic ), Character.new( :bowman ), Character.new( :fighter ), Kobold.new, Kobold.new ]

    p @creatures.map{ |c| c.name }
  end

  def round
    isc = order_by_initiative

    isc.each do |creature|
      # p creature
      creature.fight( self )
    end
  end

  def reachable_enemies( attacker )
    re = []
    @creatures.each do |creature|
      next if creature == attacker

      # p attacker.side
      # p creature.side
      re << creature if attacker.side != creature.side && creature.alive? && attacker.distance( creature ) <= attacker.current_weapon.reach
    end
    re
  end

  private

  def order_by_initiative
    @creatures.select{ |c| c.alive? }.map{ |c| [ c.initiative, c ] }.sort_by{ |e| e.first }.map{ |c| c.last }
  end

end