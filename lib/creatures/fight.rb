require_relative '../core/check'

module Fight

  def attack( opponent )

    # Need to replace with : esquive value, shield block, or mage armor
    defence_value = 6

    # Need to replace with attack attribute (strength, coord, etc ...)
    attack_attribute = 12

    # Need to replace with : weapon skill
    attack_skill = 4

    # Need to replace with : weapon difficulty
    weapon_difficulty = 2

    # Need to replace with : weapon damage
    weapon_damage = '1d6'

    weapon_attack_check( attack_attribute,  attack_skill, weapon_difficulty, defence_value )
  end

  def weapon_attack_check( attack_attribute, attack_skill, weapon_difficulty, defence_value )
    difficulty = weapon_difficulty + defence_value
    result = Check.new( attack_attribute, attack_skill ).roll( difficulty )
    result.print_roll_detail
  end

  # def fight( bg )
  #
  #   re = bg.reachable_enemies( self )
  #
  #   # p re.map{ |e| e.name }
  #   puts
  #   puts '*** New fight ***'
  #
  #   if re.empty?
  #     puts "#{name} find no reachable enemy. Step ahead"
  #     advance_one_step
  #   else
  #     enemy = re.sample
  #
  #     puts "#{name} about to attack #{enemy.name}"
  #
  #     detail = []
  #
  #     difficulty = current_weapon.difficulty
  #     detail << [ current_weapon.name, difficulty ]
  #
  #     bonus = current_weapon.bonus( self )# level + trait value
  #     difficulty += bonus.first # Already minus
  #     detail += bonus.second
  #     # p current_weapon
  #
  #     if current_weapon.distance
  #       d = distance( enemy )
  #       detail << [ :distance, d ]
  #       difficulty += d
  #     end
  #
  #     difficulty += enemy.def_mode.difficulty
  #     detail << [ :enemy_def_mode, enemy.def_mode.difficulty ]
  #
  #     result = Roll.new( difficulty )
  #
  #     p detail
  #     detail_string = detail.map{ |e| e.join( ' : ' ) }.join( ', ' )
  #     puts "Difficulty : #{difficulty}(#{difficulty+10}), roll : (#{result.to_s}), details : #{detail_string}".yellow
  #
  #     if result.success
  #
  #       enemy.wound( current_weapon, result, self )
  #       enemy.def_mode.gain_xp
  #
  #       if result.critic
  #         enemy.def_mode.damage_item
  #       end
  #     else
  #       puts "#{name} miss"
  #       current_weapon.gain_xp
  #
  #       if result.critic
  #         current_weapon.damage_item
  #       end
  #     end
  #   end
  # end

end