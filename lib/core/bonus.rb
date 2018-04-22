module Bonus

  def bonus( creature )
    s = get_skill_link
    trait_name = s.trait

    raise "#{creature.inspect} does not have #{trait_name.inspect}" unless creature.respond_to?( trait_name )

    trait = creature.send( trait_name ) - 10
    [ - s.level - trait, [ [ :level, - s.level ], [ "trait : (#{trait_name}:#{trait+10})", -trait ] ] ]
  end

end