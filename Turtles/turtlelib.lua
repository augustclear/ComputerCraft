--Turtle Library

local name, command,direction, x, y, z
local bossid
local cardinal_directions = {[1] = "north", [2] = "east", [3] = "south", [4] = "west"}

local function open()
    name = os.getComputerLabel() or os.getComputerID() .. ""
    rednet.host("workers",name)
    rednet.open("right")
    bossid = rednet.lookup("workers","boss")
    return bossid
end

local function close()

end

local function get_location()
    x, y, z = gps.locate(5)
    return x,y,z
end

local function get_direction()
    local x1,y1,z1, x2, y2, z2
    for i=1,4 do
        if direction == nil then
            x1,y1,z1 = get_location()
            turtle.forward()
            x2,yz,z2 = get_location()
            turtle.back()

            if y2 > y1 then
                direction = 1
            elseif y2 < y1 then
                direction = 3
            elseif x2 > x1 then
                direction = 2
            elseif x2 < x1 then
                direction = 4
            end
        end
        turtle.turnRight()
    end
    return cardinal_directions[direction]
end

local function face_direction(d)
    if direction == nil then
        get_direction()
    end
    while cardinal_directions[direction] ~= d do
        turtle.turnRight()
    end
end

local function df()
    while turtle.detect() do
        turtle.dig()
    end
end

local function du()
    while turtle.detectUp() do
        turtle.digUp()
    end
end

local function dd()
    while turtle.detectDown() do
        turtle.digDown()
    end
end

local function mx(n)
    get_location()
    local gx = x + n
    if n > 0 then
        face_direction("east")
    elseif n < 0 then
        face_direction("west")
    end
    while x ~= gx do
        get_location()
        df()
        turtle.forward()
    end
end

local function my(n)
    get_location()
    local gy = y + n
    if n > 0 then
        face_direction("north")
    elseif n < 0 then
        face_direction("south")
    end
    while y ~= gy do
        get_location()
        df()
        turtle.forward()
    end
end

local function mz(n)
    get_location()
    local gz = z + n
    while z ~= gz do
        get_location()
        if z < gz then
            du()
            turtle.up()
        elseif z > gz then
            dd()
            turtle.down()
        end
    end
end

local function go_to(gx, gy, gz)

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
    get_location()
    print(get_direction())
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
    get_location()
    msg = textutils.serialize({name = os.computerLabel(),command=command,x=x,y=y,z=z})
    bossid = get_bossid()
    rednet.send(bossid,msg, "heartbeat")
    return x, y, z
end

local function take_orders()
    local sender, msg, protocol = rednet.receive("workers")
    if msg == "close" then
        close()
    elseif msg == "reboot" then
        os.reboot()
    else
        shell.run(msg);
    end
    return msg
end

return {open = open, close = close, init = init, send = send, send_heartbeat = send_heartbeat, take_orders = take_orders, go_to = go_to}