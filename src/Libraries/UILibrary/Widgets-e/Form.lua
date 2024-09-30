local Widget = _G._crystalRequire("Widget.lua")
local Theme = _G._crystalRequire("DefaultTheme.lua")
local FormKeyModel = _G._crystalRequire("FormKey.lua")

local Form = {}
Form.__index = Form
setmetatable(Form, Widget)

function Form.new(formKey, options, context)
	local self = Widget.new(options, "FormTheme", context)
	setmetatable(self, Form)
	local Theme = self.Theme
	self.FormKey = formKey
	
	local element = Instance.new("Frame")

	if self.Options.Child ~= nil then
		self.Options.Child.Parent = element
	end

	self:SetBaseGuiProperties(element)
	self:SetBaseGuiEvents(element)
	
	return element
end

return Form
