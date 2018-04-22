require_relative 'tool'

class Weapon < Tool

  belongs_to :damage

  def distance
    reach > 1
  end

end