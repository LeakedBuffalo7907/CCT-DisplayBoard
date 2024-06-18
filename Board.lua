

local args = {...}
local board = {}
-- dont forget 1 padding
local gcx = 1; --global cursor pos

local baseRepoURL = "http://raw.githubusercontent.com/LeakedBuffalo7907/CCT-DisplayBoard/main"
local screen = peripheral.find("monitor")

board.run = function (arguments)
    --local x, y = term.getSize()
    --term.write(tostring(x) .. "\n")
    --term.write(tostring(y) .. "\n")

    --local handle = io.open("./Config.json", "r")

    ---local rawJson = handle:read("*a")

    --local jsonParse = textutils.unserialiseJSON(rawJson)
    --term.write(jsonParse.message .. "\n")

    --handle:close()

    while true do
        --screen.clear()
        local cx,cy = term.getCursorPos()
        screen.setCursorPos(gcx+1, cy)
        screen.write("Test")
        screen.setCursorPos(gcx+1, cy)
        sleep(1)
    end

    
end

board.update = function (arguments)
    if fs.exists("/version.txt") then
        local webversion = http.get(baseRepoURL .. "/version.txt")
        local currentVersion = webversion.readAll()
        webversion.close()
        local F = fs.open("/version.txt", "r")
        LocalVersion = F.readAll()
        F.close()
        if currentVersion > LocalVersion or arguments[0] == "force" then
            term.setTextColor(colors.red)
            print("Display Board is out of date!")
            print("Updating now!")
            shell.run("wget run " .. baseRepoURL .. "/installer.lua")
        else 
            term.setTextColor(colors.green)
            print("Display Board is up to date!")
            term.setTextColor(colors.white)
        end
    end
end
  
command = table.remove(args, 1)
  
if board[command] then
    board[command](args)
end
