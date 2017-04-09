class Item

  def initialize( name, hp )
    @name = name
    @hp = hp
  end

  def print
    "#{@name} : ( hp:#{@hp} ) "
  end

end