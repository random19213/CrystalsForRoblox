local UIHandler = {}

function UIHandler:Start()
    local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")
    local Notification = _G._crystalRequire("Notification.lua")

    _G._crystalTree, tree = CrystalsUI.CreateTree("Crystals4Bedwars", {
        Enabled = true,
        DisplayOrder = 99999,
        IgnoreGuiInset = true,
        ResetOnSpawn = false
    })
    
    _G._crystalTree.MainFrame = tree:Element("Frame", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
    
        BackgroundTransparency = 1,
    })
    
    local mainFrame = _G._crystalTree.MainFrame
    
    mainFrame.NotificationsFrame = tree:Element("Frame", {
        Size = UDim2.fromScale(0.15, 1),
        Position = UDim2.fromScale(1,0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        
        BackgroundTransparency = 1,
    })
    
    mainFrame.NotificationsFrame.UILIstLayout = tree:Element("UIListLayout", {
        Padding = UDim.new(0, 20),
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    mainFrame.NotificationsFrame.UIPadding = tree:Element("UIPadding", {
        PaddingBottom = UDim.new(0,5),
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5),
        PaddingTop = UDim.new(0, 5),
    })

    mainFrame.NotificationsFrame:InsertChildren({
		Notification("Crystals Started!")
	})
end

return UIHandler