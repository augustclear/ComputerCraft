--General CC Library

local function nuget(url,filename)
    local f = io.open(file,"w")
    local tmp = http.get("url",{"Cache-Control: no-cache"})
    if tmp == nil then
        print("[Can't connect to git...]")
    else
        f:write(tmp.readAll())
    end
    f:close()
end

return {nuget = nuget}