local UIHandler = {}

function UIHandler.Init()
    print("ran")
    local uiFramework = _G._crystalRequire("CrystalsUI.lua")
    local app = uiFramework.new()
    app:RunApp {
        Name = "Crystals4Bedwars",
        Home = app.Container{
            Size = Udim2.fromScale(1,1),
            BackgroundTransparency = 0.5,
            Position = Udim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    }

    _G._crystalApp = app
end

return UIHandler