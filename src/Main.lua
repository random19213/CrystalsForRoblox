local MainModule = {}

function MainModule.Initiate()
    _G._crystalRequire = function (name)
        return _G[_G.CLIENT_NAME][name]
    end

    -- require
    local s, e = pcall(function()
        for name, content in _G[_G.CLIENT_NAME] do
            _G[_G.CLIENT_NAME][name] = loadstring(content)()
        end
    end)
    
    if s then
        print("Successfully required all modules")
    else
        print("There was a problem requiring a module", e)
        return
    end
    
    -- init
    for name, module in _G[_G.CLIENT_NAME] do
        if module.Init == nil then
            continue
        end

        task.spawn(module.Init)
    end

    -- done
end

return MainModule