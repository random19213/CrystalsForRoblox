_G.CLIENT_NAME = "Crystals4Bedwars"

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

_G[_G.CLIENT_NAME] = {}

local Base64 = {}

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function Base64.decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

function fetchFileFromRawURL(path)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/main/%s", "random19213", "CrystalsForRoblox", path)
    local response = HttpService:RequestAsync({
        Url = url,
        Method = "GET"
    })

    if response.Success then
        return response.Body
    else
        error("Failed to fetch file from URL: " .. response.StatusCode)
    end
end

function fetchAllFiles(path)
    local files = {}
    local data = fetchGitHubContents(path)  -- You still need to call this to get the file structure

    for _, item in pairs(data) do
        if item.type == "file" then
            -- Use the raw URL to fetch the content directly
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

function createTextFilesFromFiles(files)
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

function runMainScript()
    print(_G[_G.CLIENT_NAME])
    local mainScriptText = _G[_G.CLIENT_NAME]["Main.lua"]
    if mainScriptText then
        loadstring(mainScriptText)()  -- Ensure to call the loaded function
    else
        error("Main.lua not found in the loaded files")
    end
end

function installPackage()
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
