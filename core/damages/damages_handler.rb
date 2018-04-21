require 'yaml'

class DamagesHandler

  MAX_STRENGTH_VALUE = 26
  MIN_STRENGTH_VALUE = 6

  MAX_ROLL_VALUE = 12
  MIN_ROLL_VALUE = 1
  
  def initialize
    @damages_table = YAML.from_file('damages_table.yaml')
  end

  def wound( strength_value, weapon_dice, armor_protection )
    roll = frame_roll_value( Hazard.from_string( 'd' + weapon_dice ) - armor_protection )
    @damages_table[frame_strength_value(strength_value)][roll]
  end

  private

  def frame_strength_value( strength_value )
    strength_value = MAX_STRENGTH_VALUE if strength_value > MAX_STRENGTH_VALUE
    strength_value = MIN_STRENGTH_VALUE if strength_value < MIN_STRENGTH_VALUE
  end

  def frame_roll_value( roll_value )
    roll_value = MAX_ROLL_VALUE if roll_value > MAX_ROLL_VALUE
    roll_value = MIN_ROLL_VALUE if roll_value < MIN_ROLL_VALUE
  end
  
end