local MainModule = {}

function MainModule.Initiate()
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
    
    task.wait(5)
    
    _G[_G.CLIENT_NAME]["UILibrary.lua"].Instance("test instance")
end

return MainModule