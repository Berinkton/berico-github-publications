local package = require("package")
local fs = require("filesystem")
package.path = package.path..";/lib/berico/?.lua"

local activePath = "/etc/rc.d"

if fs.exists("/lib/berico/bnet") then

  package.path = package.path..";/lib/berico/bnet/?.lua"

end

--#Service Autostart

if fs.exists(activePath.."/bnet-server.active") then
  os.execute("rc bnet-server start")
end