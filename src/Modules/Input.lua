local InputModule = {}

local UserInputService = game:GetService("UserInputService")

local inputConnections = {}
local modifierKeys = {Enum.KeyCode.LeftShift, Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.LeftAlt, Enum.KeyCode.RightAlt}

local function isModifierKey(keyCode)
	for _, modKey in ipairs(modifierKeys) do
		if keyCode == modKey then
			return true
		end
	end
	return false
end

function InputModule.Connect(inputs, callback)
	table.insert(inputConnections, {Inputs = inputs, Callback = callback})
end

function InputModule.WaitForInput()
	local activeModifiers = {}

	while true do
		local input = UserInputService.InputBegan:Wait()
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local keyCode = input.KeyCode
			if isModifierKey(keyCode) then
				table.insert(activeModifiers, keyCode.Name)
			else
				if #activeModifiers > 0 then
					table.insert(activeModifiers, keyCode.Name)
					return activeModifiers
				else
					return {keyCode.Name}
				end
			end
		end
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end

	for _, connection in ipairs(inputConnections) do
		local inputsMatched = true
		for _, requiredInput in ipairs(connection.Inputs) do
			if not UserInputService:IsKeyDown(Enum.KeyCode[requiredInput]) then
				inputsMatched = false
				break
			end
		end
		if inputsMatched then
			connection.Callback()
		end
	end
end)

return InputModule
