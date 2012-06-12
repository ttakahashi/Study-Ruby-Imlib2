require 'test/unit'
require 'pic_zoomer'

class TC_Imlib2_test < Test::Unit::TestCase
  def setup
    @obj = Transform.new
    #@obj.calcsize(1045, 387, 480, 360, 6, 10, 13)
  end
  
  def teardown
  end
  #assert_equal(srcx, srcy, srcw, srch, dstx, dsty, dstw, dsth, ret)
  def test_priority_short#
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_SHORT, Transform::MID_W, Transform::MID_H)
    #assert_equal([282, 0, 480, 387, 0, 0, 480, 360], ret)
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360, "edge" => 20}, ret)
  end
  
  def test_priority_long
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_LONG, Transform::LEFT, Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" =>0, "outw" => 480, "outh" => 177, "edge" => 20}, ret)
  end
  
  def test_fill
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::FILL, Transform::NONE, Transform::NONE)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end
  
  def test_without_deform
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::WITHOUT_DEFORM, Transform::MID_W, Transform::MID_H)
    assert_equal({"inx" => 282, "iny" => 13, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end
  
  def test_priority_short_pos_leftup
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_SHORT, Transform::LEFT, Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360, "edge" => 20}, ret)
  end
  
  def test_priority_short_pos_middle
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_SHORT, Transform::MID_W, Transform::MID_H)
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360, "edge" => 20}, ret)
  end
  
  def test_priority_short_pos_rightdown
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_SHORT, Transform::RIGHT, Transform::LOW)
    assert_equal({"inx" => 565, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360, "edge" => 20}, ret)
  end
  
  def test_priority_long_pos_leftup
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_LONG, Transform::LEFT, Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 177, "edge" => 20}, ret)
  end
  
  def test_priority_long_pos_middle
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_LONG, Transform::MID_W, Transform::MID_H)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 104, "outw" => 480, "outh" => 177, "edge" => 20}, ret)
  end
  
  def test_priority_long_pos_rightdown
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::PRIORITY_LONG, Transform::RIGHT, Transform::LOW)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 209, "outw" => 480, "outh" => 177, "edge" => 20}, ret)
  end
=begin  
  def test_height_full
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::HEIGHT_FULL, Transform::MID_W, Transform::MID_H)
    assert_equal([], ret)
  end
  
  def test_width_full
    ret = @obj.calcsize(1045, 387, 480, 360, Transform::WIDTH_FULL, Transform::MID_W, Transform::MID_H)
    assert_equal([], ret)
  end
=end
end


=begin
class TC_k6_is_nil < Test::Unit::TestCase
  def setup
    @obj = Transform.new
    @obj.init(480, 360)
  end
  
  def teardown
  end
  
  def test_init
    assert_not_nil(:canvas)
    assert_not_nil(:image)
    assert_not_nil(:dst)
    assert_not_nil(:src)
  end
  
  def test_calcsize
    assert_not_nil(:inimagew)
    assert_not_nil(:inimageh)
    assert_not_nil(:outimagew)
    assert_not_nil(:outimageh)
  end
end
=end
