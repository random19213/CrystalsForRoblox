local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local CrystalsUI = _G._require("src/Libraries/UILibrary/CrystalsUI.lua")

local function createGrip(side, data)
	local grip = Instance.new("Frame")
	grip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	grip.BackgroundTransparency = 0.5
	grip.BorderSizePixel = 0
	grip.Name = side
	grip.Visible = true

	if side == "Top" then
		grip.AnchorPoint = Vector2.new(0.5, 1)
		grip.Position = UDim2.fromScale(0.5, 0)
		grip.Size = UDim2.new(1, 0, 0, data.Size)
	elseif side == "Bottom" then
		grip.AnchorPoint = Vector2.new(0.5, 0)
		grip.Position = UDim2.fromScale(0.5, 1)
		grip.Size = UDim2.new(1, 0, 0, data.Size)
	elseif side == "Left" then
		grip.AnchorPoint = Vector2.new(1, 0.5)
		grip.Position = UDim2.fromScale(0, 0.5)
		grip.Size = UDim2.new(0, data.Size, 1, 0)
	elseif side == "Right" then
		grip.AnchorPoint = Vector2.new(0, 0.5)
		grip.Position = UDim2.fromScale(1, 0.5)
		grip.Size = UDim2.new(0, data.Size, 1, 0)
	end

	return grip
end

return function(properties)
	local DragData = properties.DragData; properties.DragData = nil
	local GripData = properties.GripData; properties.GripData = nil
	
	local defaultProperties = {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(200, 50),
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		BorderSizePixel = 0
	}
	
	for name, value in properties do
		defaultProperties[name] = value
	end

	local proxy, tree = CrystalsUI.CreateTree("Crystals4Bedwars")
	local Widget = tree:Element("Frame", defaultProperties)
	
	if DragData and DragData.Relatives then
		table.insert(DragData.Relatives, Widget)
	end
	
	local WidgetDragging = false
	local dragInput, mousePos, framePos, frameSize
	local WidgetResizing = false
	local resizeDir = nil
	local updatingPos, updatingSize

	if DragData and DragData.Enabled then
		Widget.InputBegan:Connect(function(input)
			task.defer(function()
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					WidgetDragging = true
					mousePos = UserInputService:GetMouseLocation()
					framePos = {}
					
					for _, relativeWidget in DragData.Relatives do
						framePos[relativeWidget] = relativeWidget.Position
					end
					
					Widget:Trigger("drag:began")
					
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							WidgetDragging = false
							Widget:Trigger("drag:end")
						end
					end)
				end
			end)
		end)

		Widget.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)
	end

	local currentExtendForSide
	
	--[[
	if GripData then
		
		for side, sideData in GripData do
			local grip = createGrip(side, sideData)
			grip.Parent = Widget._instance
			
			local extend = sideData.Extend or 0
			local negativeExtend = sideData.NegativeExtend or 0

			grip.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					WidgetResizing = true
					resizeDir = side
					mousePos = UserInputService:GetMouseLocation()
					framePos = Widget.Position
					frameSize = Widget.Size
					
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							WidgetResizing = false
							resizeDir = nil
						end
					end)
				end
			end)

			grip.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					dragInput = input
				end
			end)
		end
	end]]
	
	
	if GripData or (DragData and DragData.Enabled) then
		currentExtendForSide = {
			Right = 0,
			Left = 0,
			Top = 0,
			Bottom = 0,
		}

		local previousMousePos = UserInputService:GetMouseLocation()

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput then
				local currentMousePos = UserInputService:GetMouseLocation()
				if not previousMousePos or not currentMousePos then return end
				
				local delta = currentMousePos - previousMousePos
				
				if WidgetDragging then	
					local positionDelta = currentMousePos - mousePos
					local relatives = DragData.Relatives
					
					for _, relative in relatives do
						for i, _relative in relatives do
							if _relative._instance:IsDescendantOf(relative._instance) then
								table.remove(relatives, i)
							end
						end
					end
					
					for _, relative in DragData.Relatives do
						local pos = UDim2.new(framePos[relative].X.Scale, framePos[relative].X.Offset + positionDelta.X, framePos[relative].Y.Scale, framePos[relative].Y.Offset + positionDelta.Y)
						TweenService:Create(relative._instance, TweenInfo.new(.1), {Position = pos}):Play()
					end
				end	
			--[[
			elseif WidgetResizing then
					local newSize = frameSize
					local newPos = framePos
					local savedDelta = delta

					local sideData = GripData[resizeDir]
					local extend = sideData.Extend
					local negativeExtend = sideData.NegativeExtend
					if resizeDir == "Right" then
						currentExtendForSide.Right += delta.X

						if currentExtendForSide.Right > negativeExtend then
							currentExtendForSide.Right = negativeExtend
						elseif currentExtendForSide.Right < -extend then
							currentExtendForSide.Right = -extend
						end

						local range = negativeExtend - (-extend)
						local normalizedValue = (currentExtendForSide.Right - (-extend)) / range

						if normalizedValue > 1 then normalizedValue = 1 elseif normalizedValue < 0 then normalizedValue = 0 end

						local minSize = defaultProperties.Size.X.Offset - extend
						local maxSize = defaultProperties.Size.X.Offset + negativeExtend
						local newSizeValue = minSize + (maxSize - minSize) * normalizedValue

						local sizeChange = newSizeValue - frameSize.X.Offset
						local positionOffset = sizeChange / 2 

						newSize = UDim2.new(frameSize.X.Scale, newSizeValue, frameSize.Y.Scale, frameSize.Y.Offset)
						newPos = UDim2.new(framePos.X.Scale, framePos.X.Offset + positionOffset, framePos.Y.Scale, framePos.Y.Offset)

					elseif resizeDir == "Left" then
						currentExtendForSide.Left += delta.X

						if currentExtendForSide.Left < -negativeExtend then
							currentExtendForSide.Left = -negativeExtend
						elseif currentExtendForSide.Left > extend then
							currentExtendForSide.Left = extend
						end
						
						local range = extend - -negativeExtend
						local normalizedValue = (currentExtendForSide.Left - (-negativeExtend)) / range

						if normalizedValue > 1 then normalizedValue = 1 elseif normalizedValue < 0 then normalizedValue = 0 end

						local minSize = defaultProperties.Size.X.Offset - negativeExtend
						local maxSize = defaultProperties.Size.X.Offset + extend
						local newSizeValue = minSize + (maxSize - minSize) * (1 - normalizedValue)  -- Inverted for left

						local sizeChange = newSizeValue - frameSize.X.Offset
						local positionOffset = -sizeChange / 2  -- Negative offset to keep the left side anchored

						newSize = UDim2.new(frameSize.X.Scale, newSizeValue, frameSize.Y.Scale, frameSize.Y.Offset)
						newPos = UDim2.new(framePos.X.Scale, framePos.X.Offset + positionOffset, framePos.Y.Scale, framePos.Y.Offset)
					end

					
					TweenService:Create(Widget._instance, TweenInfo.new(.1), {Size = newSize, Position = newPos}):Play()
				end]]
				
				previousMousePos = currentMousePos
			end
		end)
	end

	return Widget
end
