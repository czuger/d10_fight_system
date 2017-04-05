require_relative 'creature'
require_relative '../skills/skills'
require_relative '../items/tool'
require_relative '../items/weapon'

class Character < Creature

  def initialize( _class )

    set_class( _class )

    @hp = 8 + @str - 10

  end

  def side
    :heroes
  end

  private

  # Define the way the creature will fight
  def set_class( _class )

    if _class == :magic

      @str = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @coo = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = 15

      # Magic
      @def_mode = Skills.get( :dodge )
      @current_weapon = Skills.get( :magic_missile )
      @current_position = 5

    elsif _class == :bowman

      @str = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @coo = 5
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3

      # Bowman
      @def_mode = Skills.get( :dodge )
      @current_weapon = Items.get( :bow )
      @current_position = 5

    else _class == :fighter

      @str = 15
      @coo = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @will = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3
      @mem = rand( 1 .. 6 ) + rand( 1 .. 6 ) + 3

      # Fighter
      @def_mode = Item.get( :shield )
      @current_weapon = Items.get( :sword )
      @current_position = 1

    end

  end

end