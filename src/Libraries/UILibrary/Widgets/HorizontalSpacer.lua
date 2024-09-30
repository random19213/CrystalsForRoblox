local Widget = _G._crystalRequire("Widget.lua")

local HorizontalSpacer = {}
HorizontalSpacer.__index = HorizontalSpacer
setmetatable(HorizontalSpacer, Widget)

function HorizontalSpacer.new(size, options, context)
	local self = Widget.new(options, "HorizontalSpacerTheme", context)
	setmetatable(self, HorizontalSpacer)
	local Theme = self.Theme
	
	local element = Instance.new("Frame")
	
	if self.Options.Child ~= nil then
		self.Options.Child.Parent = element
	end

	self:SetBaseGuiProperties(element)
	self:SetBaseGuiEvents(element)
	
	element.BackgroundTransparency = 1
	element.Size = UDim2.fromOffset(size, 0)
	
	return element
end

return HorizontalSpacer
