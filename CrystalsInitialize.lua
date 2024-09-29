local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

function fetchAllFiles(path)
    local files = {}
    local data = fetchGitHubContents(path)

    for _, item in pairs(data) do
        if item.type == "file" then
            if item.content then
                local content = Base64.decode(item.content)
                files[item.path] = content
            else
                error("Content missing in file: " .. item.path)
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

function createScriptsFromFiles(files)
    for path, content in pairs(files) do
        local segments = path:split("/")
        local parent = ReplicatedStorage
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

        local moduleScript = Instance.new("ModuleScript")
        moduleScript.Name = segments[#segments]
        moduleScript.Source = content
        moduleScript.Parent = parent
    end
end

function runMainScript()
    local mainScript = ReplicatedStorage:FindFirstChild("src"):FindFirstChild("Main.client")
    if mainScript then
        local mainModule = require(mainScript)
        mainModule.run()
    else
        error("Main script not found!")
    end
end

function installPackage()
    local files = fetchAllFiles("src")
    if files then
        createScriptsFromFiles(files)
        runMainScript()
    else
        error("Failed to fetch package")
    end
end

installPackage()
