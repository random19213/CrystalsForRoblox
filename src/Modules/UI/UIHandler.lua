local TweenService = game:GetService("TweenService")

local UIHandler = {}

function UIHandler:commit()
    local CrystalsUI = _G._require("src/Libraries/UILibrary/CrystalsUI.lua")
    local Widget = _G._require("src/Modules/UI/Components/Widget.lua")
    local StateManager = _G._require("src/StateManager.lua")
    local Input = _G._require("src/Modules/Input.lua")

    _G._crystalTree, tree = CrystalsUI.CreateTree("Crystals4Bedwars", {
        Enabled = true,
        DisplayOrder = 99999,
        IgnoreGuiInset = true,
        ResetOnSpawn = false
    })
    
    _G._crystalTree.MainFrame = tree:Element("Frame", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
    
        BackgroundTransparency = 1,
    })
    
    local mainFrame = _G._crystalTree.MainFrame
    
    mainFrame.NotificationsFrame = tree:Element("Frame", {
        Size = UDim2.fromScale(0.2, 1),
        Position = UDim2.fromScale(1,0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        
        BackgroundTransparency = 1,
    })
    
    mainFrame.NotificationsFrame.UILIstLayout = tree:Element("UIListLayout", {
        Padding = UDim.new(0.02, 0),
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    mainFrame.NotificationsFrame.UIPadding = tree:Element("UIPadding", {
        PaddingBottom = UDim.new(0.015,0),
        PaddingLeft = UDim.new(0.01, 0),
        PaddingRight = UDim.new(0.015, 0),
        PaddingTop = UDim.new(0.01, 0),
    })

    mainFrame.MainMenuWidget = Widget({
        Dragable = true,
        Size = UDim2.fromOffset(1000, 75),
        Position = UDim2.fromScale(0.5, 0.1),
        BackgroundColor3 = Color3.fromRGB(46,46,46),
        BorderColor3 = Color3.fromRGB(46,46,46),
        BorderSizePixel = 5,
        Visible = StateManager.UIEnabled
    })

    mainFrame.MainMenuWidget.UIStroke = tree:Element("UIStroke", {
        Thickness = 1,
        Transparency = 0,
        Color = Color3.fromRGB(130,203,255),
    })
    
    mainFrame.MainMenuWidget.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })

    mainFrame.MainMenuWidget.UIListLayout = tree:Element("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center
    })

    Input.Connect({"RightShift"}, function()
        StateManager.UIEnabled = not StateManager.UIEnabled        
        _G._crystalTree.MainFrame.MainMenuWidget.Visible = StateManager.UIEnabled
    end)

    self.Notify("Crystals", '<font color="rgb(102, 168, 255)">Initialization</font> Was <font color="rgb(0, 255, 0)">Successful!</font>', 15, "Success")
    self.Notify("Starting..", 'Press <font color="rgb(0, 255, 255)">RightShift</font> to open Menu', 15, "Info")
end

function UIHandler.Notify(title, description, duration, mode)
    local Notification = _G._require("src/Modules/UI/Components/Notification.lua")

    local newNotification = Notification(title, description, mode)
	_G._crystalTree.MainFrame.NotificationsFrame:InsertChildren({
		newNotification
	})
	
	newNotification:ChangeState("Show", {}, 0.4)
	newNotification:ChangeState("StartTimer", {}, duration)
	
	task.wait(0.4)
	
	local thread
	local conn
	
	thread = task.delay(duration, function()
		if conn then
			conn:Disconnect()
			conn = nil
		end

		newNotification:ChangeState("Hide", _, 0.2)
	end)
	
	conn = newNotification.Container.Window.HideButton:Connect("clicked", function()
		task.cancel(thread)
		thread = nil
		conn:Disconnect()
		conn = nil

		newNotification:ChangeState("Hide", _, 0.2)
	end)
end

return UIHandler