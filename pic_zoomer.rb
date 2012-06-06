require 'rubygems'
require 'imlib2'
class Transform
  #---------------拡大処理と位置を示すクラス定数---------------
  PRIORITY_LONG = 	1
  PRIORITY_SHORT = 	2
  HEIGHT_FULL = 	3
  WIDTH_FULL = 		4
  WITHOUT_DEFORM =	5
  FILL =			6
  
  UP = 				10
  MID_W= 			11
  LOW = 			12
  LEFT = 			13
  RIGHT =			14
  MID_H = 			15
  NONE =			16
  
  YOKO = 			20
  TATE = 			21
  SQUARE =			22
  def calcsize (inw, inh, outw, outh, deform, posw, posh)
    #---------------横長ならYOKO縦長ならTATE正方形ならSQUARE---------------
    inx = iny = outx = outy = nil
    if inh < inw then
      edge = YOKO
    elsif inh > inw then
      edge = TATE
    else
      edge = SQUARE
    end
    #---------------拡大処理---------------
    case deform
      #----------長い方優先（余白を作る）----------
      when PRIORITY_LONG then
        #-----位置の前処理と拡大処理-----
        if edge == YOKO then
          posw = NONE
          outh = outw.to_f / inw.to_f * inh.to_f
        else
          posh = NONE
          outw = outh.to_f / inh.to_f * inw.to_f
        end
        inx = iny = outx = outy = 0
      #----------短い方優先（余白を切る）----------
      when PRIORITY_SHORT then
        #-----位置の前処理-----
        if edge == YOKO then
          posh = NONE
          posw = NONE if posw == MID_W
        else
          posw = NONE
          posh = NONE if posh == MID_H
        end
        #-----拡大処理-----
        if edge ==YOKO then
          inx = (outw.to_f - inw.to_f) / 2.0
          inw_tmp = inw if posw == RIGHT
          inw = outw
          iny = 0
        elsif edge == TATE then
          inx = 0
          iny = (inh.to_f - outh.to_f) / 2.0
          inh = outh
        else
          inx = 0
          inw = outw
          iny = (inh.to_f - outh.to_f) / 2.0
          inh = outh
        end
        outx = outy = 0
      #----------縦を100%使う（横が長ければ切り、短ければ余らせる）----------
      when HEIGHT_FULL then
        posh = NONE if edge == YOKO
      #----------横を100%使う（縦が長ければ切り、短ければ余らせる）----------
      when WIDTH_FULL then
        posw = NONE if edge == YOKO
      #----------拡大も縮小もしない----------
      when WITHOUT_DEFORM then
        if inw > outw then
          inx = (inw - outw) / 2.0
        else
          outx = (outw - inw) / 2.0
        end
        if inh > outh then
          iny = (inh - outh) / 2.0
        else
          outy = (outh - inh ) / 2.0
        end
        outw = inw
        outh = inh
        inx = 0 if inx == nil
        iny = 0 if iny == nil
        outx = 0 if outx == nil
        outy = 0 if outy == nil
      #----------縦も横も合わせる----------
      when FILL then
        posh = posw = NONE
        inx = iny = outx = outy = 0
      end
      
      
      #----------横位置の処理----------
      case posw
        when LEFT then
          inx = 0
        when MID_W then
        when RIGHT then
          inx = inw_tmp.abs - outw 
        when NONE then
      end

      #----------縦位置の処理----------
      case posh
      when UP then
        iny = 0
      when MID_H then
        outy = (outh.to_f - inh.to_f ) / 2.0
      when LOW then
        outy = inh - outh
      when NONE then
      end
      
     #---------絶対値＆整数に変換----------
     inx = inx.abs
     iny = iny.abs
     inw = inw.abs
     inh = inh.abs
     outx = outx.abs
     outy = outy.abs
     outw = outw.abs
     outh = outh.abs
     
     inx = inx.truncate
     iny = iny.truncate
     inw = inw.truncate
     inh = inh.truncate
     outx = outx.truncate
     outy = outy.truncate
     outw = outw.truncate
     outh = outh.truncate
     
     
     ret_hash = Hash.new
     ret_hash.store("inx", inx)
ret_hash.store("iny", iny)
ret_hash.store("inw", inw)
ret_hash.store("inh", inh)
ret_hash.store("outx", outx)
ret_hash.store("outy", outy)
ret_hash.store("outw", outw)
ret_hash.store("outh", outh)
  return ret_hash
end
  
=begin
def init(canvas_width, canvas_height)
canvas = Imlib2::Image.new(canvas_width, canvas_height)#キャンバス作成

canvas.fill_rect [0, 0, canvas_width, canvas_height]#色を白に染める

image = Imlib2::Image.load('yokonaga.png')#イメージロード

dst, src =  calcsize(image.width, image.height, canvas_width, canvas_height)#サイズ計算
src[:x] = 3
canvas.blend_image!(image, src[:x], src[:y], src[:w], src[:h], dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/blended.png")#ファイルに書き出す
end
=end
end