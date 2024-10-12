local TweenService = game:GetService("TweenService")

local UIHandler = {}

function UIHandler:Start()
    local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")

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

    self.Notify("Crystals", '<font color="rgb(46,80,131)">Initialization</font> was <font color="rgb(0, 255, 0)">successful</font>', "Success")
end

function UIHandler.Notify(title, description, duration, mode)
    local Notification = _G._crystalRequire("Notification.lua")

    local newNotification = Notification(title, description, mode)
    mainFrame.NotificationsFrame:InsertChildren({
		newNotification
	})


    local TweenTime = 0.5
	local pos = newNotification.Container._instance.Position
	local size = newNotification._instance.Size
	newNotification._instance.Size = UDim2.fromScale(1, 0)
	newNotification.Container._instance.Position = UDim2.fromScale(1.5, 0.5)
	TweenService:Create(newNotification.Container._instance, TweenInfo.new(TweenTime), {Position = pos}):Play()
	TweenService:Create(newNotification._instance, TweenInfo.new(TweenTime/2), {Size = size}):Play()
	TweenService:Create(newNotification.Container.Window.CooldownBar.BarFill._instance, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.fromScale(0, 1)}):Play()

	for _, instance in newNotification.Container._instance:GetDescendants() do
		if instance:IsA("ImageLabel") then
			local transp = instance.ImageTransparency
			instance.ImageTransparency = 1
			TweenService:Create(instance, TweenInfo.new(TweenTime), {ImageTransparency = transp}):Play()
		elseif instance:IsA("Frame") then
			local transp = instance.BackgroundTransparency    
			instance.BackgroundTransparency = 1
			TweenService:Create(instance, TweenInfo.new(TweenTime), {BackgroundTransparency = transp}):Play()
		elseif  instance:IsA("TextLabel") then
			local transp = instance.TextTransparency    
			instance.TextTransparency = 1
			TweenService:Create(instance, TweenInfo.new(TweenTime), {TextTransparency = transp}):Play()
		end
	end

	task.delay(duration, function()
		for _, instance in newNotification.Container._instance:GetDescendants() do
			if instance:IsA("ImageLabel") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {ImageTransparency = 1}):Play()
			elseif instance:IsA("Frame") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {BackgroundTransparency = 1}):Play()
			elseif  instance:IsA("TextLabel") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {TextTransparency = 1}):Play()
			end
		end
		
		task.wait(TweenTime)
		newNotification:Destroy()
	end)
end

return UIHandler