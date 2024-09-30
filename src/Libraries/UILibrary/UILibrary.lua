local instanceComponent = _G[_G.CLIENT_NAME]["Instance.lua"]

local UILibrary = {}

function UILibrary.Instance(class)
    return instanceComponent.new(class)
end

return UILibrary