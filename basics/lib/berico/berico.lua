--###############################################################
--##                                                           ##
--##  This file is part of all BeriCo Software                 ##
--##  for OpenComputers                                        ##
--##  Author: Berinkton                                        ##
--##  Webiste: http://theuton.de/berinkton/mc/berico           ##
--##                                                           ##
--###############################################################

local term = require("term")
local serialization = require("serialization")
local gpu = require("component").gpu

local berico = {}

berico.colors = {
  white="0xFFFFFF",
  red="0xb50000",
  orange="0xfa8d00",
  green="0x01ab00",
  blue="0x0301dc"

}

function berico.info(progName,color,str)

  if os.getenv("TERM") == "term-2color" then
    color = berico.colors["white"]
  else
    color = berico.colors[color]
  end

  local xCpos,yCpos = term.getCursor()
  gpu.setForeground(tonumber(color))
  term.write(progName..":")
  term.setCursor(string.len(progName)+3,yCpos)
  gpu.setForeground(tonumber(berico.colors["white"]))
  term.write(str)
  term.setCursor(1,yCpos+1)

end

function berico.reader(file)
  local out = io.open(file,"r")
  out = serialization.unserialize(out:read("*a"))
  
  return out
  
end

function berico.writer(file,data)
  local inp = io.open(file,"w")
  if inp ~= nil then
    if type(data) == "table" then
      data = serialization.serialize(data)
    end
    inp:write(data)
    inp:close()
    return true
  else
    return nil,"destination folder does not exist."
  end
  
end

return berico