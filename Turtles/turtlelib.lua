--Turtle Library

local name, command,direction, x, y, z
local bossid
local cardinal_directions = {[1] = "north", [2] = "east", [3] = "south", [4] = "west"}
local config = {home={x,y,z},fuel_stop={x,y,z}}

--[[
************************
**ORIENTATION FUNCTIONS*
************************
]]

local function get_location()
    x, y, z = gps.locate(5)
    return x,y,z
end

local function get_direction()
    local x1,y1,z1, x2, y2, z2
    while direction == nil do
        for i=1,4 do
            if direction == nil then
                x1,y1,z1 = get_location()
                turtle.forward()
                x2,y2,z2 = get_location()
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
    end
    return cardinal_directions[direction]
end

local function move_init()
    get_location()
    if direction == nil then
        get_direction()
    end
end

--[[
************************
****CONFIG FUNCTIONS****
************************
]]

local function write_config_value(key,value)
    config[key]=value
    local tmp = textutils.serialize(config)
    local f = io.open("config.lua","w")
    f:write(tmp)
    f:close()
end

local function read_config()
    local tmp
    local f = io.open("config.lua","r")
    if f ~= nil then
        tmp = f:read("*all")
        f:close()
        config = textutils.unserialize(tmp)
        return config
    end
end

local function read_config_value(key)
    local tmp
    local f = io.open("config.lua","r")
    if f ~= nil then
        tmp = f:read("*all")
        f:close()
        config = textutils.unserialize(tmp)
        return config[key]
    end
end

--[[
************************
****REDNET FUNCTIONS****
************************
]]

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

--[[
*******************************
*** BASIC MOVEMENT FUNCTIONS***
*******************************
]]

local function face_direction(d)
    if direction == nil then
        get_direction()
    end
    while cardinal_directions[direction] ~= d do
        turtle.turnRight()
        direction = direction + 1
        if direction == 5 then
            direction = 1
        end
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

local function dx(n)
    get_location()
    local gx = x + n
    if n > 0 then
        face_direction("east")
    elseif n < 0 then
        face_direction("west")
    end
    while x ~= gx do
        df()
        turtle.forward()
        get_location()
    end
end

local function dy(n)
    get_location()
    local gy = y + n
    if n > 0 then
        face_direction("north")
    elseif n < 0 then
        face_direction("south")
    end
    while y ~= gy do
        df()
        turtle.forward()
        get_location()
    end
end

local function dz(n)
    get_location()
    local gz = z + n
    while z ~= gz do
        if z < gz then
            du()
            turtle.up()
        elseif z > gz then
            dd()
            turtle.down()
        end
        get_location()
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
        turtle.forward()
        get_location()
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
        turtle.forward()
        get_location()
    end
end

local function mz(n)
    get_location()
    local gz = z + n
    while z ~= gz do
        if z < gz then
            turtle.up()
        elseif z > gz then
            turtle.down()
        end
        get_location()
    end
end

--[[
********************************
***COMPLEX MOVEMENT FUNCTIONS***
********************************
]]

local function go_to(gx, gy, gz)
    get_location()
    mz(gz-z)
    mx(gx-x)
    my(gy-y)
end

local function dig_to(gx gy, gz)
    get_location()
    dz(gz-z)
    dx(gx-x)
    dy(gy-y)
end

local function go_home()
    local ghome = read_config_value("home")
    if ghome == nil then
        print("I have no home :(")
    else
        go_to(ghome[1],ghome[2],ghome[3]+10)
        go_to(ghome[1],ghome[2],ghome[3])
    end
end

local function go_to_fuelstop()
    local gfuel = read_config_value("fuel_stop")
    if gfuel == nil then
        print("I have no fuel stop :(")
    else
        go_to(gfuel[1],gfuel[2],gfuel[3]+10)
        go_to(gfuel[1],gfuel[2],gfuel[3])
    end
end

return {
    open = open,
    close = close,
    send = send,
    send_heartbeat = send_heartbeat,
    take_orders = take_orders,
    go_to = go_to,
    dig_to = dig_to,
    go_home = go_home,
    go_to_fuelstop = go_to_fuelstop,
    write_config_value = write_config_value,
    read_config = read_config,
    read_config_value = read_config_value
    }