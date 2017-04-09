class Team

  def initialize( name )
    @name = name
    @characters_names = []
  end

  def add( character_name )
    @characters_names << character_name
  end

end