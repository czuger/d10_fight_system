class Roll

  attr_reader :success, :critic, :sum

  def initialize( difficulty = 0 )
    r1 = rand( 1 .. 10 )
    r2 = rand( 1 .. 10 )

    @success = r1 + r2 >= 10 + difficulty
    @critic = r1 == r2
    @sum = r1 + r2
  end

end