local MainModule = {}
local RequiredModules = {}

function MainModule.Initiate()
    _G._crystalRequire = function(name)
        return RequiredModules[name]
    end

    -- require
    for i, NameSource in (_G._crmodules) do
        local name = NameSource.Name
        local source = NameSource.Source

        _G._initLabel.Text = "Requiring: "..name
        RequiredModules[name] = loadstring(source)()
        _G._initLabel.Text = "Successfully Required: "..name .. " "..#RequiredModules.."/"..#_G._crmodules
    end

    -- init
    for name, module in RequiredModules do
        if type(module) == "table" and module.Init then
            _G._initLabel.Text = "Initializing: "..name
            module:Init()
        end
    end

    -- start
    for name, module in RequiredModules do
        if type(module) == "table" and module.Start then
            _G._initLabel.Text = "Starting: "..name
            module:Start()
        end
    end

    _G._initLabel.Parent:Destroy()

    -- done
end

return MainModule