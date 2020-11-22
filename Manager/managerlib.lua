--Manager Library

local _x, _y, _z
local workerlist = {}
local worker = {name = "none", command = "none", x = 0, y = 0, z = 0}

local function open()
    rednet.host("boss","boss")
    rednet.open("top")
end

local function close()

end

local function init()
    open()
    _x, _y, _z = gps.locate(5)
    if _x == nil then
        do return -1 end
    end
    return 0
end

local function send_command(workername, s)
    local id = rednet.lookup("workers",workername)
    if id ~= nil then
        rednet.send(id,s,"workers")
    end
end

local function write_workerlist()
    local tmp = textutils.serialize(workerlist)
    local f = io.open("workerlist.lua","w")
    f:write(tmp)
    f:close()
end

local function read_workerlist()
    local tmp
    local f = io.open("workerlist.lua","r")
    if f ~= nil then
        tmp = f:read("*all")
        f:close()
        workerlist = textutils.unserialize(tmp)
    end
end

local function get_heartbeats()
    read_workerlist()
    local id, msg = rednet.receive("heartbeat")
    msg = textutils.unserialize(msg)
    local name, x, y, z = msg.name, msg.x, msg.y, msg.z
    worker["name"] = name
    if workerlist[id] == nil then
        worker.command = "none"
        if name == nil then
            worker.name = "none"
        end
    end
    worker["x"] = x
    worker["y"] = y
    worker["z"] = z
    workerlist[id] = worker
    write_workerlist()
end

local function print_workers()
    --textutils.pagedTabulate(workerlist)
    for i,v in next,workerlist,nil do
        print("[" .. i .. "] ".. v["command"] .. " " .. v["name"] .. " " .. v["x"] .. "," .. v["y"] .. "," .. v["z"])
    end
end

return {open = open, close = close, init = init, send_command = send_command, get_heartbeats = get_heartbeats, print_workers = print_workers}