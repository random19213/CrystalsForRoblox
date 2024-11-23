local TweenService = game:GetService("TweenService")

local UIHandler = {}

function UIHandler:commit()
    local CrystalsUI = _G._require("src/Libraries/UILibrary/CrystalsUI.lua")
    local Widget = _G._require("src/Modules/UI/Components/Widget.lua")
    local StateManager = _G._require("src/StateManager.lua")
    local Input = _G._require("src/Modules/Input.lua")
    local Textures = _G._require("src/Modules/Textures.lua")

    local ACCENT_COLOR = Color3.fromRGB(11, 120, 250)

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
    
    _G._crystalTree.MainFrame.MainMenuWidget = Widget({
        Size = UDim2.fromOffset(1000, 50),
        Position = UDim2.fromScale(0.5, 0.1),
        BackgroundColor3 = Color3.fromRGB(7, 7, 18),
        Visible = StateManager.UIEnabled,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.UICorner = tree:Element("UICorner", {
        CornerRadius = UDim.new(0, 5)
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.UIStroke = tree:Element("UIStroke", {
        Thickness = 3,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.Shadow = tree:Element("ImageLabel", {
        Size = UDim2.new(1.01, 0, 1.2,0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.6),
    
        Image = Textures.Shadow,
        ImageColor3 = Color3.fromRGB(0,0,0),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = -1,
        
        BackgroundTransparency = 1,
        ImageTransparency = 0.5,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder = tree:Element("Folder")
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.UIListLayout = tree:Element("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab = tree:Element("Frame", {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 200, 1, 0),
        BorderSizePixel = 0,
        LayoutOrder = 0,
        BackgroundColor3 = ACCENT_COLOR
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.UIGradient = tree:Element("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.8),
            NumberSequenceKeypoint.new(1,1)
        }),
        Rotation = -90
    })
    
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.UIStroke = tree:Element("UIStroke", {
        Thickness = 2,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.CrystalsLogo = tree:Element("ImageLabel", {
        Image = Textures.CrystalsBackgroundLogo,
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 2,
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.1,
        ImageColor3 = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.CrystalsLabel = tree:Element("ImageLabel", {
        Size = UDim2.fromScale(0.8,0.8),
        Position = UDim2.fromScale(0.5, 0.53),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 3,
        BackgroundTransparency = 1,
        
        Image = Textures.CrystalsText,
        ScaleType = Enum.ScaleType.Fit
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.SettingsIcon = tree:Element("ImageButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -7, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        Image = Textures.Settings,
        ScaleType = Enum.ScaleType.Fit
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon = Widget({
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, -1, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        ZIndex = 2,
        DragData = {
            Enabled = true,
            Relatives = {
                _G._crystalTree.MainFrame.MainMenuWidget,
            }
        }
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon.ImageLabel = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 7, 0.5, 0),
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        Image = Textures.MoveHandle,
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.4,
        ZIndex = 3
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab = tree:Element("Frame", {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 200, 1, 0),
        BorderSizePixel = 0,
        LayoutOrder = -2,
        BackgroundColor3 = Color3.fromRGB(163, 184, 203)
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.ActivateButton = tree:Element("TextButton", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.UIGradient = tree:Element("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.8),
            NumberSequenceKeypoint.new(1,1)
        }),
        Rotation = -90
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.UIStroke = tree:Element("UIStroke", {
        Thickness = 2,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.Pattern = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = "rbxassetid://300134974",
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(30,30),
        ImageTransparency = 0.97,
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TextLabel = tree:Element("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(0.67, 0.5),
        BackgroundTransparency = 1,
        Text = "Combat",
        TextScaled = true,
        FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
        TextColor3 = Color3.new(1,1,1),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTransparency = 0.4,
        ZIndex = 2,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TabIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1,
        Image = Textures.CombatIcon,
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.4,
        ZIndex = 2
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.OpenIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -13, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        Image = Textures.ArrowDownIcon,
        ScaleType = Enum.ScaleType.Fit
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab = tree:Element("Frame", {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 200, 1, 0),
        BorderSizePixel = 0,
        LayoutOrder = -1,
        BackgroundColor3 = Color3.fromRGB(163, 184, 203)
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.ActivateButton = tree:Element("TextButton", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.UIGradient = tree:Element("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.8),
            NumberSequenceKeypoint.new(1,1)
        }),
        Rotation = -90
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.UIStroke = tree:Element("UIStroke", {
        Thickness = 2,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.Pattern = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = "rbxassetid://300134974",
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(30,30),
        ImageTransparency = 0.97,
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TextLabel = tree:Element("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(0.67, 0.5),
        BackgroundTransparency = 1,
        Text = "Render",
        TextScaled = true,
        FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
        TextColor3 = Color3.new(1,1,1),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTransparency = 0.4,
        ZIndex = 2,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TabIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3926307971",
        ImageRectOffset = Vector2.new(444, 244),
        ImageRectSize = Vector2.new(36,36),
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.4,
        ZIndex = 2
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.OpenIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -13, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        Image = Textures.ArrowDownIcon,
        ScaleType = Enum.ScaleType.Fit
    })
    
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab = tree:Element("Frame", {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 200, 1, 0),
        BorderSizePixel = 0,
        LayoutOrder = 1,
        BackgroundColor3 = Color3.fromRGB(163, 184, 203)
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.ActivateButton = tree:Element("TextButton", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.UIGradient = tree:Element("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.8),
            NumberSequenceKeypoint.new(1,1)
        }),
        Rotation = -90
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.UIStroke = tree:Element("UIStroke", {
        Thickness = 2,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.Pattern = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = "rbxassetid://300134974",
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(30,30),
        ImageTransparency = 0.97,
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TextLabel = tree:Element("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(0.67, 0.5),
        BackgroundTransparency = 1,
        Text = "Movement",
        TextScaled = true,
        FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
        TextColor3 = Color3.new(1,1,1),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTransparency = 0.4,
        ZIndex = 2,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TabIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.fromOffset(25, 25),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6034754445",
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.4,
        ZIndex = 2
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.OpenIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -13, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        Image = Textures.ArrowDownIcon,
        ScaleType = Enum.ScaleType.Fit
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab = tree:Element("Frame", {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 200, 1, 0),
        BorderSizePixel = 0,
        LayoutOrder = 2,
        BackgroundColor3 = Color3.fromRGB(163, 184, 203)
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.ActivateButton = tree:Element("TextButton", {
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.UIGradient = tree:Element("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.8),
            NumberSequenceKeypoint.new(1,1)
        }),
        Rotation = -90
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.UIStroke = tree:Element("UIStroke", {
        Thickness = 2,
        Transparency = 0,
        Color = ACCENT_COLOR,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.UIStroke.UIGradient = tree:Element("UIGradient", {
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        })
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.Pattern = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = "rbxassetid://300134974",
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(30,30),
        ImageTransparency = 0.97,
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TextLabel = tree:Element("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(0.67, 0.5),
        BackgroundTransparency = 1,
        Text = "Misc",
        TextScaled = true,
        FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
        TextColor3 = Color3.new(1,1,1),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTransparency = 0.4,
        ZIndex = 2,
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TabIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.fromOffset(25, 25),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6034509993",
        ScaleType = Enum.ScaleType.Fit,
        ImageTransparency = 0.4,
        ZIndex = 2
    })
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.OpenIcon = tree:Element("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -13, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        ImageTransparency = 0.4,
        Image = Textures.ArrowDownIcon,
        ScaleType = Enum.ScaleType.Fit
    })
    
    local Clicks = {
        CombatTab = 0,
        RenderTab = 0,
        MovementTab = 0,
        MiscTab = 0,
    }
    
    -- combat tab
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.ActivateButton:Connect("hover:enter", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.ActivateButton:Connect("hover:exit", function()
        if Clicks.CombatTab % 2 == 0 then
        else
            return
        end
        
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.ActivateButton:Connect("clicked", function()
        Clicks.CombatTab += 1
    
        if Clicks.CombatTab % 2 == 0 then
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.OpenIcon.Image = Textures.ArrowDownIcon
        else
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.CombatTab.OpenIcon.Image = Textures.ArrowUpIcon
        end
    end)
    
    -- render tab
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.ActivateButton:Connect("hover:enter", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.ActivateButton:Connect("hover:exit", function()
        if Clicks.RenderTab % 2 == 0 then
        else
            return
        end
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.ActivateButton:Connect("clicked", function()
        Clicks.RenderTab += 1
    
        if Clicks.RenderTab % 2 == 0 then
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.OpenIcon.Image = Textures.ArrowDownIcon
        else
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.RenderTab.OpenIcon.Image = Textures.ArrowUpIcon
        end
    end)
    
    -- movement tab
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.ActivateButton:Connect("hover:enter", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.ActivateButton:Connect("hover:exit", function()
        if Clicks.MovementTab % 2 == 0 then
        else
            return
        end
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.ActivateButton:Connect("clicked", function()
        Clicks.MovementTab += 1
    
        if Clicks.MovementTab % 2 == 0 then
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.OpenIcon.Image = Textures.ArrowDownIcon
        else
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MovementTab.OpenIcon.Image = Textures.ArrowUpIcon
        end
    end)
    
    -- misc tab
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.ActivateButton:Connect("hover:enter", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.ActivateButton:Connect("hover:exit", function()
        if Clicks.MiscTab % 2 == 0 then
        else
            return
        end
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TextLabel._instance, tweenInfo, {TextTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.TabIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.OpenIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.ActivateButton:Connect("clicked", function()
        Clicks.MiscTab += 1
    
        if Clicks.MiscTab % 2 == 0 then
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.OpenIcon.Image = Textures.ArrowDownIcon
        else
            _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.MiscTab.OpenIcon.Image = Textures.ArrowUpIcon
        end
    end)
    
    -- move handle
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon:Connect("drag:began", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon.ImageLabel._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
    end)
    
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon:Connect("drag:end", function()
        local tweenInfo = TweenInfo.new(0.2)
        TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.MoveIcon.ImageLabel._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
    end)
    
    -- settings
    
    local clickCount = 0
    _G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.SettingsIcon:Connect("clicked", function()
        clickCount += 1
        local tweenInfo = TweenInfo.new(0.2)
        if clickCount % 2 == 0 then
            TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.SettingsIcon._instance, tweenInfo, {ImageTransparency = 0.4}):Play()
        else
            TweenService:Create(_G._crystalTree.MainFrame.MainMenuWidget.TabsFolder.LogoIconTab.SettingsIcon._instance, tweenInfo, {ImageTransparency = 0.1}):Play()
        end
    end)

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