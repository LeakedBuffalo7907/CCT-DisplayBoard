local baseRepoURL = "http://raw.githubusercontent.com/LeakedBuffalo7907/CCT-DisplayBoard/main"

local function downloadFile(path, name)
    local status = "Downloaded"
    if fs.exists(path .. name) then
        fs.delete(path .. name)
        status = "Updated"
    end
    local F = fs.open(path .. name, "w")
    F.write(http.get(baseRepoURL .. path .. name).readAll())
    F.close()
    term.setTextColor(colors.lime)
    print(name .. " " .. status)
    term.setTextColor(colors.white)
end

local function checkFile(path, name) 
    if not fs.exists(path .. name) then
        downloadFile(path, name)
    end
end

local uptodate = false
local webversion = http.get(baseRepoURL .. "/version.txt")
local currentVersion = webversion.readAll()
webversion.close()
local oldUser = fs.exists("/version.txt")

if oldUser then
    print("Old install detected, Reinstalling Now")
else
    print("Installing now")
end

downloadFile("/", "version.txt")
checkFile("/", "Config.json") --TODO: add config versions for legacy checks
downloadFile("/", "Board.lua")
downloadFile("/", "startup.lua")
term.setTextColor(colors.blue)
print("Display Board Installed " .. currentVersion)
term.setTextColor(colors.white)
return;