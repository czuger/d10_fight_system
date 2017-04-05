require_relative 'skill'
require_relative 'magic'
require_relative 'protection_skill'

class Skills

  SKILLS = {
    melee: Skill.new( :melee, :str, 2 ),
    shoot: Skill.new( :shoot, :coo, 4 ),
    magic_missile: Magic.new( :magic_missile, :mem, 2, Damage.new( 4 ) ),
    imp_blast: Magic.new( :imp_blast, :mem, 2, Damage.new( 2 ) ),
    dodge: ProtectionSkill.new( :dodge, :coo, 0 ),
    shield: ProtectionSkill.new( :shield, :str, 2 ),
    parry: ProtectionSkill.new( :dodge, :str, 2 )
  }

  def self.get( skill_name )
    raise "Skill #{skill_name} does not exist" unless SKILLS.has_key?( skill_name)
    SKILLS[ skill_name ].clone
  end

end