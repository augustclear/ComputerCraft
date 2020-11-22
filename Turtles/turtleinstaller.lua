--Function to get nuget

fs.makeDir("lib")
if fs.exists("lib/genlib") == false then
    shell.run("wget","https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Utilities/genlib.lua","lib/genlib")
end

local gl = require("lib.genlib")

--Calls to get files

gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Utilities/genlib.lua","lib/genlib")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlelib.lua","lib/turtlelib")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlebg.lua","turtlebg")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlefg.lua","turtlefg")

term.clear()
term.setCursorPos(1,1)

--Setup Commands

local w = require("lib.turtlelib")
w.open()

local id = shell.openTab("turtlebg")
multishell.setTitle(id,"GPS")

--Files to run
if turtle.getFuelLevel() < 1000 then
    print("I need food!!!!")
    turtle.refuel(1000)
else
    id = shell.openTab("turtlefg")
    multishell.setTitle(id,"COMMAND")
end