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

  def set_fighting_spec( def_mode, current_weapon, current_position )
    @def_mode = def_mode
    @current_weapon = current_weapon
    @current_position = current_position
  end

  # Define the way the creature will fight
  def set_class( _class )

    @class_name = _class

    if _class == :magic

      @str = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @coo = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = 15

      # Magic
      @def_mode = PopulateSkills.get(:dodge )
      @current_weapon = PopulateSkills.get(:magic_missile )
      @current_position = 5

    elsif _class == :bowman

      @str = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @coo = 5
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3

      # Bowman
      @def_mode = PopulateSkills.get(:dodge )
      @current_weapon = Items.get( :bow )
      @current_position = 5

    else _class == :fighter

      @str = 15
      @coo = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3

      # Fighter
      @def_mode = Items.get( :shield )
      @current_weapon = Items.get( :sword )
      @current_position = 1

    end

  end

end