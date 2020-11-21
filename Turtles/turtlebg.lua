local w = require("lib.turtlelib")

term.setCursorPos(1,1)
term.write("Connecting to server...\n")

while true do
    local x, y, z = w.send_heartbeat()
    term.setCursorPos(1,2)
    term.clearLine()
    term.write("[GPS]: " .. x .. "," .. y .. "," .. z .. "\n")
    os.sleep(10)
end