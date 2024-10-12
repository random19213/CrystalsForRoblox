local layoutOrder = 0

return function(text)
    local CrystalsUI = _G._crystalRequire("CrystalsUI.lua")
	layoutOrder += 1
	
	local notification = CrystalsUI.Element("TextLabel", {
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1,0,0,200),
		Text = text
	})
	
	return notification
end