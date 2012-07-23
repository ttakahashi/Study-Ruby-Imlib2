require 'test/unit'
require 'pic_zoomer'

class TC_Imlib2_test < Test::Unit::TestCase
  def setup
    @obj = Transform.new
    #@obj.calcsize(1045, 387, 480, 360, 6, 10, 13 )
  end
  
  def teardown
  end

  def test_priority_short_pos_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::LEFT, "posh" => Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_priority_short_pos_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_priority_short_pos_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
    assert_equal({"inx" => 565, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
 
  def test_priority_long_pos_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::LEFT, "posh" => Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_priority_long_pos_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 104, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_priority_long_pos_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 209, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_fill
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::FILL, "posw" => Transform::NONE, "posh" => Transform::NONE)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end

  def test_without_deform_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::LEFT, "posh" => Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end
 
  def test_without_deform_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
    assert_equal({"inx" => 282, "iny" => 13, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end
  
  def test_without_deform_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::RIGHT, "posh" => Transform::LOW)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/test_without_deform_rightdown.png")
  
    assert_equal({"inx" => 565, "iny" => 27, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  
  
  
  end

  def test_height_full_left
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::LEFT, "posh" => Transform::NONE)
    assert_equal({"inx" => 0, "iny" => 0, "inw" =>1045 , "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_height_full_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::MID_W, "posh" => Transform::NONE)
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_height_full_right
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::RIGHT, "posh" => Transform::NONE)
    assert_equal({"inx" => 565, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end

  def test_width_full_up
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::UP)
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_width_full_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::MID_H)
    assert_equal({"inx" => 0, "iny" => 13, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_width_full_low
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::LOW)
    assert_equal({"inx" => 0, "iny" => 27, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
end
