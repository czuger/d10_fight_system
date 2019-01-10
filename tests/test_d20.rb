require_relative 'test_helper'

class Testd20 < Minitest::Test

  def setup
    @r = CheckD20.new
  end

  def test_regular_rolls
    assert_equal :success, @r.roll( target: 15, rolls: [ 15 ] ).status
    assert_equal :failure, @r.roll( target: 15, rolls: [ 14 ] ).status

    assert_equal :critical_success, @r.roll( target: 15, rolls: [ 20 ] ).status
    assert_equal :critical_failure, @r.roll( target: 15, rolls: [ 1 ] ).status
  end

  def test_advantaged_rolls
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 15, 4 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 4, 15 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 17, 6 ] ).status

    assert_equal :failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 4, 7 ] ).status

    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 20, 5 ] ).status
    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 15, rolls: [ 20, 1 ] ).status

    assert_equal :failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 1, 5 ] ).status
    assert_equal :failure, @r.roll( roll_type: :advantage, target: 15, rolls: [ 7, 8 ] ).status

    assert_equal :critical_failure, @r.roll( roll_type: :advantage, target: 1, rolls: [ 1, 1 ] ).status
    assert_equal :success, @r.roll( roll_type: :advantage, target: 1, rolls: [ 1, 2 ] ).status

    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 20, rolls: [ 20, 5 ] ).status
    assert_equal :critical_success, @r.roll( roll_type: :advantage, target: 20, rolls: [ 5, 20 ] ).status
    assert_equal :failure, @r.roll( roll_type: :advantage, target: 20, rolls: [ 19, 19 ] ).status
  end

  def test_disadvantaged_rolls
    assert_equal :success, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 18, 17 ] ).status
    assert_equal :success, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 17, 18 ] ).status

    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 18, 4 ] ).status
    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 4, 18 ] ).status

    assert_equal :critical_failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 1, 19 ] ).status
    assert_equal :critical_failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 20, 1 ] ).status

    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 20, 5 ] ).status
    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 15, rolls: [ 7, 8 ] ).status

    assert_equal :critical_success, @r.roll( roll_type: :disadvantage, target: 1, rolls: [ 20, 20 ] ).status
    assert_equal :success, @r.roll( roll_type: :disadvantage, target: 1, rolls: [ 3, 20 ] ).status
    assert_equal :success, @r.roll( roll_type: :disadvantage, target: 1, rolls: [ 20, 3 ] ).status

    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 20, rolls: [ 20, 5 ] ).status
    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 20, rolls: [ 5, 20 ] ).status
    assert_equal :failure, @r.roll( roll_type: :disadvantage, target: 20, rolls: [ 19, 19 ] ).status
  end

end