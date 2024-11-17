_G.CLIENT_NAME = "Crystals4Bedwars"

local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local CrModules = {}
local RequiredModules = {}

-- Check if a file exists
local function isfile(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil
end

local function fetchFileFromRawURL(path)
    if isfile(path) then
        return readfile(path)
    end

    local url = string.format("https://raw.githubusercontent.com/%s/%s/main/%s", "random19213", "CrystalsForRoblox", path)
    local s, r = pcall(game.HttpGet, game, url)

    if s then
        return r
    else
        _G._initLabel.Text = "Failed to fetch file from URL: " .. r
        task.delay(3, function ()
            _G._initLabel.Parent:Destroy()
        end)
        error("Failed to fetch file from URL: " .. r)
    end
end

local function fetchAllFiles(directory)
    local files = {}

    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s", "random19213", "CrystalsForRoblox", directory)
    local s, r = pcall(game.HttpGet, game, url)

    if not s then
        _G._initLabel.Text = "Failed to fetch directory contents: " .. r
        task.delay(3, function ()
            _G._initLabel.Parent:Destroy()
        end)
        error("Failed to fetch directory contents: " .. r)
    end

    local data = HttpService:JSONDecode(r)

    for _, item in pairs(data) do
        if item.path == nil then continue end
        local args = item.path:split("/")
        local name = args[#args]

        if item.type == "file" then
            _G._initLabel.Text = "Fetching: "..name
            local content = fetchFileFromRawURL(item.path)
            files[item.path] = content 
            
            writefile(_G.CLIENT_NAME.."/"..item.path, content)
        elseif item.type == "dir" then
            makefolder(_G.CLIENT_NAME.."/"..item.path)

            local subFiles = fetchAllFiles(item.path)
            for subPath, content in pairs(subFiles) do
                files[subPath] = content
            end
        end
    end

    return files
end

local function loadAndRequireFiles(files)
    for _, filePath in (files) do
        if filePath:match(".lua$") and filePath:match("src") then
            local source = readfile(filePath)

            _G._initLabel.Text = "Requiring: " .. filePath
            RequiredModules[filePath] = loadstring(source)()
            _G._initLabel.Text = "Successfully Required: " .. filePath
        end
    end
end

local function getFiles(path)
    local files = {}

    for i, filePath in listfiles(path) do
        local arguments = filePath:split("/")
        local fileName = arguments[#arguments]

        if fileName:match("%.") == nil then -- its a folder
            local subFiles = getFiles(filePath)
            for _, subFilePath in subFiles do
                table.insert(files, subFilePath)
            end
        else
            table.insert(files, filePath)
        end
    end

    return files
end

local function installPackage()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.DisplayOrder = 999
    gui.IgnoreGuiInset = true

    local initLabel = Instance.new("TextLabel", gui)
    initLabel.Size = UDim2.fromScale(1, 0.1)
    initLabel.AnchorPoint = Vector2.new(0.5, 0)
    initLabel.Position = UDim2.fromScale(0.5, 0.05)
    initLabel.BackgroundTransparency = 1
    initLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    initLabel.TextStrokeTransparency = 0
    initLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    initLabel.TextScaled = true
    initLabel.Text = "Fetching " .. _G.CLIENT_NAME .. " Package"

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    UITextSizeConstraint.MaxTextSize = 40
    UITextSizeConstraint.MinTextSize = 1
    UITextSizeConstraint.Parent = initLabel

    _G._initLabel = initLabel

    makefolder(_G.CLIENT_NAME)
    if isfile(_G.CLIENT_NAME.."/debug.txt") then
    else
        fetchAllFiles("")
    end

    local files = getFiles(_G.CLIENT_NAME)
    print(#files)
    if files then
        loadAndRequireFiles(files)

        _G._require = function(path)
            return RequiredModules["./".._G.CLIENT_NAME.."/"..path]
        end

        _G._initLabel.Text = "Package installed successfully!"
        for name, module in RequiredModules do
            if type(module) == "table" and module.Init then
                _G._initLabel.Text = "Initializing: " .. name
                module:Init()
            end
        end

        for name, module in RequiredModules do
            if type(module) == "table" and module.Start then
                _G._initLabel.Text = "Starting: " .. name
                task.spawn(module.Start, module)
            end
        end

        gui:Destroy()
    else
        _G._initLabel.Text = "Failed to fetch package"
        error("Failed to fetch package")
    end
end

installPackage()
