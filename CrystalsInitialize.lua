if (game:IsLoaded() == false) then game.Loaded:Wait() end

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Base64 = {}

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function Base64.encode(data)
	return ((data:gsub('.', function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
	if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

function Base64.decode(data)
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

function fetchModuleScriptFromGitHub(path)
    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s", "random19213", "CrystalsForRoblox", path)
    local response = HttpService:RequestAsync({
        Url = url,
        Method = "GET"
    })

    if response.Success then
        local data = HttpService:JSONDecode(response.Body)
        if data.content then
            local decodedContent = Base64.decode(data.content)
            return decodedContent
        else
            error("Content not found in the response")
        end
    else
        error("Failed to fetch content from GitHub: " .. response.StatusCode)
    end
end

function createModuleScript(name, content)
    local moduleScript = Instance.new("ModuleScript")
    moduleScript.Name = name
    moduleScript.Source = content
    moduleScript.Parent = ReplicatedStorage
    return moduleScript
end

function installPackage(path)
    local content = fetchModuleScriptFromGitHub(path)
    if content then
        createModuleScript("MyModuleScript", content)
        print("ModuleScript installed successfully!")
    else
        error("Failed to fetch ModuleScript content")
    end
end