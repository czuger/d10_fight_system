require 'active_record'

require_relative '../skills/protection_skill'
require_relative 'fight'

class Creature < ActiveRecord::Base

  include Fight

  belongs_to :def_mode, polymorphic: true, dependent: :destroy
  belongs_to :current_weapon, polymorphic: true, dependent: :destroy

  def enemies?( creature )
    ( heroes? && !creature.heroes? ) || ( !heroes? && creature.heroes? )
  end

  def alive?
    current_hp > 0
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

  def wound( current_weapon, result, attacker )
    # p current_weapon
    hit = current_weapon.damage.roll
    puts "Damage roll = #{hit}"

    if result.critic
      puts 'Critic !!! Damage roll doubled'
      hit *= 2
    end

    hit += current_weapon.damage_bonus( attacker )

    puts "#{name} loose #{hit} hp"
    decrement!( :current_hp, hit )
    puts "#{name} die" if current_hp < 0
  end

  def set_start_position
    update( current_position: default_position )
  end

  def reset_hp
    update( current_hp: max_hp )
  end

end