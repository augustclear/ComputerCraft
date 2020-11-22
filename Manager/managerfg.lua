--Terminal Foreground Application

local m = require("lib.managerlib")

while true do
    m.send_command("Milly","go forward")
    os.sleep(1)
    m.send_command("Milly","go forward")
    os.sleep(1)
    m.send_command("Milly","go back")
    os.sleep(1)
    m.send_command("Milly","go back")
    os.sleep(1)
end