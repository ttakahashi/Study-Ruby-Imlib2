require 'rubygems'
require 'imlib2'

class Transform
  #---------------ägëÂèàóùÇ∆à íuÇé¶Ç∑ÉNÉâÉXíËêî---------------
  PRIORITY_LONG = 	1
  PRIORITY_SHORT = 	2
  HEIGHT_FULL = 	3
  WIDTH_FULL = 	4
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
        #-----à íuÇÃëOèàóùÇ∆ägëÂèàóù-----
    if ret["edge"] == YOKO then
      ret["posw"] = NONE
      ret["outh_tmp"] = ret["outh"]
      ret["outh"] = ret["outw"].to_f / ret["inw"].to_f * ret["inh"].to_f
    else
      #posh = NONE
      ret["outh_tmp"] = ret["outh"]
      ret["outw_tmp"] = ret["outw"]
      ret["outw"] = ret["outh"].to_f / ret["inh"].to_f * ret["inw"].to_f
    end
    ret["inx"] = ret["iny"] = ret["outx"] = ret["outy"] = 0
    ret["inw_tmp"] = 0 if ret["inw_tmp"] == nil
    ret["outh_tmp"] = 0 if ret["outh_tmp"] == nil
    return ret
  end

  def priority_short (ret)
    #-----à íuÇÃëOèàóù-----
    if ret["edge"] == YOKO then
      ret["posh"] = NONE
      ret["posw"] = NONE if ret["posw"] == MID_W
    else
      ret["posw"] = NONE
      #ret["posh"] = NONE if ret["posh"] == MID_H
    end
    #-----ägëÂèàóù-----
    if ret["edge"] ==YOKO then
      ret["inx"] = (ret["outw"].to_f - ret["inw"].to_f) / 2.0
      ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
      ret["inw"] = ret["outw"]
      ret["iny"] = 0
    elsif ret["edge"] == TATE then
      ret["inx"] = 0
      ret["iny"] = (ret["inh"].to_f - ret["outh"].to_f) / 2.0
      ret["inh_tmp"] = ret["inh"]
      ret["inh"] = ret["outh"]
    else
      ret["inx"] = 0
      ret["inw"] = ret["outw"]
      ret["iny"] = (ret["inh"].to_f - ret["outh"].to_f) / 2.0
      ret["inh_tmp"] = ret["inh"]
      ret["inh"] = ret["outh"]
    end
      ret["outx"] = ret["outy"] = 0
    return ret
  end

  def without_deform (ret)
    if ret["inw"] > ret["outw"] then #å≥âÊëúÇ™ëÂÇ´Ç©Ç¡ÇΩÇÁ
