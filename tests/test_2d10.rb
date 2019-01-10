require_relative 'test_helper'

class Test2d10 < Minitest::Test

  def setup
    @r = Check2d10.new
  end

  def test_regular_rolls
    assert_equal :success, @r.roll( target: 15, rolls: [ 10, 5 ] ).status
    assert_equal :failure, @r.roll( target: 15, rolls: [ 9, 5 ] ).status

    assert_equal :critical_success, @r.roll( target: 15, rolls: [ 10, 10 ] ).status
    assert_equal :critical_failure, @r.roll( target: 15, rolls: [ 5, 5 ] ).status
  end

  def test_advantaged_rolls
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 10, 5, 1 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 5, 10, 1 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 5, 1, 10 ] ).status

    assert_equal :failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 9, 5, 1 ] ).status

    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 10, 10, 2 ] ).status
    assert_equal :critical_failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 5, 5, 5 ] ).status
    assert_equal :failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 5, 5, 1 ] ).status

    assert_equal :critical_failure, @r.roll( roll_type: :advantage, target: 1, rolls: [ 1, 1, 1 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 1, rolls: [ 1, 1, 2 ] ).status

    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 20, rolls: [ 10, 10, 10 ] ).status
    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 20, rolls: [ 9, 10, 10 ] ).status
    assert_equal :failure, @r.roll( roll_type: :advantage, target: 20, rolls: [ 9, 9, 10 ] ).status
  end

end