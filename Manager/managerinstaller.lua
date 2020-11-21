--Function to get files

function getFile(url, filename) 
	--if fs.exists(filename) then
		--print("Delete "..filename)
		fs.delete(filename)
	--end
	shell.run("wget",url,filename)
end

--Calls to get file

fs.makeDir("lib")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerlib.lua","lib/managerlib")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerbg.lua","managerbg")
getFile("https://raw.githubusercontent.com/augustclear/ComputerCraft/main/Manager/managerfg.lua","managerfg")

term.clear()
term.setCursorPos(1,1)

--Setup Commands
 
manlib = require("lib.managerlib")
manlib.init()
 
--Files to run
 
shell.openTab("managerbg")
shell.run("managerfg")
