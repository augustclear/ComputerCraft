--Function to get files

function getFile(url, filename) 
	if fs.exists(filename) then
		--print("Delete "..filename)
		fs.delete(filename)
	end
	shell.run("wget",url,filename)
end

--Calls to get files

fs.makeDir("lib")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlelib.lua","lib/turtlelib")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlebg.lua","turtlebg")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Turtles/turtlefg.lua","turtlefg")

term.clear()
term.setCursorPos(1,1)

--Setup Commands

local w = require("lib.turtlelib")
w.init()

--Files to run

local id = shell.openTab("turtlebg")
multishell.setTitle(id,"GPS")
--shell.run("turtlefg")