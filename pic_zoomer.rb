require 'rubygems'
require 'imlib2'

class Transform
  #---------------�g�又���ƈʒu�������N���X�萔---------------
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
        #-----�ʒu�̑O�����Ɗg�又��-----
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
    #-----�ʒu�̑O����-----
    if ret["edge"] == YOKO then
      ret["posh"] = NONE
      ret["posw"] = NONE if ret["posw"] == MID_W
    else
      ret["posw"] = NONE
      ret["posh"] = NONE if ret["posh"] == MID_H
    end
    #-----�g�又��-----
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
    if ret["inw"] > ret["outw"] then #���摜���傫��������
#      if ret["posw"] == RIGHT then
#        ret["inx"] = (ret["inw"] - ret["outw"])
#      elsif ret["posw"] == MID_W then
#        ret["inx"] = (ret["inw"] - ret["outw"]) / 2.0
#      else
#        ret["inx"] = 0
#      end
      ret["inw_tmp"] = ret["inw"] if ret["posw"] == RIGHT
      #p ret["inw_tmp"] if ret["posw"] == RIGHT
    else #���摜��������������
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
    #---------------�c���������������`�����ׂ�---------------
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
    ret["inw_tmp"] = 0 unless ret["inw_tmp"] = nil
    return ret
  end
    #p ret["deform"]
    #---------------�g�又��---------------
    case ret["deform"]
      #----------�������D��i�]�������j----------
      when PRIORITY_LONG then
        ret = priority_long("deform" => ret["deform"], "edge" => ret["edge"], "posw" => ret["posw"], "outh" => ret["outh"], "outw" => ret["outw"], "inw" => ret["inw"], "inh" => ret["inh"], "posh" => ret["posh"])
      #----------�Z�����D��i�]����؂�j----------
      when PRIORITY_SHORT then
        ret = priority_short("deform" => ret["deform"], "edge" => ret["edge"], "posh" => ret["posh"], "posw" => ret["posw"], "inx" => ret["inx"], "inw" => ret["inw"], "outw" => ret["outw"], "iny" => ret["iny"], "inh" => ret["inh"], "outh" => ret["outh"], "outx" => ret["outx"], "outy" => ret["outy"])
      #----------�c��100%�g���i����������ΐ؂�A�Z����Η]�点��j----------
      when HEIGHT_FULL then
        ret["posh"] = NONE if ret["edge"] == YOKO
        ret = height_full("deform" => ret["deform"], "inx" => ret["inx"], "inw" => ret["inw"], "outw" => ret["outw"], "posw" => ret["posw"], "posh" => ret["posh"], "edge" => ret["edge"])
      #----------����100%�g���i�c��������ΐ؂�A�Z����Η]�点��j----------
      when WIDTH_FULL then
        ret["posw"] = NONE if ret["edge"] == YOKO
      #----------�g����k�������Ȃ�----------
      when WITHOUT_DEFORM then
      #p ret["deform"]
        ret = without_deform("deform" => ret["deform"], "inw" => ret["inw"] , "outw" => ret["outw"], "inx" => ret["inx"], "outx" => ret["outx"], "inh" => ret["inh"], "outh" => ret["outh"], "outy" => ret["outy"], "iny" => ret["iny"], "posh" => ret["posh"], "posw" => ret["posw"])
      #----------�c���������킹��----------
      when FILL then
        ret = fill("deform" => ret["deform"], "inw" => ret["inw"], "inh" => ret["inh"], "outw" => ret["outw"], "outh" => ret["outh"])
    end


    #----------���ʒu�̏���----------
    case ret["posw"]
      when LEFT then
        ret["inx"] = 0
      when MID_W then
      when RIGHT then
        ret["inx"] = ret["inw_tmp"].abs - ret["outw"] 
        p 
        #if ret["deform"] == WITHOUT_DEFORM then
          #p "inw_tmp: #{ret["inw_tmp"]}, outw: #{ret["outw"]}"
        #end
      when NONE then
    end

    #----------�c�ʒu�̏���----------
    case ret["posh"]
      when UP then
        ret["iny"] = 0
      when MID_H then
        ret["outy"] = (ret["outh"].to_f - ret["inh"].to_f ) / 2.0
      when LOW then
        #ret["outy"] = ret["inh"] - ret["outh"]
        ret["outw"] += ret["inx"]
        ret["iny"] = ret["inh"] - ret["outh"] if ret["deform"] == WITHOUT_DEFORM
        #if ret["deform"] == WITHOUT_DEFORM then
          #p "inh: #{ret["inh"]}, outh: #{ret["outh"]}"
        #end
        ret["outh"] += ret["inh"] - ret["outh"]
      when NONE then
    end
     #p ret["deform"]
     #p WITHOUT_DEFORM
      
   #---------��Βl�������ɕϊ�----------
    ret.delete("edge") if ret.has_key?("edge")
    ret.delete("inw_tmp") if ret.has_key?("inw_tmp")
    ret.delete("posw") if ret.has_key?("posw")
    ret.delete("posh") if ret.has_key?("posh")
    ret.delete("deform") if ret.has_key?("deform")

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