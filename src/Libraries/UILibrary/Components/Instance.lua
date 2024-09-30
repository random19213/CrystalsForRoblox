local instance = {}
instance.__index = instance

function instance.new(class) : uiObject
    local self = setmetatable({}, instance)
    print(class)
    return instance
end

return instance