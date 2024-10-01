local UIHandler = {}

function UIHandler.Init()
    local CrystalsFramework = _G._crystalRequire("CrystalsUI.lua")
    local App = CrystalsFramework.new()

    App:RunApp({
        Name = "CrystalsUI",
        Home = App.Container(),
    })
end

return UIHandler