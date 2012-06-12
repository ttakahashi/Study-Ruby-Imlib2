require 'rubygems'
require 'imlib2'

class Transform
  #---------------Šg‘åˆ—‚ÆˆÊ’u‚ğ¦‚·ƒNƒ‰ƒX’è”---------------
  PRIORITY_LONG = 	1
  PRIORITY_SHORT = 	2
  HEIGHT_FULL = 	3
  WIDTH_FULL = 		4
  WITHOUT_DEFORM =	5
  FILL =		6
  
  UP = 			10
  MID_W = 		11
  LOW = 		12
  LEFT = 		13
  RIGHT =		14
  MID_H = 		15
  NONE =		16
   
  YOKO = 		20
  TATE = 		21
  SQUARE =		22
  
  def priority_long (edge, posw, outh, outw, inw, inh, posh)
        #-----ˆÊ’u‚Ì‘Oˆ—‚ÆŠg‘åˆ—-----
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
    ret.store("outx", outx)
    ret.store("outy", outy)
    ret.store("edge", edge)
    ret.store("outh", outh)
    ret.store("posw", posw)
    ret.store("posh", posh)
    ret.store("inw", inw)
    ret.store("inh", inh)
    ret.store("outw", outw)
    return ret
  end

  def priority_short (edge, posh, posw, inx, inw, outw, iny, inh, outh, outx, outy)
    #-----ˆÊ’u‚Ì‘Oˆ—-----
    if edge == YOKO then
      posh = NONE
      posw = NONE if posw == MID_W
    else
      posw = NONE
      posh = NONE if posh == MID_H
    end
    #-----Šg‘åˆ—-----
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
      ret.store("inx", inx)
      ret.store("inw", inw)
      ret.store("outw", outw)
      ret.store("iny", iny)
      ret.store("inh", inh)
      ret.store("outh", outh)
      ret.store("outx", outx)
      ret.store("outy", outy)
      ret.store("inw_tmp", inw_tmp)
      ret.store("posw", posw)
      ret.store("posh", posh)
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

  def fill(inw, inh, outw, outh)
    ret = Hash.new
    ret.default = 0
    ret.store("inw", inw)
    ret.store("inh", inh)
    ret.store("outw", outw)
    ret.store("outh", outh)
    return ret
  end

  def calcsize (inw, inh, outw, outh, deform, posw, posh)
    #---------------c’·‚©‰¡’·‚©³•ûŒ`‚©’²‚×‚é---------------
    inx = iny = outx = outy = nil
    if inh < inw then
      edge = YOKO
    elsif inh > inw then
      edge = TATE
    else
      edge = SQUARE
    end
    
    
    #---------------Šg‘åˆ—---------------
    case deform
      #----------’·‚¢•û—Dæi—]”’‚ğì‚éj----------
      when PRIORITY_LONG then
        ret = priority_long(edge, posw, outh, outw, inw, inh, posh)
      #----------’Z‚¢•û—Dæi—]”’‚ğØ‚éj----------
      when PRIORITY_SHORT then
        ret = priority_short(edge, posh, posw, inx, inw, outw, iny, inh, outh, outx, outy)
      #----------c‚ğ100%g‚¤i‰¡‚ª’·‚¯‚ê‚ÎØ‚èA’Z‚¯‚ê‚Î—]‚ç‚¹‚éj----------
      when HEIGHT_FULL then
        posh = NONE if edge == YOKO
      #----------‰¡‚ğ100%g‚¤ic‚ª’·‚¯‚ê‚ÎØ‚èA’Z‚¯‚ê‚Î—]‚ç‚¹‚éj----------
      when WIDTH_FULL then
        posw = NONE if edge == YOKO
      #----------Šg‘å‚àk¬‚à‚µ‚È‚¢----------
      when WITHOUT_DEFORM then
        ret = without_deform(inw, outw, inx, outx, inh, outh, outy, iny)
      #----------c‚à‰¡‚à‡‚í‚¹‚é----------
      when FILL then
        ret = fill(inw, inh, outw, outh)
    end


    #----------‰¡ˆÊ’u‚Ìˆ—----------
    case ret["posw"]
      when LEFT then
        ret["inx"] = 0
      when MID_W then
      when RIGHT then
        ret["inx"] = ret["inw_tmp"].abs - ret["outw"] 
      when NONE then
    end

    #----------cˆÊ’u‚Ìˆ—----------
    case ret["posh"]
      when UP then
        ret["iny"] = 0
      when MID_H then
        ret["outy"] = (ret["outh"].to_f - ret["inh"].to_f ) / 2.0
      when LOW then
        ret["outy"] = ret["inh"] - ret["outh"]
      when NONE then
    end
      
   #---------â‘Î’l•®”‚É•ÏŠ·----------

    ret.store("inx", inx) if inx == "nil"
    ret.store("iny", iny) if iny == "nil"
    ret.store("inw", inw) if inw == "nil"
    ret.store("inh", inh) if inh == "nil"
    ret.store("outx", outx) if outx == "nil"
    ret.store("outy", outy) if outy == "nil"
    ret.store("outw", outw) if outw == "nil"
    ret.store("outh", outh) if outh == "nil"
    ret.store("edge", edge) if edge == "nil"

    ret.store("outw", 0) if ret["outw"] == "nil"

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

    ret.delete("inw_tmp") if ret.key?("inw_tmp")
    ret.delete("posw") if ret.key?("posw")
    ret.delete("posh") if ret.key?("posh")
    return ret
  end
end
