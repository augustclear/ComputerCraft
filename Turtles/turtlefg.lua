local w = require("lib.turtlelib")
local command = nil;

--Original Test Position 10,40,240
print("Enter test commands... ")
while command ~= "close" do
    command = read()
    if command == "refuel" then
        w.refuel()
    elseif command == "reboot" then
        os.reboot()
    elseif command == "home" then
        w.go_home()
    end
end

--term.setCursorPos(1,1)
--term.write("Awaiting orders...")

--while command ~= "close" do
--    command = w.take_orders()
--    term.setCursorPos(1,2)
--    term.clearLine()
--    term.write("[COMMAND]:" .. command)
--end