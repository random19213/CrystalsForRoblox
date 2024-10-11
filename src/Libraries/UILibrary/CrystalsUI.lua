local Players = game:GetService("Players")
local player = Players.LocalPlayer

local _table = {}
local _trees = {}

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

local CrystalsUI = {}

function CrystalsUI.CreateTree(Name: string, behaviour)
	if _trees[Name] then
		for prop, value in behaviour do
			_trees[Name]._gui[prop] = value
		end
		
		return _trees[Name]
	end
	
	local Tree = TreeClass.new(Name)

	local self = setmetatable({}, {
		__newindex = function(_, key, value)
			if typeof(value) == "Instance" then
				local wrappedElement = CrystalsUI._element(value, Tree)
				Tree._elements[key] = wrappedElement
				value.Parent = Tree._gui
			elseif typeof(value) == "string" and pcall(function() Instance.new(value) end) then
				local newElement = Instance.new(value)
				newElement.Parent = Tree._gui
				Tree._elements[key] = CrystalsUI._element(newElement, Tree)
			elseif typeof(value) == "table" and value._isElement == true then
				value._instance.Parent = Tree._gui
				Tree._elements[key] = value
			else
				error(("Invalid element type provided for key '%s'. Expected an Instance or valid class string. Got: %s"):format(key, tostring(value)))
			end
		end,
		__index = function(_, key)
			return Tree._elements[key]
		end
	})
	
	for prop, value in behaviour do
		Tree._gui[prop] = value
	end
	
	_trees[Name] = Tree

	return self, Tree
end

function CrystalsUI.Element(class, properties)
	local newElement = Instance.new(class)

	properties = properties or {}

	for prop, value in pairs(properties) do
		newElement[prop] = value
	end

	local element = CrystalsUI._element(newElement, nil)
	element:AddState("InitState", function(instance, self, blacklist)
		for prop, value in (properties) do
			if blacklist[prop] == true then
				continue
			end
			instance[prop] = value
		end
	end)

	return element
end

function CrystalsUI.StateParams(whitelist: boolean, props: {[string] : any})
	return {
		_stateParams = true,
		_whitelist = whitelist or false,
		_properties = props,
	}
end

local elementCache = {}

function CrystalsUI._element(inst, tree)
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
		
		ChangeState = function(self, stateName, blacklist : {}?)
			blacklist = blacklist or {}
			print("Changing state to:", stateName)
			local state = self._states[stateName]
			if state then
				task.spawn(state, self._instance, self, blacklist)
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
				inst.MouseEnter:Connect(function()
					self:Trigger("hover:enter")
				end)
			elseif eventName == "hover:exit" and inst:IsA("GuiObject") then
				inst.MouseLeave:Connect(function()
					self:Trigger("hover:exit")
				end)
			elseif eventName == "mouse:down" and inst:IsA("GuiButton") then
				inst.MouseButton1Down:Connect(function()
					self:Trigger("mouse:down")
				end)
			elseif eventName == "mouse:up" and inst:IsA("GuiButton") then
				inst.MouseButton1Up:Connect(function()
					self:Trigger("mouse:up")
				end)
			elseif eventName == "clicked" and inst:IsA("GuiButton") then
				inst.MouseButton1Click:Connect(function()
					self:Trigger("clicked")
				end)
			end

			return self
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
			if self._isElement then
				if typeof(value) == "Instance" then
					value.Parent = self._instance
					local element = CrystalsUI._element(value, self._tree)
					if self._tree then
						self._tree._elements[key] = element
					end
				elseif typeof(value) == "table" and value._isElement == true then
					value._tree = self._tree
					value._instance.Parent = self._instance
					if self._tree then
						self._tree._elements[key] = value
					end
				elseif self._instance[key] ~= nil then
					self._instance[key] = value
				end
			else
				error("Attempt to modify a non-element instance.")
			end
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
