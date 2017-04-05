module DefModule

  def def_module_difficulty
    if self.class == ProtectionSkill
      return level
    elsif self.class = Tool
      return @skill.level
    else
      raise "def_module_difficulty can't be called from class #{self.class}"
    end
  end

end