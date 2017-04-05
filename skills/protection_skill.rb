require_relative 'skill'
require_relative '../core/def_module'

class ProtectionSkill < Skill

  include DefModule

  def initialize( name, trait )
    super( name, trait )
  end

end
