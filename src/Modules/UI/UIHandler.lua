local UIHandler = {}

function UIHandler:Start()
    local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")
    local Notification = _G._crystalRequire("Notification.lua")

    _G._crystalTree = CrystalsUI.CreateTree("Crystals4Bedwars", {
        Enabled = true,
        DisplayOrder = 99999,
        IgnoreGuiInset = true,
    })
    
    _G._crystalTree.MainFrame = CrystalsUI.Element("Frame", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
    
        BackgroundTransparency = 0.9,
    })
    
    local mainFrame = _G._crystalTree.MainFrame
    
    mainFrame.NotificationsFrame = CrystalsUI.Element("Frame", {
        Size = UDim2.fromScale(0.15, 1),
        Position = UDim2.fromScale(1,0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        
        BackgroundTransparency = 0.9,
    })
    
    mainFrame.NotificationsFrame.NotificationUILIstLayout = CrystalsUI.Element("UIListLayout", {
        Padding = UDim.new(0, 20),
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    mainFrame.NotificationsFrame.NotificationUIPadding = CrystalsUI.Element("UIPadding", {
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