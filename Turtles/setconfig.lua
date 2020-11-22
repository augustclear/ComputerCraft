local args = { ... }
local w = require("lib.turtlelib")

w.read_config()

if args[1] == "home" then
    w.write_config_value("home",{args[2],args[3],args[4]})
elseif args[1] == "fuel_stop" then
    w.write_config_value("fuel_stop",{args[2],args[3],args[4]})
end