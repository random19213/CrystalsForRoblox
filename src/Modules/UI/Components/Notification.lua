local TweenService = game:GetService("TweenService")
local layoutOrder = 0

return function(Title, Description, Mode)
	local CrystalsUI = _G._crystalRequire("src/Libraries/UILibrary/CrystalsUI.lua")
	local Textures = _G._crystalRequire("src/Modules/Textures.lua")

	local Modes = {
		["Success"] = {
			Color = Color3.fromRGB(83, 101, 131),
			Icon = Textures.SuccessIcon
		},
		["Error"] = {
			Color = Color3.fromRGB(214, 76, 76),
			Icon = Textures.ErrorIcon,
		},
		["Info"] = {
			Color = Color3.fromRGB(97, 81, 0),
			Icon = Textures.InfoIcon
		}
	}

	local proxy, tree = CrystalsUI.CreateTree("Crystals4Bedwars")
	
	layoutOrder += 1
	
	local Notification = tree:Element("Frame", {
		LayoutOrder = layoutOrder,
		Size = UDim2.new(0.899,0,0.116,0),
		BackgroundTransparency = 1,
	})
	
	Notification.UIAspectRatioConstraint = tree:Element("UIAspectRatioConstraint", {
		AspectRatio = 2.606,
		AspectType = Enum.AspectType.FitWithinMaxSize,
		DominantAxis = Enum.DominantAxis.Width
	})
	
	Notification.Container = tree:Element("Frame", {
		Size = UDim2.new(1,0,1.124,0),
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
	})
	
	Notification.Container.Shadow = tree:Element("ImageLabel", {
		Size = UDim2.new(1.076,0,1.094,0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.6),
		
		Image = Textures.NotificationShadow,
		ImageColor3 = Color3.fromRGB(0,0,0),
		ScaleType = Enum.ScaleType.Fit,
		
		BackgroundTransparency = 1,
		ImageTransparency = 0.5,
	})
	
	Notification.Container.Window = tree:Element("Frame", {
		Size = UDim2.new(1,-3,1,-3),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundTransparency = 0.3,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	})
	
	Notification.Container.Window.UICorner = tree:Element("UICorner", {
		CornerRadius = UDim.new(0.06, 0),
	})
	
	Notification.Container.Window.HideButton = tree:Element("ImageButton", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1,1),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 99,
	})
	
	Notification.Container.Window.ColoredGradient = tree:Element("Frame", {
		BackgroundColor3 = Modes[Mode].Color,
		BackgroundTransparency = 0.7,
		
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5,0),
		Size = UDim2.fromScale(1,0.5),
	})
	
	Notification.Container.Window.ColoredGradient.UICorner = tree:Element("UICorner", {
		CornerRadius = UDim.new(0.12, 0)
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
		Position = UDim2.fromScale(1, 0.06),
		Size = UDim2.fromScale(0.8, 0.3),
		FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
		Text = Title,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})
	
	Notification.Container.Window.NotificationIcon = tree:Element("ImageLabel", {
		AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.09, 0.22),
		Size = UDim2.fromScale(0.195, 0.303),
		
		Image = Modes[Mode].Icon,
		ScaleType = Enum.ScaleType.Fit
	})
	
	Notification.Container.Window.NotificationIcon.UIAspectRatioConstraint = tree:Element("UIAspectRatioConstraint", {
		AspectRatio = 1,
		AspectType = Enum.AspectType.FitWithinMaxSize,
		DominantAxis = Enum.DominantAxis.Width
	})
	
	Notification.Container.Window.TextDescription = tree:Element("TextLabel", {
		AnchorPoint = Vector2.new(0.5,0),
		Position = UDim2.fromScale(0.5, 0.391),
		Size = UDim2.new(0.9, 0, 0.409, 0),
		
		BackgroundTransparency = 1,
		FontFace = Font.fromName("SourceSansPro"),
		Text = Description,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextScaled = true,
		TextTransparency = 0.1,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Center
	})
	
	Notification.Container.Window.CooldownBar = tree:Element("Frame", {
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.96),
		Size = UDim2.fromScale(0.95, 0.07),
	})
	
	Notification.Container.Window.CooldownBar.BarFill = tree:Element("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromScale(1,1)
	})
	
	Notification.Container.Window.CooldownBar.BarFill.UICorner = tree:Element("UICorner", {
		CornerRadius = UDim.new(1,0)
	})
	
	Notification.Container.Window.TextDescription.UITextSizeConstraint = tree:Element("UITextSizeConstraint", {
		MaxTextSize = 30,
		MinTextSize = 1,
	})
	
	Notification:AddState("Show", function(_, _, _, TweenTime)
		local pos = Notification.Container._instance.Position
		local size = Notification._instance.Size
		Notification._instance.Size = UDim2.fromScale(1, 0)
		Notification.Container._instance.Position = UDim2.fromScale(1.5, 0.5)
		TweenService:Create(Notification.Container._instance, TweenInfo.new(TweenTime), {Position = pos}):Play()
		TweenService:Create(Notification._instance, TweenInfo.new(TweenTime/2), {Size = size}):Play()
		
		for _, instance in Notification.Container._instance:GetDescendants() do
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
	end)
	
	Notification:AddState("StartTimer", function(_, _, _, duration)
		TweenService:Create(Notification.Container.Window.CooldownBar.BarFill._instance, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.fromScale(0, 1)}):Play()
	end)
	
	Notification:AddState("Hide", function(_, _, _, TweenTime)
		for _, instance in Notification.Container._instance:GetDescendants() do
			if instance:IsA("ImageLabel") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {ImageTransparency = 1}):Play()
			elseif instance:IsA("Frame") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {BackgroundTransparency = 1}):Play()
			elseif  instance:IsA("TextLabel") then
				TweenService:Create(instance, TweenInfo.new(TweenTime), {TextTransparency = 1}):Play()
			end
		end
		
		TweenService:Create(Notification._instance, TweenInfo.new(TweenTime), {Size = UDim2.fromScale(1, 0)}):Play()

		task.wait(TweenTime)
		Notification:Destroy()
	end)
	
	return Notification
end