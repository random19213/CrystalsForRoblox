print("Requiring Modules")


local s, e = pcall(function (...)
    for name, content in _G[_G.CLIENT_NAME] do
        _G[_G.CLIENT_NAME][name] = task.spawn(loadstring(content))
    end
end)

if s then
    print("Successfully required all modules")
else
    print("There was a problem requiring a module", e)
end
