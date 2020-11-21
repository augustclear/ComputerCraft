local w = require("lib.turtlelib")
local command = nil;

term.setCursorPos(1,1)
term.write("Awaiting orders...")

while command ~= "close" do
    command = w.take_orders()
    term.setCursorPos(1,2)
    term.clearLine()
    term.write("[COMMAND]:" .. command)
end