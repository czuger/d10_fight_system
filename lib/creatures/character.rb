require 'colorize'

require_relative 'creature'
require_relative '../items/tool'
require_relative '../items/weapon'
require_relative 'name_generator'

class Character < Creature

  def self.generate
    str = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
    coo = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
    wil = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
    mem = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3

    hp = 8 + str - 10

    name = NameGenerator.generate

    Character.create!( str: str, coo: coo, wil: wil, mem: mem, hp: hp, name: name )
  end

  def print
    puts "Name : #{name}".yellow
    puts "STR : #{str}, COO : #{coo}, WILL : #{wil}, MEM : #{mem}".yellow
    puts "HP : #{hp}".yellow
    puts "Def mode -> #{@def_mode.print}".yellow if @def_mode
    puts "Current weapon -> #{@current_weapon.print}".yellow if @current_weapon
    puts "Current position -> #{@current_position}".yellow if @current_position
  end

  def heroes?
    true
  end

end