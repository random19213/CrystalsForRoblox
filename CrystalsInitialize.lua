_G.CLIENT_NAME = "Crystals4Bedwars"

local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

_G[_G.CLIENT_NAME] = {}

local function fetchFileFromRawURL(path)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/main/%s", "random19213", "CrystalsForRoblox", path)
    local s, r = pcall(game.HttpGet, game, url)

    if s then
        return r
    else
        error("Failed to fetch file from URL: " .. r)
    end
end

local function fetchAllFiles(directory)
    local files = {}

    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s", "random19213", "CrystalsForRoblox", directory)
    local s, r = pcall(game.HttpGet, game, url)

    if not s then
        error("Failed to fetch directory contents: " .. r)
    end

    local data = HttpService:JSONDecode(r)

    for _, item in pairs(data) do
        if item.type == "file" then
            local content = fetchFileFromRawURL(item.path)
            files[item.path] = content 
        elseif item.type == "dir" then

            local subFiles = fetchAllFiles(item.path)
            for subPath, content in pairs(subFiles) do
                files[subPath] = content  
            end
        end
    end

    return files
end

local function createTextFilesFromFiles(files)
    local parentFolder = Instance.new("Folder")
    parentFolder.Name = _G.CLIENT_NAME
    parentFolder.Parent = ReplicatedFirst

    for path, content in pairs(files) do
        local segments = path:split("/")
        local parent = parentFolder

        for i = 1, #segments - 1 do
            local segment = segments[i]
            local folder = parent:FindFirstChild(segment)
            if not folder then
                folder = Instance.new("Folder")
                folder.Name = segment
                folder.Parent = parent
            end
            parent = folder 
        end

        local textValue = Instance.new("StringValue")
        textValue.Name = segments[#segments]
        textValue.Value = content
        textValue.Parent = parent 

        _G[_G.CLIENT_NAME][textValue.Name] = textValue.Value
    end
end


local function runMainScript()
    print(_G[_G.CLIENT_NAME])
    local mainScriptText = _G[_G.CLIENT_NAME]["Main.lua"]
    if mainScriptText then
        loadstring(mainScriptText)() 
    else
        error("Main.lua not found in the loaded files")
    end
end

local function installPackage()
    local files = fetchAllFiles("src")
    if files then
        createTextFilesFromFiles(files)
        print("Package installed successfully!")
        runMainScript()
    else
        error("Failed to fetch package")
    end
end

installPackage()
