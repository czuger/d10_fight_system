require_relative 'monster'
require_relative '../../skills/magic'
require_relative '../../skills/creature_skill'

class Imp < Monster

  def self.generate( battleground, i )



    c = Imp.create!(
         name: "bg_#{battleground.object_id}_imp_#{i}",
         str: 2, coo: 8, wil: 6, mem: 6, current_hp: 2, max_hp: 2, def_mode: Skill.find_by( name: :dodge ),
         current_weapon: Skill.find_by( name: :imp_blast) , default_position: -3, current_position: -3
    )

    def_skill = Skill.find_by( name: :dodge )
    def_mode = CreatureSkill.create!( creature: c, skill: def_skill )

    c.def_mode = def_mode

    att_skill = Skill.find_by( name: :imp_blast )
    att_mode = CreatureSkill.create!( creature: c, skill: att_skill )

    c.current_weapon = att_mode

    c.save!

    c
  end

end