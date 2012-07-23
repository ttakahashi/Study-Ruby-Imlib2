require 'pic_zoomer.rb'
CANVAS_WIDTH = 480
CANVAS_HEIGHT = 360

@obj = Transform.new

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_SHORT, Transform::MID_W, Transform::MID_H)

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_LONG, Transform::LEFT, Transform::UP)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_long.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_LONG, Transform::MID_W, Transform::MID_H)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_long_pos_middle.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_LONG, Transform::RIGHT, Transform::LOW)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_long_pos_rightdown.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::WITHOUT_DEFORM, Transform::MID_W, Transform::MID_H)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/without_deform.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_SHORT, Transform::LEFT, Transform::UP)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_short_pos_leftup.png")

canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT )
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_short.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::PRIORITY_SHORT, Transform::RIGHT, Transform::LOW)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/priority_short_pos_rightdown.png")

ret = @obj.calcsize(1045, 387, CANVAS_WIDTH, CANVAS_HEIGHT, Transform::FILL, Transform::NONE, Transform::NONE)
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, ret["inx"], ret["iny"], ret["inw"], ret["inh"], ret["outx"], ret["outy"], ret["outw"], ret["outh"])
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/fill.png")