--Manager Background Application

local manlib = require("lib.managerlib")

term.write("Open for connections")

while true do
    --Go to new line
    term.setCursorPos(1,2)
    manlib.get_heartbeats()
    manlib.print_workers()
end