require_relative '../creatures/character'
require_relative '../creatures/monsters/imp'
require_relative '../items/old/creature_item'

class Battleground

  def initialize( team )

    @creatures = team.characters

    Imp.destroy_all

    @creatures += rand( 2 .. 3 ).times.map{ |i| Imp.generate( self, i ) }

    p @creatures.map{ |c| c.name }

    @creatures.each do |c|
      c.set_start_position
      c.reset_hp
    end

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
    puts '*** New round ***'.blue
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
      # p attacker
      # p creature
      # p attacker.current_weapon
      # p attacker.current_weapon.reach
      # p attacker.distance( creature )

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