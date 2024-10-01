local MainModule = {}
local LoadedFirst = {}
local StartedInitializing = false

function MainModule.Initiate()
    _G._crystalRequire = function(name)
        if not _G[_G.CLIENT_NAME][name] then
            local queuedScript = _G[_G.CLIENT_NAME.."queue"][name]
            if queuedScript then
                local scriptFunction = loadstring(queuedScript)
                if scriptFunction then
                    _G[_G.CLIENT_NAME][name] = scriptFunction()
                    _G[_G.CLIENT_NAME.."queue"][name] = nil
                    if StartedInitializing == false then
                        LoadedFirst[name] = true
                    else
                        LoadedFirst[name] = nil
                    end
                else
                    warn("No loadstring function for ", name)
                end
            else
                error("Script '" .. name .. "' not found in both active and queue")
            end
        end

        return _G[_G.CLIENT_NAME][name]
    end

    print(StartedInitializing)
    local uiFramework = _G._crystalRequire("CrystalsUI.lua")
    local e = uiFramework.new()
    e:RunApp {
        Name = "Crystals4Bedwars",
	    Home = e.TextLabel("Hello world"),
    }

    print(StartedInitializing)

    -- require
    StartedInitializing = true
    local s, e = pcall(function()
        for name, content in pairs(_G[_G.CLIENT_NAME]) do
            print("Loading script:", name, "Type:", type(content))
            if type(content) == "string" and LoadedFirst[name] == nil then
                _G[_G.CLIENT_NAME][name] = loadstring(content)()
            else
                print("Error: Expected string, got", type(content), "for script", name)
            end
        end
    end)

    print(StartedInitializing)
    
    if s then
        print("Successfully required all modules")
    else
        print("There was a problem requiring a module", e)
        return
    end
    
    -- init
    for name, module in _G[_G.CLIENT_NAME] do
        if type(module) == "table" and module.Init then
            task.spawn(module.Init)
        end
    end

    -- done
end

return MainModule