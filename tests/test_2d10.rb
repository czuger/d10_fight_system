require_relative 'test_helper'

class Test2d10 < Minitest::Test

  def setup
    @r = Check2d10.new
  end

  def test_rolls
    Kernel.stubs(:rand).returns(1)
    assert_equal :critical_failure, @r.roll.status

    Kernel.stubs(:rand).returns(5)
    assert_equal :critical_success,  @r.roll.status
  end

  def test_advantage
    Kernel.stubs(:rand).returns(10)

    assert_equal [10, 10], @r.roll.kept_dices
  end

end