--General CC Library

local function nuget(url,filename)
    local tmp = http.get(url,{"Cache-Control: no-cache","Cache-Control: no-store","Cache-Control: max-age=0"})
    if tmp == nil then
        print("[Can't connect to git...]")
    else
        tmp = tmp.readAll()
        if tmp == "" then
            prin("Didn't work... Trying wget")
            fs.delete(filename)
            shell.run("wget",url,filename)
        else
            print("[Read " .. filename .. " successfully]")
            local f = io.open(filename,"w")
            f:write(tmp)
            f:close()
        end
        
    end
end

return {nuget = nuget}