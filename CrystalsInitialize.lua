_G.CLIENT_NAME = "Crystals4Bedwars"

local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local CrModules = {}
local RequiredModules = {}

local function fetchFileFromRawURL(path)
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
        if item.type == "file" then
            local content = fetchFileFromRawURL(item.path)
            files[item.path] = content 

            local args = item.path:split("/")
            local name = args[#args]

            _G._initLabel.Text = "Fetching: "..name
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

        local name = segments[#segments]

        local _script = {Name = name, Source = content}
        table.insert(CrModules, 1, _script)
    end
end

local function installPackage()
    
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.DisplayOrder = 999
    gui.IgnoreGuiInset = true

    local initLabel = Instance.new("TextLabel", gui)
    initLabel.Size = UDim2.fromScale(1, 0.2)
    initLabel.AnchorPoint = Vector2.new(0.5, 0)
    initLabel.Position = UDim2.fromScale(0.5, 0)
    initLabel.BackgroundTransparency = 1
    initLabel.TextColor3 = Color3.fromRGB(255,255, 255)
    initLabel.TextScaled = true
    initLabel.Text = "Fetching ".._G.CLIENT_NAME.." Package"

    _G._initLabel = initLabel

    local files = fetchAllFiles("src")
    if files then
        createTextFilesFromFiles(files)
        print("Package installed successfully!")
        _G._initLabel.Text = "Package installed successfully!"

        _G._crystalRequire = function(name)
            return RequiredModules[name]
        end
    
        print("--- / Requiring / ---")
        for _, NameSource in CrModules do
            local name = NameSource.Name
            local source = NameSource.Source
    
            _G._initLabel.Text = "Requiring: "..name
            RequiredModules[name] = loadstring(source)()
            _G._initLabel.Text = "Successfully Required: "..name
            print(_G._initLabel.Text)
        end
    
        -- init
        print("--- / Initializing / ---")
        for name, module in RequiredModules do
            if type(module) == "table" and module.Init then
                _G._initLabel.Text = "Initializing: "..name
                print(_G._initLabel.Text)
                module:Init()
            end
        end
    
        -- start
        print("--- / Starting / ---")
        for name, module in RequiredModules do
            if type(module) == "table" and module.Start then
                _G._initLabel.Text = "Starting: "..name
                print(_G._initLabel.Text)
                module:Start()
            end
        end
    
        _G._initLabel.Parent:Destroy()
    else
         _G._initLabel.Text = "Failed to fetch package"
        error("Failed to fetch package")
    end
end

installPackage()
