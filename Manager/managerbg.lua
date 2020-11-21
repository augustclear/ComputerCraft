--Manager Background Application

local manlib = require("lib.managerlib")
local tx,ty = 1,1
local mx,my = term.getSize()

term.write("Open for connections")

while true do
    ty = ty + 1
    term.setCursorPos(tx,ty)
    tx,ty = term.getCursorPos()
    if ty > my then
        scroll(1)
    end
    manlib.get_heartbeats()
end