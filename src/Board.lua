local args = {...}
local board = {}
local screen = peripheral.find("monitor")
if not screen then
    error("No Monitor Attached")
end

local displayWidth,displayHeight = screen.getSize()
local Config = {}

function LoadConfig()

    local handle = io.open("./Config.json", "r")

    local rawJson = handle:read("*a")

    Config = textutils.unserialiseJSON(rawJson)

    handle:close()
end

board.run = function (arguments)
    LoadConfig()

    local finalMessage = Config.message.text

    while #finalMessage < displayWidth do
        finalMessage = finalMessage .. " "
    end
    
    local textLength = #finalMessage
    screen.setTextScale(2);

    while true do
        for i = 1, textLength do
            screen.clear()

            screen.setTextColor(Config.title.color)
            screen.setBackgroundColor(Config.backgroundColor)
            screen.setCursorPos((displayWidth / 2) - (#Config.title.text / 2), displayHeight / 3) + 1
            screen.write(Config.title.text)
            
            screen.setTextColor(Config.message.color)
            screen.setCursorPos(1, displayHeight / 2)
            local displayText = finalMessage:sub(i, textLength) .. finalMessage:sub(1, i - 1)
            screen.write(displayText:sub(1, displayWidth))
            sleep(Config.scrollTime)
        end
    end
end

board.update = function (arguments)
    if fs.exists("/version.txt") then
        local baseRepoURL = "http://raw.githubusercontent.com/LeakedBuffalo7907/CCT-DisplayBoard/main"

        local webversion = http.get(baseRepoURL .. "/src/version.txt")
        local currentVersion = webversion.readAll()
        webversion.close()
        local F = fs.open("/version.txt", "r")
        LocalVersion = F.readAll()
        F.close()
        if currentVersion > LocalVersion or arguments[1] == "force" then
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
