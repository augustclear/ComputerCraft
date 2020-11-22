--Function to get nuget

if ~fs.exists("lib/genlib") then
	fs.makeDir("lib")
	shell.run("wget","https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Utilities/genlib.lua","lib/genlib")
end

local gl = require("lib.genlib")

--Calls to get file

gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Utilities/genlib.lua","lib/genlib")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerlib.lua","lib/managerlib")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerbg.lua","managerbg")
gl.nuget("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerfg.lua","managerfg")

term.clear()
term.setCursorPos(1,1)

--Setup Commands
 
manlib = require("lib.managerlib")
manlib.init()
 
--Files to run
 
shell.openTab("managerbg")
shell.openTab("managerfg")