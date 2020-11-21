--Turtle Library

local x, y, z
local bossid
local name

local function open()
    name = os.getComputerLabel() or os.getComputerID() .. ""
    rednet.host("workers",name)
    rednet.open("right")
    bossid = rednet.lookup("workers","boss")
    return bossid
end

local function close()

end

local function get_bossid()
    local id;
    
    for i=1,10 do
        id = rednet.lookup("boss","boss")
        if id ~= nil then
            return id
        end
        os.sleep(5)
    end
    return -1
end

local function init()
    open()
    x, y, z = gps.locate(5)
    if x == nil then
        do return -1 end
    end
    return 0
end

local function send(s)
    bossid = get_bossid()
    return rednet.send(bossid, s, "workers")
end

local function send_heartbeat()
    local msg
    x, y, z = gps.locate(5)
    msg = textutils.serialize({x,y,z})
    bossid = get_bossid()
    rednet.send(bossid,msg, "heartbeat")
    return x, y, z
end

local function take_orders()
    local sender, msg, protocol = rednet.receive("workers")
    if msg == "close" then
        close()
    else
        shell.run(msg);
    end
    return msg
end

return {open = open, close = close, init = init, send = send, send_heartbeat = send_heartbeat, take_orders = take_orders}