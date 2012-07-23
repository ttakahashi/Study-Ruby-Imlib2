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


  def priority_long (ret)
        #-----ˆÊ’u‚Ì‘Oˆ—‚ÆŠg‘åˆ—-----
    if ret["edge"] == YOKO then
      ret["posw"] = NONE
      ret["outh"] = ret["outw"].to_f / ret["inw"].to_f * ret["inh"].to_f
    else
      posh = NONE
      ret["outw"] = ret["outh"].to_f / ret["inh"].to_f * ret["inw"].to_f
    end
    ret["inx"] = ret["iny"] = ret["outx"] = ret["outy"] = 0
    return ret
  end

  def priority_short (ret)
    #-----ˆÊ’u‚Ì‘Oˆ—-----
    if ret["edge"] == YOKO then
      ret["posh"] = NONE
      ret["posw"] = NONE if ret["posw"] == MID_W
    else
      ret["posw"] = NONE
      ret["posh"] = NONE if ret["posh"] == MID_H
    end
    #-----Šg‘åˆ—-----
    if ret["edge"] ==YOKO then
      ret["inx"] = (ret["outw"].to_f - ret["inw"].to_f) / 2.0
      ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
      ret["inw"] = ret["outw"]
      ret["iny"] = 0
    elsif ret["edge"] == TATE then
      ret["inx"] = 0
      ret["iny"] = (ret["inh"].to_f - ret["outh"].to_f) / 2.0
      ret["inh"] = ret["outh"]
    else
      ret["inx"] = 0
      ret["inw"] = ret["outw"]
      ret["iny"] = (ret["inh"].to_f - ret["outh"].to_f) / 2.0
      ret["inh"] = ret["outh"]
    end
      ret["outx"] = ret["outy"] = 0
    return ret
  end

  def without_deform (ret)
    if ret["inw"] > ret["outw"] then
#      if ret["posw"] == RIGHT then
#        ret["inx"] = (ret["inw"] - ret["outw"])
#      elsif ret["posw"] == MID_W then
#        ret["inx"] = (ret["inw"] - ret["outw"]) / 2.0
#      else
#        ret["inx"] = 0
#      end
      ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
      p ret["inw_tmp"] if ret["posw"] == RIGHT
    else
      ret["outx"] = (ret["outw"] - ret["inw"]) / 2.0
    end
    if ret["inh"] > ret["outh"] then
 #     if ret["posh"] == LOW then
 #       ret["iny"] = (ret["outw"] - ret["inh"])
 #     elsif ret["posh"] == MID_H then
 #       ret["iny"] = (ret["outw"] - ret["inh"]) / 2.0
 #     else
 #       ret["iny"] = 0
 #     end
       #ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
    else
      ret["outy"] = (ret["outh"] - ret["inh"] ) / 2.0
    end
    ret["outw"] = ret["inw"]
    ret["outh"] = ret["inh"]
    ret["inx"] = 0 if ret["inx"] == nil
    ret["iny"] = 0 if ret["iny"] == nil
    ret["outx"] = 0 if ret["outx"] == nil
    ret["outy"] = 0 if ret["outy"] == nil
    
    #ret["inx"] = 565
    #ret["iny"] = 27
    return ret
  end

  def fill(ret)
    ret.default = 0
    return ret
  end

  def calcsize (ret)
    ret.default = 0
    #---------------c’·‚©‰¡’·‚©³•ûŒ`‚©’²‚×‚é---------------
    #ret["iny"] = ret["outx"] = ret["outy"] = nil
    if ret["inh"] < ret["inw"] then
      ret["edge"] = YOKO
    elsif ret["inh"] > ret["inw"] then
      ret["edge"] = TATE
    else
      ret["edge"] = SQUARE
    end
    
  def height_full (ret)
    if ret["edge"] == YOKO then
    elsif ret["edge"] == TATE then
    end
      
    ret["inx"] = (ret["inw"] - ret["outw"]) / 2.0
    
    return ret
  end
    
    #---------------Šg‘åˆ—---------------
    case ret["deform"]
      #----------’·‚¢•û—Dæi—]”’‚ğì‚éj----------
      when PRIORITY_LONG then
        ret = priority_long("edge" => ret["edge"], "posw" => ret["posw"], "outh" => ret["outh"], "outw" => ret["outw"], "inw" => ret["inw"], "inh" => ret["inh"], "posh" => ret["posh"])
      #----------’Z‚¢•û—Dæi—]”’‚ğØ‚éj----------
      when PRIORITY_SHORT then
        ret = priority_short("edge" => ret["edge"], "posh" => ret["posh"], "posw" => ret["posw"], "inx" => ret["inx"], "inw" => ret["inw"], "outw" => ret["outw"], "iny" => ret["iny"], "inh" => ret["inh"], "outh" => ret["outh"], "outx" => ret["outx"], "outy" => ret["outy"])
      #----------c‚ğ100%g‚¤i‰¡‚ª’·‚¯‚ê‚ÎØ‚èA’Z‚¯‚ê‚Î—]‚ç‚¹‚éj----------
      when HEIGHT_FULL then
        ret["posh"] = NONE if ret["edge"] == YOKO
        ret = height_full("inx" => ret["inx"], "inw" => ret["inw"], "outw" => ret["outw"], "posw" => ret["posw"], "posh" => ret["posh"], "edge" => ret["edge"})
      #----------‰¡‚ğ100%g‚¤ic‚ª’·‚¯‚ê‚ÎØ‚èA’Z‚¯‚ê‚Î—]‚ç‚¹‚éj----------
      when WIDTH_FULL then
        ret["posw"] = NONE if ret["edge"] == YOKO
      #----------Šg‘å‚àk¬‚à‚µ‚È‚¢----------
      when WITHOUT_DEFORM then
        ret = without_deform("inw" => ret["inw"] , "outw" => ret["outw"], "inx" => ret["inx"], "outx" => ret["outx"], "inh" => ret["inh"], "outh" => ret["outh"], "outy" => ret["outy"], "iny" => ret["iny"], "posh" => ret["posh"], "posw" => ret["posw"])
      #----------c‚à‰¡‚à‡‚í‚¹‚é----------
      when FILL then
        ret = fill("inw" => ret["inw"], "inh" => ret["inh"], "outw" => ret["outw"], "outh" => ret["outh"])
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
    ret.delete("edge") if ret.has_key?("edge")
    ret.delete("inw_tmp") if ret.has_key?("inw_tmp")
    ret.delete("posw") if ret.has_key?("posw")
    ret.delete("posh") if ret.has_key?("posh")
    ret.delete("deform") if ret.has_key?("deform")

    ret.each {|key, value|
      ret[key] = 0 if value == nil
    }
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

    return ret
  end

end
