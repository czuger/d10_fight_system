require 'active_record'

require_relative '../skills/protection_skill'
require_relative 'fight'

class Creature < ActiveRecord::Base

  include Fight

  def enemies?( creature )
    ( heroes? && !creature.heroes? ) || ( !heroes? && creature.heroes? )
  end

  def alive?
    @hp > 0
  end

  def initiative
    r = Roll.new
    @coo + ( r.critic ? 20 : 0 ) + r.sum
  end

  def distance( creature )
    nbs = [ @current_position, creature.current_position ].sort
    nbs[ 1 ] - nbs[ 0 ]
  end

  def advance_one_step
    if heroes?
      @current_position -= 1
    else
      @current_position += 1
    end
    puts "Current position = #{@current_position}"
  end

  def wound( current_weapon, result )
    hit = current_weapon.damage.roll
    puts "Damage roll = #{hit}"

    if result.critic
      puts 'Critic !!! Damage roll doubled'
      hit *= 2
    end

    puts "#{name} loose #{hit} hp"
    @hp -= hit
    puts "#{name} die" if @hp < 0
  end

end