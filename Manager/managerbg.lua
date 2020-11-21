--Manager Background Application

local manlib = require("lib.managerlib")
local tx,ty = 1,1
local mx,my = term.getSize()

term.write("Open for connections")
term.setCursorBlink(true)

while true do
    --Go to new line
    ty = ty + 1
    term.setCursorPos(tx,ty)
    manlib.get_heartbeats()
    --Scroll if past screen
    tx,ty = term.getCursorPos()
    if ty == my then
        term.scroll(1)
        ty = ty - 1
    end
end