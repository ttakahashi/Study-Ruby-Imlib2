require 'rubygems'
require 'imlib2'

CANVAS_WIDTH = 480
CANVAS_HEIGHT = 360
canvas = Imlib2::Image.new(CANVAS_WIDTH, CANVAS_HEIGHT)
canvas.fill_rect [0, 0, CANVAS_WIDTH, CANVAS_HEIGHT]
image = Imlib2::Image.load('yokonaga.png')
canvas.blend_image!(image, 0, 0, 250, 250, 100, 100, 20000, 10000)
canvas.save("/home/ttakahashi/Study-Ruby-Imlib2/blendtest.png")
