require_relative 'test_helper'

class TestDamages < Minitest::Test

  def test_failures
    Kernel.stubs( :rand ).returns( 1 )
    dh = DamagesHandler.new

    assert_equal 'L', dh.wound( 6, '1d6', 0 )
    assert_equal 'L', dh.wound( 5, '1d6', 0 )
    assert_equal 'L', dh.wound( 5, '1d6', 1 )
    assert_equal 'L', dh.wound( 6, '1d6', 1 )
    refute dh.wound( 17, '1d6', 0 )

    Kernel.stubs( :rand ).returns( 12 )
    assert_equal 'C', dh.wound( 15, '1d12', 0 )
    assert_equal 'G', dh.wound( 16, '1d12', 0 )

    Kernel.stubs( :rand ).returns( 20 )
    assert_equal 'C', dh.wound( 15, '1d12', 0 )
    assert_equal 'G', dh.wound( 16, '1d12', 0 )
  end

end