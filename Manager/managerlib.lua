--Manager Library

local _x, _y, _z
local workerlist = {}

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
    workerlist.id = msg
    --term.write("[" .. id .. "]" .. msg)
end

local function get_workers()
    return workerlist
end

local function print_workers()
    textutils.tabulate(workerlist)
end

return {open = open, close = close, init = init, send_command = send, get_heartbeats = get_heartbeats, print_workers = print_workers}