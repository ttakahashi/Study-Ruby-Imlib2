require 'rubygems'
require 'imlib2'
class Transform
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
  NONE =			20
  def calcsize (inw, inh, outw, outh, deform, posw, posh)
    inx = iny = outx = outy = nil
    if inh < inw then#1なら横長0なら縦長
      edge = "1"
    elsif inh > inw then
      edge = "0"
    else
      edge = "2"
    end
    
    case deform
      when PRIORITY_LONG then#長い方優先（余白を作る）PRIORITY_LONG
        if edge == "1" then
          posw = NONE#横長なら横の位置決め不要
          outh = outw.to_f / inw.to_f * inh.to_f
        else
          posh = NONE#縦長なら縦の位置決め不要
          outw = outh.to_f / inh.to_f * inw.to_f
        end
        inx = iny = outx = outy = 0
      when PRIORITY_SHORT then#短い方優先（余白を切る）PRIORITY_SHORT
        if edge == "1" then#横長なら縦の位置決め不要
          posh = NONE
          posw = NONE if posw == "MID_W"#元々中央の計算なので
        else
          posw = NONE
          posh = NONE if posh == "MID_H"#元々中央の計算なので
        end

        if edge =="1" then
          inx = (outw.to_f - inw.to_f) / 2.0
          inw = outw
          iny = 0
        elsif edge == "0" then
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
      when HEIGHT_FULL then#縦を100%使う（横が長ければ切り、短ければ余らせる）HEIGHT_FULL
        posh = NONE if edge == "1"#横のみ必要
        
      when WIDTH_FULL then#横を100%使う（縦が長ければ切り、短ければ余らせる）WIDTH_FULL
        posw = NONE if edge == "1"#縦のみ必要
        
      when WITHOUT_DEFORM then#拡大も縮小もしないWITHOUT_DEFORM
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
      when FILL then#縦も横も合わせるFILL
        posh = posw = NONE
        inx = iny = outx = outy = 0
      end
      case posw
        when LEFT then
          inx = 0
        when MID_W then
        when RIGHT then
          iny = inw - outw
        when NONE then
      end
      case posh
      when UP then
        iny = 0
      when MID_H then
      when LOW then
        iny = inh - outh
      when NONE then
      end

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

  return [inx, iny, inw, inh, outx, outy, outw, outh]
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