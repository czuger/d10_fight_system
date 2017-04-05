require_relative '../creatures/character'
require_relative '../creatures/monsters/imp'

class Battleground

  def initialize
    @creatures = [ Character.new( :magic ), Character.new( :bowman ), Character.new( :fighter ) ]

    @creatures += rand( 2 .. 4 ).times.map{ |_| Imp.new }

    p @creatures.map{ |c| c.name }
  end

  def fight_to_death
    round_count = 0
    while !battle_finished?
      round
      round_count += 1
      # exit if round_count > 5
    end
  end

  def round
    puts
    puts '*** New round ***'
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
      re << creature if attacker.enemies?( creature ) && creature.alive? && attacker.distance( creature ) <= attacker.current_weapon.reach
    end
    re
  end

  private

  def battle_finished?
    bf = false

    puts "Ennemies count = #{enemies_count}"

    if heroes_count == 0
      puts 'Heroes are all dead'
      bf = true
    end

    if enemies_count == 0
      puts 'Heroes defeated all monsters'
      bf = true
    end

    bf
  end

  def heroes_count
    @creatures.select{ |e| e.alive? && e.heroes? }.count
  end

  def enemies_count
    @creatures.select{ |e| e.alive? && !e.heroes? }.count
  end

  def order_by_initiative
    @creatures.select{ |c| c.alive? }.map{ |c| [ c.initiative, c ] }.sort_by{ |e| e.first }.map{ |c| c.last }
  end

end