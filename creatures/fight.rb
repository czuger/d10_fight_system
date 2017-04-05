require_relative '../core/roll'

module Fight

  def fight( bg )

    re = bg.reachable_enemies( self )

    if re.empty?
      bg.advance_one_step
    else
      enemy = re.sample
      difficulty = @current_weapon.difficulty
      difficulty -= @current_weapon.skill.bonus( self ) # level + trait value

      if @current_weapon.distance
        d = distance( enemy )
        difficulty += d
      end

      difficulty += enemy.def_mode.def_module_difficulty

      result = Roll.new( difficulty )

      if result.success

        enemy.wound( result )
        enemy.def_mode.increase_skill

        if result.critic
          enemy.def_mode.damage_item
        end
      else
        @current_weapon.increase_skill

        if result.critic
          @current_weapon.damage_item
        end
      end
    end
  end

end