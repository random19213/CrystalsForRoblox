local CrystalsUI = {}
CrystalsUI.__index = CrystalsUI

function CrystalsUI.Init()
	--# List of widgets with _G._crystalRequired module #--
	--# Module for Random ID generation #--
	local SystemID = _G._crystalRequire("id.lua")

	--# Module for rendering templates #--
	local Render = _G._crystalRequire("Render.lua")

	local Widgets = {
		Container = _G._crystalRequire("Container.lua"),
		TextButton = _G._crystalRequire("TextButton.lua"),
		TextLabel = _G._crystalRequire("TextLabel.lua"),
		Column = _G._crystalRequire("Column.lua"),
		Form = _G._crystalRequire("Form.lua"),
		TextFormField = _G._crystalRequire("TextFormField.lua"),
		GridBuilder = _G._crystalRequire("GridBuilder.lua"),
		ImageButton = _G._crystalRequire("ImageButton.lua"),
		ImageLabel = _G._crystalRequire("ImageLabel.lua"),
		ListBuilder = _G._crystalRequire("ListBuilder.lua"),
		Row = _G._crystalRequire("Row.lua"),
		ScrollContainer = _G._crystalRequire("ScrollContainer.lua"),
		TextBox = _G._crystalRequire("TextBox.lua"),
		Stack = _G._crystalRequire("Stack.lua"),
		PageLayout = _G._crystalRequire("PageLayout.lua"),
		VerticalSpacer = _G._crystalRequire("VerticalSpacer.lua"),
		HorizontalSpacer = _G._crystalRequire("HorizontalSpacer.lua"),
		Viewport = _G._crystalRequire("Viewport.lua"),
		Observer = _G._crystalRequire("Observer.lua")
	}

	--- CrystalsUI constructor
	function CrystalsUI.new()
		local self = {}
		setmetatable(self, CrystalsUI)

		--# Context dictionnary creation #--
		
		self.Context = {}
		self.Context.Widgets = {}
		self.Context.Player = game.Players.LocalPlayer
		self.Context.DefaultTheme = _G._crystalRequire("DefaultTheme.lua")
		self.Context.Injections = {}
		self.Context.Uses = {}
		self.Context.TemplatesFolder = nil

		--# Components constructor #--

		function CrystalsUI.Container(options) return Widgets["Container"].new(options, self.Context) end
		function CrystalsUI.TextButton(text, options) return Widgets["TextButton"].new(text, options, self.Context) end
		function CrystalsUI.TextLabel(text, options) return Widgets["TextLabel"].new(text, options, self.Context) end
		function CrystalsUI.Column(options) return Widgets["Column"].new(options, self.Context) end
		function CrystalsUI.Form(formKey, options) return Widgets["Form"].new(formKey, options, self.Context) end
		function CrystalsUI.TextFormField(formKey, options) return Widgets["TextFormField"].new(formKey, options, self.Context) end
		function CrystalsUI.GridBuilder(itemCount, builder, options) return Widgets["GridBuilder"].new(itemCount, builder, options, self.Context) end
		function CrystalsUI.ImageButton(image, options) return Widgets["ImageButton"].new(image, options, self.Context) end
		function CrystalsUI.ImageLabel(image, options) return Widgets["ImageLabel"].new(image, options, self.Context) end
		function CrystalsUI.ListBuilder(itemCount, builder, options) return Widgets["ListBuilder"].new(itemCount, builder, options, self.Context) end
		function CrystalsUI.Row(options) return Widgets["Row"].new(options, self.Context) end
		function CrystalsUI.ScrollContainer(options) return Widgets["ScrollContainer"].new(options, self.Context) end
		function CrystalsUI.TextBox(options) return Widgets["TextBox"].new(options, self.Context) end
		function CrystalsUI.Stack(options) return Widgets["Stack"].new(options, self.Context) end
		function CrystalsUI.PageLayout(options) return Widgets["PageLayout"].new(options, self.Context) end
		function CrystalsUI.VerticalSpacer(size, options) return Widgets["VerticalSpacer"].new(size, options, self.Context) end
		function CrystalsUI.HorizontalSpacer(size, options) return Widgets["HorizontalSpacer"].new(size, options, self.Context) end
		function CrystalsUI.Viewport(options) return Widgets["Viewport"].new(options, self.Context) end
		function CrystalsUI.Render(templateName, builder) return Render(templateName, self.TemplatesFolder, builder) end
		function CrystalsUI.Observer(store, actions, widgetTree) return Widgets["Observer"].new(store, widgetTree, actions, self):Build() end
		
		return self
	end

	function CrystalsUI:Use(obj)
		obj.Context = self.Context
		self.Context.Uses[obj.Name] = obj
		return self
	end

	function CrystalsUI:SetTemplatesFolder(folder)
		self.TemplatesFolder = folder
	end

	--- Creates a ScreenGui with the provided options.
	---@param options any
	function CrystalsUI:RunApp(options)
		local context = self.Context
		local player = game.Players.LocalPlayer
		local output = options.Output or player.PlayerGui
		local name = options.Name or "CrystalsUIApp"
		
		if context.Theme == nil then
			context.Theme = {}
		end
		
		-- If there's a sussy imposter DESTROY HIM
		if output:FindFirstChild(name) then
			output:FindFirstChild(name):Destroy()
		end
		
		local screenGui = Instance.new(options.GUIType or "ScreenGui", output)
		screenGui.ResetOnSpawn = false
		screenGui.Name = name
		screenGui:SetAttribute("CrystalsUIId", SystemID.randomString(12))
		context.GUI = screenGui
		
		if options.Face then
			screenGui.Face = options.Face
		end
		
		-- Put the Home widget provided in the ScreenGui
		if options.Home then
			options.Home.Parent = screenGui
			context.RunApp = CrystalsUI.RunApp
		else
			error("App does not have any home widget!")
		end
	end

	--- Get an element in the current ScreenGui by it's name.
	--- Not the best practice, but it's here if you have no other choices.
	---@param name string
	function CrystalsUI:GetElementByName(name, context)
		if context == nil then
			context = self.Context
		end
		local descendants = context.GUI:GetDescendants()
		
		for index, descendant in pairs(descendants) do
			if descendant.Name == name then
				return descendant
			end
		end
		
		return nil
	end

	--- Get an element in the current ScreenGui by it's CrystalsUIId.
	--- Not the best practice, but it's here if you have no other choices.
	---@param id string
	function CrystalsUI:GetElementById(id)
		local descendants = self.Context.GUI:GetDescendants()

		for index, descendant in pairs(descendants) do
			if descendant:GetAttribute("CrystalsUIId") == id then
				return descendant
			end
		end

		return nil
	end
end

return CrystalsUI
