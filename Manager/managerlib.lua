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
    return rednet.send(id,s,"workers")
end

local function get_heartbeats()
    local id, msg = rednet.receive("heartbeat")
    local name, x, y, z = msg.name, msg.x, msg.y, msg.z
    msg = textutils.unserialize(msg)
    if workerlist[id].command == nil then
        worker.command = "none"
    end
    if workerlist[id].name == nil then
        worker.name = "none"
    end
    worker["name"] = name
    worker["x"] = x
    worker["y"] = y
    worker["z"] = z
    workerlist[id] = worker
end

local function get_workers()
    return workerlist
end

local function print_workers()
    --textutils.pagedTabulate(workerlist)
    term.clear()
    term.setCursorPos(1,2)
    for index,value in next,workerlist,nil do
        print("[" .. index .. "] " .. textutils.serialize(value))
    end
end

return {open = open, close = close, init = init, send_command = send, get_heartbeats = get_heartbeats, print_workers = print_workers}