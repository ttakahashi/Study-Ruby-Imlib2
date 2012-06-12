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
  MID_W = 			11
  LOW = 			12
  LEFT = 			13
  RIGHT =			14
  MID_H = 			15
  NONE =			16
  
  YOKO = 			20
  TATE = 			21
  SQUARE =			22



def priority_long (edge, posw, outh, outw, inw, inh, posh)
        #-----位置の前処理と拡大処理-----
  if edge == YOKO then
    posw = NONE
    outh = outw.to_f / inw.to_f * inh.to_f
  else
    posh = NONE
    outw = outh.to_f / inh.to_f * inw.to_f
  end
  inx = iny = outx = outy = 0
  ret = Hash.new
  ret.default = 0
  ret.store("inx", inx)
  ret.store("iny", iny)
  ret.store("outx", inw)
  ret.store("outy", inh)
  ret.store("edge", edge)
  ret.store("posw", posw)
  ret.store("outh", outh)
  ret.store("posh", posh)
  return ret
end

def priority_short (edge, posh, posw, inx, inw, outw, iny, inh, outh, outx, outy)
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
    ret = Hash.new
    ret.default = 0
    ret.store("edge", edge)
    ret.store("posh", posh)
    ret.store("posw", posw)
    ret.store("inx", inx)
    ret.store("inw", inw)
    ret.store("outw", outw)
    ret.store("iny", iny)
    ret.store("inh", inh)
    ret.store("outh", outh)
    ret.store("outx", outx)
    ret.store("outy", outy)
    ret.store("inw_tmp", inw_tmp)
  return ret
  end
  
  def without_deform (inw, outw, inx, outx, inh, outh, outy, iny)
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
    ret = Hash.new
    ret.default = 0
    ret.store("inw", inw)
    ret.store("outw", outw)
    ret.store("inx", inx)
    ret.store("outx", outx)
    ret.store("inh", inh)
    ret.store("outh", outh)
    ret.store("outy", outy)
    ret.store("iny", iny)
    ret.store("outx", outx)
    return ret
  end
  
  def fill(posh, posw, inx, iny, outx, outy)
    posh = posw = NONE
    inx = iny = outx = outy = 0
    ret = Hash.new
    ret.default = 0
    ret.store("posh", posh)
    ret.store("posw", posw)
    ret.store("inx", inx)
    ret.store("iny", iny)
    ret.store("outx", outx)
    ret.store("outy", outy)
    return ret
  end

  def calcsize (inw, inh, outw, outh, deform, posw, posh)
    #---------------縦長か横長か正方形か調べる---------------
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
        ret = priority_long(edge, posw, outh, outw, inw, inh, posh)
      #----------短い方優先（余白を切る）----------
      when PRIORITY_SHORT then
        ret = priority_short(edge, posh, posw, inx, inw, outw, iny, inh, outh, outx, outy)
      #----------縦を100%使う（横が長ければ切り、短ければ余らせる）----------
      when HEIGHT_FULL then
        posh = NONE if edge == YOKO
      #----------横を100%使う（縦が長ければ切り、短ければ余らせる）----------
      when WIDTH_FULL then
        posw = NONE if edge == YOKO
      #----------拡大も縮小もしない----------
      when WITHOUT_DEFORM then
        ret = without_deform(inw, outw, inx, outx, inh, outh, outy, iny)
      #----------縦も横も合わせる----------
      when FILL then
        ret = fill(posh, posw, inx, iny, outx, outy)
      end
      
      
      #----------横位置の処理----------
      case ret["posw"]
        when LEFT then
          ret["inx"] = 0
        when MID_W then
        when RIGHT then
          ret["inx"] = ret["inw_tmp"].abs - ret["outw"] 
        when NONE then
      end

      #----------縦位置の処理----------
      case ret["posh"]
      when UP then
        ret["iny"] = 0
      when MID_H then
        ret["outy"] = (ret["outh"].to_f - ret["inh"].to_f ) / 2.0
      when LOW then
        ret["outy"] = ret["inh"] - ret["outh"]
      when NONE then
      end
      
     #---------絶対値＆整数に変換----------

ret.store("inx", inx) if inx == "nil"
ret.store("iny", iny) if iny == "nil"
ret.store("inw", inw) if inw == "nil"
ret.store("inh", inh) if inh == "nil"
ret.store("outx", outx) if outx == "nil"
ret.store("outy", outy) if outy == "nil"
ret.store("outw", outw) if outw == "nil"
ret.store("outh", outh) if outh == "nil"
ret.store("edge", edge) if edge == "nil"
#ret.store("inw_tmp", inw_tmp) if inw_tmp == "nil"

ret.store("outw", 0) if ret["outw"] == "nil"

=begin
     ret["inx"] = ret["inx"].abs
     ret["iny"] = ret["iny"].abs
     ret["inw"] = ret["inw"].abs
     ret["inh"] = ret["inh"].abs
     ret["outx"] = ret["outx"].abs
     ret["outy"] = ret["outy"].abs
     ret["outw"] = ret["outw"].abs
     ret["outh"] = ret["outh"].abs
     
     ret["inx"] = ret["inx"].truncate
     ret["iny"] = ret["iny"].truncate
     ret["inw"] = ret["inw"].truncate
     ret["inh"] = ret["inh"].truncate
     ret["outx"] = ret["outx"].truncate
     ret["outy"] = ret["outy"].truncate
     ret["outw"] = ret["outw"].truncate
     ret["outh"] = ret["outh"].truncate
=end
     
       return ret
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