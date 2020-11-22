--Manager Background Application

local m = require("lib.managerlib")

term.write("Open for connections")

while true do
    --Go to new line
    term.setCursorPos(1,2)
    m.get_heartbeats()
    term.clear()
    term.setCursorPos(1,2)
    m.print_workers()
end