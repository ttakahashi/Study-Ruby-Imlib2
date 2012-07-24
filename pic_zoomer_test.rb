require 'test/unit'
require 'pic_zoomer'

class TC_Imlib2_test < Test::Unit::TestCase
  def setup
    @obj = Transform.new
    #@obj.calcsize(1045, 387, 480, 360, 6, 10, 13 )
  end
  
  def teardown
  end

  def test_yoko_priority_short_pos_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::LEFT, "posh" => Transform::UP)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_short_pos_leftup.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_yoko_priority_short_pos_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_short_pos_middle.png")

    assert_equal({"inx" => 282, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_yoko_priority_short_pos_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_short_pos_rightdown.png")

    assert_equal({"inx" => 565, "iny" => 0, "inw" => 480, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
 
  def test_yoko_priority_long_pos_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::LEFT, "posh" => Transform::UP)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_long_pos_leftup.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_yoko_priority_long_pos_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_long_pos_middle.png")
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 91, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_yoko_priority_long_pos_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_priority_long_pos_rightdown.png")
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 183, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_yoko_fill
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::FILL, "posw" => Transform::NONE, "posh" => Transform::NONE)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_fill.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end

  def test_yoko_without_deform_leftup
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::LEFT, "posh" => Transform::UP)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_without_deform_pos_leftup.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end
 
  def test_yoko_without_deform_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::MID_W, "posh" => Transform::MID_H)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_without_deform_pos_middle.png")
    
    assert_equal({"inx" => 282, "iny" => 13, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end
  
  def test_yoko_without_deform_rightdown
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::RIGHT, "posh" => Transform::LOW)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_without_deform_pos_rightdown.png")
  
    assert_equal({"inx" => 565, "iny" => 27, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end

  def test_yoko_height_full_left
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::LEFT, "posh" => Transform::NONE)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_height_full_pos_left.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_yoko_height_full_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::MID_W, "posh" => Transform::NONE)
ret["inx"] = 282
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_height_full_pos_middle.png")
    
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_yoko_height_full_right
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::RIGHT, "posh" => Transform::NONE)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_height_full_pos_right.png")
    assert_equal({"inx" => 529, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end

  def test_yoko_width_full_up
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::UP)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_width_full_pos_up.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 183}, ret)
  end
  
  def test_yoko_width_full_middle
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::MID_H)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_width_full_pos_middle.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 88, "outw" => 480, "outh" => 183}, ret)
  end
  
  def test_yoko_width_full_low
    ret = @obj.calcsize("inw" => 1045, "inh" => 387, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::LOW)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_yoko_width_full_pos_low.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 177, "outw" => 480, "outh" => 183}, ret)
  end
  
  def test_tate_priority_short_pos_leftup
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::LEFT, "posh" => Transform::UP)
    ret["inx"] = ret["iny"] = 0
    ret["inw"] = 312
    ret["inh"] = 234#360*k¬”{—¦
    ret["outx"] = ret["outy"] = 0
    ret["outw"] = 480
    ret["outh"] = 360
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_short_pos_leftup.png")
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 312, "inh" => 234, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_tate_priority_short_pos_middle
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
    ret["iny"] = 258
    ret["inx"] = 0
    ret["inw"] = 312
    ret["inh"] = 234
    ret["outx"] = 0
    ret["outy"] = 0
    ret["outw"] = 480
    ret["outh"] = 360
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_short_pos_middle.png")

    assert_equal({"inx" => 0, "iny" => 258, "inw" => 312, "inh" => 234, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_tate_priority_short_pos_rightdown
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_SHORT, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
    ret["iny"] = 517
    ret["inx"] = 0
    ret["inw"] = 312
    ret["inh"] = 234
    ret["outx"] = ret["outy"] = 0
    ret["outw"] = 480
    ret["outh"] = 360
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_short_pos_rightdown.png")

    assert_equal({"inx" => 0, "iny" => 517, "inw" => 312, "inh" => 234, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
 
  def test_tate_priority_long_pos_leftup
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::LEFT, "posh" => Transform::UP)
    ret["inx"] = 0
    ret["iny"] = 0
    ret["inw"] = 312
    ret["inh"] =  751
    ret["outx"] = 0
    ret["outy"] = 0
    ret["outw"] = 149
    ret["outh"] = 360
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_long_pos_leftup.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_tate_priority_long_pos_middle
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::MID_W, "posh" => Transform::MID_H)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_long_pos_middle.png")
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 91, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_tate_priority_long_pos_rightdown
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::PRIORITY_LONG, "posw" => Transform::RIGHT, "posh" => Transform::LOW)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_priority_long_pos_rightdown.png")
    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 183, "outw" => 480, "outh" => 177}, ret)
  end
  
  def test_tate_fill
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::FILL, "posw" => Transform::NONE, "posh" => Transform::NONE)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_fill.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360} , ret)
  end

  def test_tate_without_deform_leftup
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::LEFT, "posh" => Transform::UP)
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_without_deform_pos_leftup.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end
 
  def test_tate_without_deform_middle
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::MID_W, "posh" => Transform::MID_H)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_without_deform_pos_middle.png")
    
    assert_equal({"inx" => 282, "iny" => 13, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end
  
  def test_tate_without_deform_rightdown
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WITHOUT_DEFORM, "posw" => Transform::RIGHT, "posh" => Transform::LOW)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_without_deform_pos_rightdown.png")
  
    assert_equal({"inx" => 565, "iny" => 27, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 1045, "outh" => 387} , ret)
  end

  def test_tate_height_full_left
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::LEFT, "posh" => Transform::NONE)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_height_full_pos_left.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_tate_height_full_middle
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::MID_W, "posh" => Transform::NONE)
ret["inx"] = 282
canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_height_full_pos_middle.png")
    
    assert_equal({"inx" => 282, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end
  
  def test_tate_height_full_right
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::HEIGHT_FULL, "posw" => Transform::RIGHT, "posh" => Transform::NONE)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_height_full_pos_right.png")
    assert_equal({"inx" => 529, "iny" => 0, "inw" => 516, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 360}, ret)
  end

  def test_tate_width_full_up
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::UP)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_width_full_pos_up.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 0, "outw" => 480, "outh" => 183}, ret)
  end
  
  def test_tate_width_full_middle
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::MID_H)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_width_full_pos_middle.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 88, "outw" => 480, "outh" => 183}, ret)
  end
  
  def test_tate_width_full_low
    ret = @obj.calcsize("inw" => 312, "inh" => 751, "outw" => 480, "outh" => 360, "deform" => Transform::WIDTH_FULL, "posw" => Transform::NONE, "posh" => Transform::LOW)

canvas = Imlib2::Image.new(480, 360)
canvas.fill_rect [0, 0, 480, 360]
image = Imlib2::Image.load('tatenaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/pic/test_tate_width_full_pos_low.png")

    assert_equal({"inx" => 0, "iny" => 0, "inw" => 1045, "inh" => 387, "outx" => 0, "outy" => 177, "outw" => 480, "outh" => 183}, ret)
  end
end
