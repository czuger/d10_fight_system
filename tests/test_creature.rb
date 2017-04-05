require 'minitest/autorun'
require_relative '../creatures/creature'

class MovingCreature < Creature

  def initialize( position )
    @current_position = position
  end

end

class TestCreature < Minitest::Test

  def test_distance
    assert_equal( 3, MovingCreature.new( 3 ).distance( MovingCreature.new( 0 ) ) )

    assert_equal( 1, MovingCreature.new( 3 ).distance( MovingCreature.new( 2 ) ) )
    assert_equal( 1, MovingCreature.new( -3 ).distance( MovingCreature.new( -2 ) ) )

    assert_equal( 6, MovingCreature.new( 3 ).distance( MovingCreature.new( -3 ) ) )
    assert_equal( 6, MovingCreature.new( -3 ).distance( MovingCreature.new( 3 ) ) )

    assert_equal( 0, MovingCreature.new( 0 ).distance( MovingCreature.new( 0 ) ) )
    assert_equal( 0, MovingCreature.new( 4 ).distance( MovingCreature.new( 4 ) ) )
    assert_equal( 0, MovingCreature.new( -4 ).distance( MovingCreature.new( -4 ) ) )
  end

end