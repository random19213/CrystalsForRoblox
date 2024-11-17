local MainModule = {}

function MainModule:Init()
   local UIHandler = _G._require("src/Modules/UI/UIHandler.lua")
   UIHandler:commit()
end

return MainModule