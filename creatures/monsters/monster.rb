require_relative '../../creatures/creature'

class Monster < Creature

  @@monster_no = 1

  def initialize

  @monster_no = @@monster_no
  @@monster_no += 1

  end

  def name
    "#{self.class} #{@monster_no}"
  end

  def heroes?
    false
  end

end