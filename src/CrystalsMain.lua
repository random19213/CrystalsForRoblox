local MainModule = {}

function MainModule:Start()
   local UIHandler = _G._require("src/Modules/UI/UIHandler.lua")
   UIHandler:commit()
end

return MainModule