require_relative 'test_helper'

class TestDamages < Minitest::Test

  def test_failures
    Kernel.stubs( :rand ).returns( 1 )
    dh = DamagesHandler.new

    assert_equal 'L', dh.wound( 6, '1d6', 0 )

  end

end