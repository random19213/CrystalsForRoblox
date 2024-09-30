local Widget = _G._crystalRequire("Widget.lua")

local VerticalSpacer = {}
VerticalSpacer.__index = VerticalSpacer
setmetatable(VerticalSpacer, Widget)

function VerticalSpacer.new(size, options, context)
	local self = Widget.new(options, "VerticalSpacerTheme", context)
	setmetatable(self, VerticalSpacer)
	local Theme = self.Theme
	
	local element = Instance.new("Frame")
	
	if self.Options.Child ~= nil then
		self.Options.Child.Parent = element
	end

	self:SetBaseGuiProperties(element)
	self:SetBaseGuiEvents(element)
	
	element.BackgroundTransparency = 1
	element.Size = UDim2.fromOffset(0, size)
	
	return element
end

return VerticalSpacer
