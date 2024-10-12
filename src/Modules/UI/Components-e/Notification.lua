local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")

local Modes = {
	["Success"] = Color3.fromRGB(46,80,131),
	["Error"] = Color3.fromRGB(167, 33, 33)
}

local layoutOrder = 0

return function(Title, Description, Mode)
	
	local proxy, tree = CrystalsUI.CreateTree("Crystals4Bedwars")
	
	layoutOrder += 1
	
	local Notification = tree:Element("Frame", {
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1,0,0.15,0),
		BackgroundTransparency = 1,
	})
	
	Notification.Container = tree:Element("Frame", {
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
	})
	
	Notification.Container.Shadow = tree:Element("ImageLabel", {
		Size = UDim2.new(1,12,1,12),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		
		Image = "rbxassetid://13350795660",
		ImageColor3 = Color3.fromRGB(0,0,0),
		ScaleType = Enum.ScaleType.Slice,
		SliceScale = 1,
		SliceCenter = Rect.new(10,10,118,118),
		
		BackgroundTransparency = 1,
		ImageTransparency = 0.3,
	})
	
	Notification.Container.Window = tree:Element("Frame", {
		Size = UDim2.new(1,-3,1,-3),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	})
	
	Notification.Container.Window.UICorner = tree:Element("UICorner", {
		CornerRadius = UDim.new(0, 5)
	})
	
	Notification.Container.Window.ColoredGradient = tree:Element("Frame", {
		BackgroundColor3 = Modes[Mode],
		
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5,0),
		Size = UDim2.fromScale(1,0.5),
	})
	
	Notification.Container.Window.ColoredGradient.UICorner = tree:Element("UICorner", {
		CornerRadius = UDim.new(0, 5)
	})
	
	Notification.Container.Window.ColoredGradient.UIGradient = tree:Element("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	
	Notification.Container.Window.TextTitle = tree:Element("TextLabel", {
		AnchorPoint = Vector2.new(1,0),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1,0.02),
		Size = UDim2.fromScale(1, 0.3),
		FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
		Text = Title,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextScaled = true
	})
	
	Notification.Container.Window.TextDescription = tree:Element("TextLabel", {
		AnchorPoint = Vector2.new(1,1),
		Position = UDim2.fromScale(1,1),
		Size = UDim2.new(1, -3, 0.488, 0),
		
		BackgroundTransparency = 1,
		FontFace = Font.fromName("SourceSansPro"),
		Text = Description,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextScaled = true,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	Notification.Container.Window.TextDescription = tree:Element("UITextSizeConstraint", {
		MaxTextSize = 30,
		MinTextSize = 1,
	})
	
	return Notification
end