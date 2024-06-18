local baseRepoURL = "http://raw.githubusercontent.com/LeakedBuffalo7907/CCT-DisplayBoard/main"



local function downloadFile(source, path, name)
    local status = "Downloaded"
    if fs.exists(path .. name) then
        fs.delete(path .. name)
        status = "Updated"
    end
    local F = fs.open(path .. name, "w")
    F.write(http.get(baseRepoURL .. source .. "/" .. name).readAll())
    F.close()
    term.setTextColor(colors.lime)
    print(name .. " " .. status)
    term.setTextColor(colors.white)
end

local function checkFile(source, path, name) 
    if not fs.exists(path .. name) then
        downloadFile(source, path, name)
    end
end

local uptodate = false
local webversion = http.get(baseRepoURL .. "/src/version.txt")
local currentVersion = webversion.readAll()
webversion.close()
local oldUser = fs.exists("/version.txt")

if oldUser then
    print("Old install detected, Reinstalling Now")
else
    print("Installing now")
end

downloadFile("/src", "/", "version.txt")
checkFile("/src", "/", "Config.json") --TODO: add config versions for legacy checks
downloadFile("/src", "/", "Board.lua")
downloadFile("", "/", "startup.lua")
downloadFile("/src/libs", "/libs/", "utils.lua")
term.setTextColor(colors.blue)
print("Display Board Installed " .. currentVersion)
term.setTextColor(colors.white)
return;