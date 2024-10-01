local e = _G._crystalRequire("CrystalsUI.lua")
local Widget = require("Widget.lua")

local InitLabel = {}
InitLabel.__index = InitLabel
setmetatable(InitLabel, Widget)

function InitLabel.new(context, color)
	local self = Widget.new(nil, nil, context)
	setmetatable(self, InitLabel)
	
	self.CurrentScript = "Initializing Crystals.."
	
	return self
end

function InitLabel:Build()
	return self:BuildTree(
		e.TextButton(self.CurrentScript, { 
			Size = UDim2.fromScale(1, 0.2),
		    AnchorPoint = Vector2.new(0.5, 0),
	    	Position = UDim2.fromScale(0.5, 0),
		
		    BackgroundTransparency = 1,
		    TextColor3 = Color3.fromRGB(255,255, 255),
		    TextScaled = true,
	        UIStroke = {
		    	Thickness = 4
		    },

            OnClick = function ()
                self:SetState(function ()
                    self.CurrentScript = "random script running"
                end)
            end
		})
	)
end

return InitLabel
