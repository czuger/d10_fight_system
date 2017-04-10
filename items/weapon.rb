require_relative 'tool'

class Weapon < Tool

  def distance
    reach > 1
  end

end