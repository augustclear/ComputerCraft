--Manager Background Application

local manlib = require("lib.managerlib")
local tx,ty = 1,1
local mx,my = term.getSize()

term.write("Open for connections")

while true do
    --Go to new line
    ty = ty + 1
    term.setCursorPos(tx,ty)

    --Scroll if past screen
    tx,ty = term.getCursorPos()
    if ty > my then
        if ty % 2 == 0 then
            term.scroll(1)
            term.write("scroll")
        end
    end
    manlib.get_heartbeats()
end