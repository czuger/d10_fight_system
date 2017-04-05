require_relative 'skill'
require_relative 'magic'
require_relative 'protection_skill'

class Skills

  SKILLS = {
    melee: Skill.new( :melee, :str ),
    shoot: Skill.new( :shoot, :coo ),
    magic_missile: Magic.new( :magic_missile, :mem, 2, Damage.new( 4 ) ),
    dodge: ProtectionSkill.new( :dodge, :coo ),
    shield: ProtectionSkill.new( :shield, :str ),
    parry: ProtectionSkill.new( :dodge, :str )
  }

  def self.get( skill_name )
    raise "Skill #{skill_name} does not exist" unless SKILLS.has_key?( skill_name)
    SKILLS[ skill_name ].clone
  end

end