#      if ret["posw"] == RIGHT then
#        ret["inx"] = (ret["inw"] - ret["outw"])
#      elsif ret["posw"] == MID_W then
#        ret["inx"] = (ret["inw"] - ret["outw"]) / 2.0
#      else
#        ret["inx"] = 0
#      end
      ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
      #p ret["inw_tmp"] if ret["posw"] == RIGHT
    else #å≥âÊëúÇ™è¨Ç≥Ç©Ç¡ÇΩÇÁ
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
    #ret["outw"] = ret["inw"]2
    #ret["outh"] = ret["inh"]1
    ret["inx"] = 0 if ret["inx"] == nil
    ret["iny"] = 0 if ret["iny"] == nil
    ret["outx"] = 0 if ret["outx"] == nil
    ret["outy"] = 0 if ret["outy"] == nil
    ret["inw_tmp"] = 0 if ret["inw_tmp"] == nil
    ret["outw_tmp"] = ret["outw"] if ret["edge"] == TATE
    #ret["inx"] = 565
    #ret["iny"] = 27
    return ret
  end

  def fill(ret)
    ret.default = 0
    return ret
  end

  def height_full (ret)
    if ret["edge"] == YOKO then
      ret["inw_tmp"] = ret["inw"]
      ret["inw"] = ret["inh"].to_f / ret["outh"] * ret["outw"]
    elsif ret["edge"] == TATE then
      ret["inw_tmp"] = ret["inw"]
      ret["inw"] = ret["inh"] / ret["outh"] * ret["outw"]
    end
    #ret["inx"] = (ret["inw"] - ret["outw"]) / 2.0
    return ret
  end
  
  def width_full (ret)
    ret["outy"] = (ret["inh"] * ret["outw"] / ret["inw"]) / 2.0
    ret["outh_tmp"] = ret["outh"]
    ret["outh"] = ret["outh"] - (ret["inh"] * ret["outw"] / ret["inw"])
    return ret
  end

  def calcsize (ret)
    ret.default = 0
    #---------------ècí∑Ç©â°í∑Ç©ê≥ï˚å`Ç©í≤Ç◊ÇÈ---------------
    #ret["iny"] = ret["outx"] = ret["outy"] = nil
    if ret["inh"] < ret["inw"] then
      ret["edge"] = YOKO
    elsif ret["inh"] > ret["inw"] then
      ret["edge"] = TATE
    else
      ret["edge"] = SQUARE
    end
    

    #---------------ägëÂèàóù---------------
    case ret["deform"]
      #----------í∑Ç¢ï˚óDêÊÅió]îíÇçÏÇÈÅj----------
      when PRIORITY_LONG then
        ret = priority_long("deform" => ret["deform"], "edge" => ret["edge"], "posw" => ret["posw"], "outh" => ret["outh"], "outw" => ret["outw"], "inw" => ret["inw"], "inh" => ret["inh"], "posh" => ret["posh"])
      #----------íZÇ¢ï˚óDêÊÅió]îíÇêÿÇÈÅj----------
      when PRIORITY_SHORT then
        ret = priority_short("deform" => ret["deform"], "edge" => ret["edge"], "posh" => ret["posh"], "posw" => ret["posw"], "inx" => ret["inx"], "inw" => ret["inw"], "outw" => ret["outw"], "iny" => ret["iny"], "inh" => ret["inh"], "outh" => ret["outh"], "outx" => ret["outx"], "outy" => ret["outy"])
      #----------ècÇ100%égÇ§Åiâ°Ç™í∑ÇØÇÍÇŒêÿÇËÅAíZÇØÇÍÇŒó]ÇÁÇπÇÈÅj----------
      when HEIGHT_FULL then
        ret["posh"] = NONE if ret["edge"] == YOKO
        ret = height_full("deform" => ret["deform"], "inx" => ret["inx"], "iny" => ret["iny"], "inw" => ret["inw"], "inh" => ret["inh"], "outx" => ret["outx"], "outy" => ret["outy"], "outw" => ret["outw"], "outh" => ret["outh"], "posw" => ret["posw"], "posh" => ret["posh"], "edge" => ret["edge"])
      #----------â°Ç100%égÇ§ÅiècÇ™í∑ÇØÇÍÇŒêÿÇËÅAíZÇØÇÍÇŒó]ÇÁÇπÇÈÅj----------
      when WIDTH_FULL then
        ret["posw"] = NONE if ret["edge"] == YOKO
        ret = width_full("deform" => ret["deform"], "inx" => ret["inx"], "iny" => ret["iny"], "inw" => ret["inw"], "inh" => ret["inh"], "outx" => ret["outx"], "outy" => ret["outx"], "outw" => ret["outw"], "outh" => ret["outh"], "posh" => ret["posh"], "posw" => ret["posw"], "edge" => ret["edge"])
      #----------ägëÂÇ‡èkè¨Ç‡ÇµÇ»Ç¢----------
      when WITHOUT_DEFORM then
      #p ret["deform"]
        ret = without_deform("deform" => ret["deform"], "inw" => ret["inw"] , "outw" => ret["outw"], "inx" => ret["inx"], "outx" => ret["outx"], "inh" => ret["inh"], "outh" => ret["outh"], "outy" => ret["outy"], "iny" => ret["iny"], "posh" => ret["posh"], "posw" => ret["posw"], "edge" => ret["edge"])
      #----------ècÇ‡â°Ç‡çáÇÌÇπÇÈ----------
      when FILL then
        ret = fill("deform" => ret["deform"], "inw" => ret["inw"], "inh" => ret["inh"], "outw" => ret["outw"], "outh" => ret["outh"], "posh" => ret["posh"], "posw" => ret["posw"])
    end


    #----------â°à íuÇÃèàóù----------
    case ret["posw"]
      when LEFT then
        ret["inx"] = 0
        ret["outw"] = ret["inw"] if ret["deform"] == WITHOUT_DEFORM
        ret["outx"] = 0 if ret["deform"] == WITHOUT_DEFORM
      when MID_W then
        ret["inx"] = (ret["inw"] - ret["outw"]) / 2 unless ret["deform"] == HEIGHT_FULL#without_deform_middle
        ret["outw"] = ret["inw"] if ret["deform"] == WITHOUT_DEFORM
        ret["inx"] = 0 if ret["deform"] == WITHOUT_DEFORM && ret["edge"] == TATE #Ç‹Ç∆ÇﬂÇÈÇ∆Ç´2çsè„Ç…íçà”
        ret["inx"] = 0 if ret["deform"] == PRIORITY_LONG #&& ret["edge"] == TATE
      when RIGHT then
         ret["inx"] = ret["inw_tmp"].abs - ret["outw"]  unless ret["deform"] == HEIGHT_FULL
        ret["inx"] = ret["inw_tmp"] - ret["inw"] if ret["deform"] == HEIGHT_FULL
        ret["outw"] = ret["inw"] unless ret["deform"] == HEIGHT_FULL
        #ret["outw"] = ret["outw_tmp"] if ret["deform"] == PRIORITY_LONG
        ret["inx"] = 0 if ret["deform"] == WITHOUT_DEFORM && ret["edge"] == TATE
        ret["outx"] = ret["outw_tmp"] - ret["outw"] if ret["deform"] == WITHOUT_DEFORM && ret["edge"] == TATE
        ret["inx"] = 0 if ret["deform"] == PRIORITY_LONG
        ret["outw"] = ret["outh"].to_f / ret["inh"] * ret["inw"] if ret["deform"] == PRIORITY_LONG
        ret["outx"] = ret["outw_tmp"] - ret["outw"] if ret["deform"] == PRIORITY_LONG
      when NONE then
    end

    #----------ècà íuÇÃèàóù----------
    case ret["posh"]
      when UP then
        ret["iny"] = 0# if ret["deform"] == WIDTH_FULL
        ret["outy"] = 0 if ret["deform"] == WIDTH_FULL
        ret["outh"] = ret["inh"] if ret["deform"] == WITHOUT_DEFORM
        if ret["deform"] == WIDTH_FULL then#àÍçsÇ≈èëÇØÇ»Ç¢Åc
          if ret["edge"] == TATE then
            ret["inh"] = ret["outh_tmp"].to_f / ret["outw"] * ret["inw"]
            ret["outh"] = ret["outh_tmp"]
          end
        end
        ret["inh"] = ret["inw"].to_f / ret["outw"] * ret["outh"] if ret["deform"] == PRIORITY_SHORT
      when MID_H then
        ret["outy"] = (ret["outh_tmp"].to_f - (ret["outw"].to_f / ret["inw"].to_f * ret["inh"].to_f)) / 2.0 if ret["deform"] == PRIORITY_LONG
        ret["iny"] = (ret["inh"] - ret["outh"]) / 2.0 if ret["deform"] == WITHOUT_DEFORM#without_deform_middle
        ret["outh"] += ret["inh"] - ret["outh"] if ret["deform"] == WITHOUT_DEFORM#- (ret["inx"] + ret["outh"]) #without_deform_middle
        ret["outh"] = ret["outh_tmp"] if ret["deform"] == WIDTH_FULL && ret["edge"] == TATE
        if ret["deform"] == WIDTH_FULL then
          if ret["edge"] == TATE then
            ret["outy"] = 0
            ret["inh_tmp"] = ret["inh"]
            ret["inh"] = ret["outh_tmp"].to_f / ret["outw"] * ret["inw"]
            ret["iny"] = (ret["inh_tmp"] - ret["inh"]) / 2.0
          end
      end
       ret["inh"] =(  ret["inw"].to_f  /    ret["outw"]  *    ret["outh"])  if ret["deform"] == PRIORITY_SHORT
       ret["iny"] = ( ret["inh_tmp"] - ret["inh"] ) / 2.0 if ret["deform"]  == PRIORITY_SHORT
       ret["outx"] = ( ret["outw_tmp"] - ret["outw"] ) / 2.0 if ret["deform"] == PRIORITY_LONG && ret["edge"] == TATE
      when LOW then
        #ret["outy"] = ret["inh"] - ret["outh"]
        #ret["outh"] += ret["inx"]
        ret["iny"] = ret["inh"] - ret["outh"] if ret["deform"] == WITHOUT_DEFORM
        ret["outh"] += ret["inh"] - ret["outh"] unless ret["deform"] == WIDTH_FULL
        #ret["outh"] += ret["outy"] if ret["deform"] == PRIORITY_LONG
        ret["outy"] = ret["outh_tmp"] - (ret["inh"] * ret["outw"] / ret["inw"] ) if ret["deform"] == PRIORITY_LONG
        ret["outh"] = ret["inh"] * ret["outw"] / ret["inw"] if ret["deform"] == PRIORITY_LONG
        ret["outh"] = ret["outh_tmp"] if ret["deform"] == PRIORITY_LONG && ret["edge"] == TATE
        ret["outy"] += ret["outy"] if ret["deform"] == WIDTH_FULL
        if ret["deform"] == WIDTH_FULL then
          if ret["edge"] == TATE then
            ret["outh"] = ret["outh_tmp"]
            ret["outy"] = 0
            ret["inh_tmp"] = ret["inh"]
            ret["inh"] = ret["outh_tmp"].to_f / ret["outw"] * ret["inw"]
            ret["iny"] = (ret["inh_tmp"] - ret["inh"])
          end
        end
       ret["inh"] =(  ret["inw"].to_f  /    ret["outw"]  *    ret["outh"])  if ret["deform"] == PRIORITY_SHORT
       ret["iny"] = ret["inh_tmp"] - ret["inh"] if ret["deform"]  == PRIORITY_SHORT
       ret["outy"] = 0 if ret["deform"] == PRIORITY_LONG && ret["edge"] == TATE
      when NONE then
    end
      
   #---------ê‚ëŒílÅïêÆêîÇ…ïœä∑----------
    ret.delete("edge") if ret.has_key?("edge")
    ret.delete("inw_tmp") if ret.has_key?("inw_tmp")
    ret.delete("posw") if ret.has_key?("posw")
    ret.delete("posh") if ret.has_key?("posh")
    ret.delete("deform") if ret.has_key?("deform")
    ret.delete("outh_tmp") if ret.has_key?("outh_tmp")
    ret.delete("outw_tmp") if ret.has_key?("outw_tmp")
    ret.delete("inh_tmp") if ret.has_key?("inh_tmp")

    ret.each {|key, value|
      ret[key] = 0 if value == nil
    }
    ret["inx"] = ret["inx"].abs unless ret["inx"] == nil
    ret["iny"] = ret["iny"].abs unless ret["iny"] == nil
    ret["inw"] = ret["inw"].abs unless ret["inw"] == nil
    ret["inh"] = ret["inh"].abs unless ret["inh"] == nil
    ret["outx"] = ret["outx"].abs unless ret["outx"] == nil
    ret["outy"] = ret["outy"].abs unless ret["outy"] == nil
    ret["outw"] = ret["outw"].abs unless ret["outw"] == nil
    ret["outh"] = ret["outh"].abs unless ret["outh"] == nil

    ret["inx"] = ret["inx"].truncate unless ret["inx"] == nil
    ret["iny"] = ret["iny"].truncate unless ret["iny"] == nil
    ret["inw"] = ret["inw"].truncate unless ret["inw"] == nil
    ret["inh"] = ret["inh"].truncate unless ret["inh"] == nil
    ret["outx"] = ret["outx"].truncate unless ret["outx"] == nil
    ret["outy"] = ret["outy"].truncate unless ret["outy"] == nil
    ret["outw"] = ret["outw"].truncate unless ret["outw"] == nil
    ret["outh"] = ret["outh"].truncate unless ret["outh"] == nil

    return ret
  end

end
