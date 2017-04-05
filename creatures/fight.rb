require_relative '../core/roll'

module Fight

  def fight( bg )

    re = bg.reachable_enemies( self )

    # p re.map{ |e| e.name }
    puts
    puts '*** New fight ***'

    if re.empty?
      puts "#{name} find no reachable enemy. Step ahead"
      # TODO : fix this
      # bg.advance_one_step
    else
      enemy = re.sample

      puts "#{name} about to attack #{enemy.name}"

      difficulty = @current_weapon.difficulty
      difficulty -= @current_weapon.bonus( self ) # level + trait value

      if @current_weapon.distance
        d = distance( enemy )
        difficulty += d
      end

      difficulty += enemy.def_mode.difficulty

      result = Roll.new( difficulty )

      if result.success

        enemy.wound( @current_weapon, result )
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