local w = require("lib.turtlelib")
local command = nil;

--Original Test Position 10,40,240
print("Starting Test")

w.go_to(15,40,240)
w.go_to(10,40,240)
w.go_to(5,40,240)
--term.setCursorPos(1,1)
--term.write("Awaiting orders...")

--while command ~= "close" do
--    command = w.take_orders()
--    term.setCursorPos(1,2)
--    term.clearLine()
--    term.write("[COMMAND]:" .. command)
--end