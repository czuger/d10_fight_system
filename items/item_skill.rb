# TODO : should not be in item nor skill class

# module ItemSkill
#
#   attr_reader :difficulty_value, :trait
#
#   def difficulty
#     # p self.inspect
#     get_skill.difficulty_value
#   end
#
#   def bonus( creature )
#     s = get_skill
#     raise "#{creature.inspect} does not have #{s.trait.inspect}" unless creature.respond_to?( s.trait )
#     s.level + creature.send( s.trait ) - 10
#   end
#
#   def increase_skill
#     get_skill.xp += 1
#     puts "#{@name} increase : #{get_skill.xp}"
#   end
#
#   private
#
#   def get_skill
#     if self.kind_of?( Skill )
#       return self
#     elsif self.kind_of?( Tool )
#       return @skill
#     else
#       raise "get_skill can't be called from class #{self.class}"
#     end
#   end
#
# end