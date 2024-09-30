local Widget = _G._crystalRequire("Widget.lua")

local ImageLabel = {}
ImageLabel.__index = ImageLabel
setmetatable(ImageLabel, Widget)

function ImageLabel.new(image, options, context)
	local self = Widget.new(options, "ImageLabelTheme", context)
	setmetatable(self, ImageLabel)
	local Theme = self.Context.Theme
	
	local element = Instance.new("ImageLabel")

	if self.Options.Child ~= nil then
		self.Options.Child.Parent = element
	end

	self:SetBaseGuiProperties(element)
	self:SetBaseGuiEvents(element)
	self:SetImageLabelGuiProperties(element)
	
	element.Image = image or options.Image
	
	return element
end

return ImageLabel
