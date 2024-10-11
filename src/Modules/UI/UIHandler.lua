local UIHandler = {}

function UIHandler.Init()
    local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")
    _G._crystalTree = CrystalsUI.CreateTree("Crystals4Bedwars", {
        Enabled = true,
        DisplayOrder = 99999,
        IgnoreGuiInset = true,
    })

    _G._crystalTree.MainFrame = CrystalsUI.Element("Frame", {
        Size = Udim2.fromScale(1,1),
        Position = Udim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)

        BackgroundTransparency = 0.5
    })
end

return UIHandler