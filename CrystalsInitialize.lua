local NAME = "Crystals4Bedwars"

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

_G[NAME] = {}

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

function fetchGitHubContents(path)
    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s", "random19213", "CrystalsForRoblox", path)
    local response = HttpService:RequestAsync({
        Url = url,
        Method = "GET"
    })

    if response.Success then
        return HttpService:JSONDecode(response.Body)
    else
        error("Failed to fetch from GitHub: " .. response.StatusCode)
    end
end

function fetchFileFromURL(url)
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
    local data = fetchGitHubContents(path)

    for _, item in pairs(data) do
        if item.type == "file" then
            if item.content then
                local content = Base64.decode(item.content)
                files[item.path] = content
            elseif item.download_url then
                local content = fetchFileFromURL(item.download_url)
                files[item.path] = content
            else
                error("No content or download URL found for file: " .. item.path)
            end
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
    parentFolder.Name = NAME
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

        local scriptFunction, loadError = loadstring(content)
        if scriptFunction then
            _G[NAME][textValue.Name] = task.spawn(scriptFunction)
        else
            error("Failed to load script: " .. textValue.Name .. " - Error: " .. loadError)
        end
    end
end

function runMainScript()
    local mainFolder = ReplicatedFirst:FindFirstChild(NAME):FindFirstChild("src")
    local mainScriptText = mainFolder:FindFirstChild("Main.lua").Value
    local mainScriptFunction = loadstring(mainScriptText)

    if mainScriptFunction then
        mainScriptFunction()
    else
        error("Failed to load and run the main script")
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
