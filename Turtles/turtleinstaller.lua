--Function to get nuget

fs.makeDir("lib")
if fs.exists("lib/genlib") then
    --Something
else
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

--Files to run

local id = shell.openTab("turtlebg")
multishell.setTitle(id,"GPS")
id = shell.openTab("turtlefg")
multishell.setTitle(id,"COMMAND")