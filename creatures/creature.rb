require 'active_record'

require_relative '../skills/protection_skill'
require_relative 'fight'

class Creature < ActiveRecord::Base

  include Fight

  belongs_to :def_mode, polymorphic: true
  belongs_to :current_weapon, polymorphic: true

  def enemies?( creature )
    ( heroes? && !creature.heroes? ) || ( !heroes? && creature.heroes? )
  end

  def alive?
    hp > 0
  end

  def initiative
    r = Roll.new
    coo + ( r.critic ? 20 : 0 ) + r.sum
  end

  def distance( creature )
    nbs = [ current_position, creature.current_position ].sort
    nbs[ 1 ] - nbs[ 0 ]
  end

  def advance_one_step
    if heroes?
      decrement!( :current_position ) if current_position > -5
    else
      increment!( :current_position ) if current_position < 5
    end
    puts "Current position = #{current_position}"
  end

  def wound( current_weapon, result )
    p current_weapon
    hit = current_weapon.damage.roll
    puts "Damage roll = #{hit}"

    if result.critic
      puts 'Critic !!! Damage roll doubled'
      hit *= 2
    end

    puts "#{name} loose #{hit} hp"
    decrement!( :hp, hit )
    puts "#{name} die" if hp < 0
  end

  def set_start_position
    update( current_position: default_position )
  end

end