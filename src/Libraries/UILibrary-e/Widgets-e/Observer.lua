local Widget = _G._crystalRequire("Widget.lua")

local Observer = {}
Observer.__index = Observer
setmetatable(Observer, Widget)

function Observer.new(store, child, actions, e)
   local self = Widget.new(nil, nil, e.Context)
   setmetatable(self, Observer)

   self.Store = store
   self.Child = child
   self.e = e

   store:Listen(self, actions)

   return self
end

function Observer:Build()
   local tree = self:BuildTree(
    self.e.Container({
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Name = "_Observer",
        Child = self.Child()
    })
   )

   return tree
end

return Observer
