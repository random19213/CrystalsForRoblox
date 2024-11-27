local Players = game:GetService("Players")
local player = Players.LocalPlayer

local _table = {}
local _trees = {}

local CrystalsUI = {}

local TreeClass = {}
TreeClass.__index = TreeClass

function TreeClass.new(name)
	local self = setmetatable({}, TreeClass)
	self._gui = Instance.new("ScreenGui")
	self._gui.Name = name
	self._gui.Parent = player:WaitForChild("PlayerGui")
	self._elements = {}
	
	return self
end

function TreeClass:Element(class, properties)
	local newElement = Instance.new(class)

	properties = properties or {}

	local element = CrystalsUI._element(newElement, self)

	element:AddState("InitState", function(instance, _, blacklist)
		for prop, value in (properties) do
			if blacklist[prop] == true then
				continue
			end
			
			pcall(function()
				instance[prop] = value
			end)
		
		end
	end)

	element:ChangeState("InitState", {})

	return element
end


function CrystalsUI.CreateTree(Name: string, behaviour)
	behaviour = behaviour or {}
	if _trees[Name] then
		for prop, value in behaviour do
			_trees[Name].Tree._gui[prop] = value
		end

		return _trees[Name].Proxy, _trees[Name].Tree
	end

	local Tree = TreeClass.new(Name)

	local self = setmetatable({}, {
		__newindex = function(_, key, value)
			if typeof(value) == "table" and value._isElement == true then
				value._instance.Name = key
				value._instance.Parent = Tree._gui
				
				print("parenting")
				print(value._instance.Parent)
				
				Tree._elements[value._instance:GetFullName()] = value
			else
				error(("Invalid element type provided for key '%s'. Expected an Instance or valid class string. Got: %s"):format(key, tostring(value)))
			end
			
			
			print(Tree)
		end,
		__index = function(_, key)
			return Tree._elements[Tree._gui:GetFullName().."."..key]
		end
	})

	for prop, value in behaviour do
		Tree._gui[prop] = value
	end

	_trees[Name] = {
		Proxy = self,
		Tree = Tree
	}

	return self, Tree
end

local elementCache = {}

local function addChild(self, key, value)
    local element
    if self._isElement then
        if typeof(value) == "table" and value._isElement == true then
            value._tree = self._tree
			value._instance.Name = key
			value._instance.Parent = self._instance
			
			if value._instance:IsDescendantOf(player.PlayerGui) then
				self._tree._elements[self._instance:GetFullName().."."..key] = value
			end
        elseif self._instance[key] ~= nil then
            self._instance[key] = value
        end
    else
        error("Attempt to modify a non-element instance.")
	end
end

function CrystalsUI._element(inst, tree, parent)
	if typeof(inst) ~= "Instance" then
		error("Invalid element type provided. Expected an Instance.")
	end

	if elementCache[inst] then
		return elementCache[inst]
	end

	local states = {}
	local events = {}

	local newElement = setmetatable({
		_instance = inst,
		_states = states,
		_events = events, 
		_isElement = true,
		_tree = tree,
		
		InsertChildren = function(self, children)
			children = children or {}
			
			for name, value in children do
				if type(name) == "number" then
					name = tostring(newproxy())
				end
				addChild(self, name, value)
			end
		end,

		ChangeState = function(self, stateName, blacklist : {}?, ...)
			blacklist = blacklist or {}
			print("Changing state to:", stateName)
			local state = self._states[stateName]
			if state then
				task.spawn(state, self._instance, self, blacklist, ...)
			else
				warn("No state found for:", stateName)
			end
			return self
		end,

		AddState = function(self, stateName, stateFunc)
			self._states[stateName] = stateFunc
			return self
		end,

		Connect = function(self, eventName, callback)
			if not self._events[eventName] then
				self._events[eventName] = {}
			end
			table.insert(self._events[eventName], callback)

			if eventName == "hover:enter" and inst:IsA("GuiObject") then
				return inst.MouseEnter:Connect(function()
					self:Trigger("hover:enter")
				end)
			elseif eventName == "hover:exit" and inst:IsA("GuiObject") then
				return inst.MouseLeave:Connect(function()
					self:Trigger("hover:exit")
				end)
			elseif eventName == "mouse:down" and inst:IsA("GuiButton") then
				return inst.MouseButton1Down:Connect(function()
					self:Trigger("mouse:down")
				end)
			elseif eventName == "mouse:up" and inst:IsA("GuiButton") then
				return inst.MouseButton1Up:Connect(function()
					self:Trigger("mouse:up")
				end)
			elseif eventName == "clicked" and inst:IsA("GuiButton") then
				return inst.MouseButton1Click:Connect(function()
					self:Trigger("clicked")
				end)
			end
		end,

		Trigger = function(self, eventName, ...)
			if self._events[eventName] then
				for _, callback in pairs(self._events[eventName]) do
					task.spawn(callback, self._instance, self, ...)
				end
			end
		end
	}, {
		__newindex = function(self, key, value)
			if key == "_tree" then return end
			addChild(self, key, value)
		end,

		__index = function(self, key)
			if key == "_tree" then return end
			local child = self._instance:FindFirstChild(key)
			if child then
				return CrystalsUI._element(child, self._tree)
			elseif typeof(self._instance[key]) == "function" then
				return function(_, ...)
					return self._instance[key](self._instance, ...)
				end
			elseif self._instance[key] ~= nil then
				return self._instance[key]
			end
		end
	})

	elementCache[inst] = newElement

	return newElement
end


function _table.keys(t)
	local keys = {}
	for k in pairs(t) do
		table.insert(keys, k)
	end
	return keys
end

return CrystalsUI
