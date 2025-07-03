-- FluentUI Library - Complete Modern UI Library for Roblox
-- A beautiful and feature-complete UI library with all Fluent functions

local FluentUI = {}
FluentUI.__index = FluentUI
FluentUI.Version = "2.0"

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Enhanced Theme with gradients and modern colors
local Theme = {
    -- Main Colors
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(28, 28, 35),
    Tertiary = Color3.fromRGB(35, 35, 42),
    Surface = Color3.fromRGB(42, 42, 50),
    
    -- Accent Colors
    Primary = Color3.fromRGB(88, 101, 242),
    PrimaryHover = Color3.fromRGB(71, 82, 196),
    Accent = Color3.fromRGB(114, 137, 218),
    
    -- Text Colors
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(185, 187, 190),
    TextMuted = Color3.fromRGB(142, 146, 151),
    
    -- Status Colors
    Success = Color3.fromRGB(87, 242, 135),
    Warning = Color3.fromRGB(254, 231, 92),
    Error = Color3.fromRGB(237, 66, 69),
    
    -- Border and Effects
    Border = Color3.fromRGB(60, 60, 67),
    BorderLight = Color3.fromRGB(80, 80, 87),
    Shadow = Color3.fromRGB(0, 0, 0),
    
    -- Special Effects
    Glow = Color3.fromRGB(88, 101, 242),
    Transparent = Color3.fromRGB(255, 255, 255)
}

-- Utility Functions
local function CreateTween(object, info, properties)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colors or ColorSequence.new(Theme.Primary, Theme.Accent)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

local function CreatePadding(parent, all, top, bottom, left, right)
    local padding = Instance.new("UIPadding")
    if all then
        padding.PaddingTop = UDim.new(0, all)
        padding.PaddingBottom = UDim.new(0, all)
        padding.PaddingLeft = UDim.new(0, all)
        padding.PaddingRight = UDim.new(0, all)
    else
        padding.PaddingTop = UDim.new(0, top or 0)
        padding.PaddingBottom = UDim.new(0, bottom or 0)
        padding.PaddingLeft = UDim.new(0, left or 0)
        padding.PaddingRight = UDim.new(0, right or 0)
    end
    padding.Parent = parent
    return padding
end

-- Main Library Functions
function FluentUI:CreateWindow(config)
    local Window = {}
    Window.Tabs = {}
    Window.Notifications = {}
    
    -- Destroy existing UI
    if PlayerGui:FindFirstChild("FluentUI") then
        PlayerGui.FluentUI:Destroy()
    end
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FluentUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Container with shadow
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = config.Size or UDim2.fromOffset(580, 460)
    MainContainer.Position = UDim2.fromScale(0.5, 0.5)
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundTransparency = 1
    MainContainer.BorderSizePixel = 0
    MainContainer.Parent = ScreenGui
    

    -- Main Frame with blur effect
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = MainContainer
    
    CreateCorner(MainFrame, 16)
    CreateStroke(MainFrame, Theme.BorderLight, 1, 0.3)
    
    -- Title Bar with gradient
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    CreateCorner(TitleBar, 16)
    CreateGradient(TitleBar, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.Secondary),
        ColorSequenceKeypoint.new(1, Theme.Tertiary)
    }, 90)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -120, 0, 24)
    Title.Position = UDim2.fromOffset(20, 8)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "FluentUI " .. FluentUI.Version
    Title.TextColor3 = Theme.Text
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    -- Subtitle
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Name = "SubTitle"
    SubTitle.Size = UDim2.new(1, -120, 0, 16)
    SubTitle.Position = UDim2.fromOffset(20, 26)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = config.SubTitle or "Modern UI Library"
    SubTitle.TextColor3 = Theme.TextSecondary
    SubTitle.TextSize = 12
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = TitleBar
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.fromOffset(30, 30)
    MinimizeButton.Position = UDim2.new(1, -75, 0, 10)
    MinimizeButton.BackgroundColor3 = Theme.Warning
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    
    CreateCorner(MinimizeButton, 8)
    
    -- Close Button with gradient
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.fromOffset(30, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 10)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    
    CreateCorner(CloseButton, 8)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, config.TabWidth or 160, 1, -50)
    TabContainer.Position = UDim2.fromOffset(0, 50)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    CreatePadding(TabContainer, 10)
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -(config.TabWidth or 160), 1, -50)
    ContentContainer.Position = UDim2.fromOffset(config.TabWidth or 160, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    -- Current tab tracking
    local currentTab = nil
    local isMinimized = false
    local originalSize = MainContainer.Size
    
    -- Make window draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainContainer.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Minimize functionality
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.fromOffset(originalSize.X.Offset, 50)
            })
            MinimizeButton.Text = "+"
        else
            CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = originalSize
            })
            MinimizeButton.Text = "−"
        end
    end)
    
    -- Close functionality
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.fromOffset(0, 0),
            Position = UDim2.fromScale(0.5, 0.5)
        })
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Hover effects for buttons
    local function AddButtonEffects(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            CreateTween(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor})
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor})
        end)
    end
    
    AddButtonEffects(MinimizeButton, Theme.Warning, Color3.fromRGB(254, 200, 92))
    AddButtonEffects(CloseButton, Theme.Error, Color3.fromRGB(200, 50, 50))
    
    -- Window Methods
    function Window:AddTab(config)
        local Tab = {}
        Tab.Elements = {}
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = Theme.Tertiary
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.Parent = TabContainer
        
        CreateCorner(TabButton, 10)
        
        -- Tab Icon (if provided)
        local TabIcon = Instance.new("TextLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.Size = UDim2.fromOffset(20, 20)
        TabIcon.Position = UDim2.fromOffset(10, 10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Text = config.Icon or "⚡"
        TabIcon.TextColor3 = Theme.TextSecondary
        TabIcon.TextSize = 16
        TabIcon.Font = Enum.Font.Gotham
        TabIcon.Parent = TabButton
        
        -- Tab Title
        local TabTitle = Instance.new("TextLabel")
        TabTitle.Name = "TabTitle"
        TabTitle.Size = UDim2.new(1, -40, 1, 0)
        TabTitle.Position = UDim2.fromOffset(35, 0)
        TabTitle.BackgroundTransparency = 1
        TabTitle.Text = config.Title or "Tab"
        TabTitle.TextColor3 = Theme.TextSecondary
        TabTitle.TextSize = 14
        TabTitle.Font = Enum.Font.GothamSemibold
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle.Parent = TabButton
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent"
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.fromOffset(10, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 6
        TabContent.ScrollBarImageColor3 = Theme.Primary
        TabContent.ScrollBarImageTransparency = 0.3
        TabContent.CanvasSize = UDim2.fromOffset(0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = TabContent
        
        CreatePadding(TabContent, 10)
        
        -- Update canvas size
        local function UpdateCanvasSize()
            TabContent.CanvasSize = UDim2.fromOffset(0, ContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
        
        -- Tab selection
        local function SelectTab()
            -- Deselect other tabs
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Theme.Tertiary
                tab.Title.TextColor3 = Theme.TextSecondary
                tab.Icon.TextColor3 = Theme.TextSecondary
                tab.Content.Visible = false
            end
            
            -- Select this tab
            TabButton.BackgroundColor3 = Theme.Primary
            TabTitle.TextColor3 = Theme.Text
            TabIcon.TextColor3 = Theme.Text
            TabContent.Visible = true
            currentTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        -- Store tab references
        Tab.Button = TabButton
        Tab.Title = TabTitle
        Tab.Icon = TabIcon
        Tab.Content = TabContent
        Tab.Layout = ContentLayout
        
        Window.Tabs[#Window.Tabs + 1] = Tab
        
        -- Select first tab by default
        if #Window.Tabs == 1 then
            SelectTab()
        end
        
        -- Tab Element Methods
        function Tab:AddParagraph(config)
            local ParagraphFrame = Instance.new("Frame")
            ParagraphFrame.Name = "ParagraphFrame"
            ParagraphFrame.Size = UDim2.new(1, 0, 0, 60)
            ParagraphFrame.BackgroundColor3 = Theme.Surface
            ParagraphFrame.BorderSizePixel = 0
            ParagraphFrame.Parent = TabContent
            
            CreateCorner(ParagraphFrame, 10)
            CreateStroke(ParagraphFrame, Theme.Border, 1, 0.5)
            CreatePadding(ParagraphFrame, 15)
            
            local ParagraphTitle = Instance.new("TextLabel")
            ParagraphTitle.Name = "ParagraphTitle"
            ParagraphTitle.Size = UDim2.new(1, 0, 0, 20)
            ParagraphTitle.BackgroundTransparency = 1
            ParagraphTitle.Text = config.Title or "Paragraph"
            ParagraphTitle.TextColor3 = Theme.Text
            ParagraphTitle.TextSize = 16
            ParagraphTitle.Font = Enum.Font.GothamBold
            ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphTitle.Parent = ParagraphFrame
            
            local ParagraphContent = Instance.new("TextLabel")
            ParagraphContent.Name = "ParagraphContent"
            ParagraphContent.Size = UDim2.new(1, 0, 1, -25)
            ParagraphContent.Position = UDim2.fromOffset(0, 25)
            ParagraphContent.BackgroundTransparency = 1
            ParagraphContent.Text = config.Content or "This is a paragraph."
            ParagraphContent.TextColor3 = Theme.TextSecondary
            ParagraphContent.TextSize = 14
            ParagraphContent.Font = Enum.Font.Gotham
            ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
            ParagraphContent.TextWrapped = true
            ParagraphContent.Parent = ParagraphFrame
            
            -- Auto-resize based on content
            local function UpdateSize()
                local textService = game:GetService("TextService")
                local textBounds = textService:GetTextSize(
                    ParagraphContent.Text,
                    ParagraphContent.TextSize,
                    ParagraphContent.Font,
                    Vector2.new(ParagraphContent.AbsoluteSize.X, math.huge)
                )
                ParagraphFrame.Size = UDim2.new(1, 0, 0, math.max(60, textBounds.Y + 50))
            end
            
            ParagraphContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateSize)
            UpdateSize()
            
            UpdateCanvasSize()
            return ParagraphFrame
        end
        
        function Tab:AddButton(config)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Size = UDim2.new(1, 0, 0, 45)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Parent = TabContent
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.BackgroundColor3 = Theme.Primary
            Button.BorderSizePixel = 0
            Button.Text = config.Title or "Button"
            Button.TextColor3 = Theme.Text
            Button.TextSize = 16
            Button.Font = Enum.Font.GothamSemibold
            Button.Parent = ButtonFrame
            
            CreateCorner(Button, 10)
            CreateGradient(Button, ColorSequence.new{
                ColorSequenceKeypoint.new(0, Theme.Primary),
                ColorSequenceKeypoint.new(1, Theme.Accent)
            }, 45)
            
            -- Description (if provided)
            if config.Description then
                ButtonFrame.Size = UDim2.new(1, 0, 0, 65)
                Button.Size = UDim2.new(1, 0, 0, 45)
                
                local Description = Instance.new("TextLabel")
                Description.Name = "Description"
                Description.Size = UDim2.new(1, 0, 0, 15)
                Description.Position = UDim2.fromOffset(0, 50)
                Description.BackgroundTransparency = 1
                Description.Text = config.Description
                Description.TextColor3 = Theme.TextMuted
                Description.TextSize = 12
                Description.Font = Enum.Font.Gotham
                Description.TextXAlignment = Enum.TextXAlignment.Left
                Description.Parent = ButtonFrame
            end
            
            -- Hover effects
            Button.MouseEnter:Connect(function()
                CreateTween(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.PrimaryHover})
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Primary})
            end)
            
            -- Click effect
            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0.9, 0)})
                CreateTween(Button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 1, 0)})
                
                if config.Callback then
                    config.Callback()
                end
            end)
            
            UpdateCanvasSize()
            return Button
        end
        
        function Tab:AddToggle(config)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
            ToggleFrame.BackgroundColor3 = Theme.Surface
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            CreateCorner(ToggleFrame, 10)
            CreateStroke(ToggleFrame, Theme.Border, 1, 0.5)
            CreatePadding(ToggleFrame, 15)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = config.Title or "Toggle"
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.TextSize = 16
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Size = UDim2.fromOffset(50, 25)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -12.5)
            ToggleButton.BackgroundColor3 = Theme.Border
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, 12.5)
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "ToggleIndicator"
            ToggleIndicator.Size = UDim2.fromOffset(21, 21)
            ToggleIndicator.Position = UDim2.fromOffset(2, 2)
            ToggleIndicator.BackgroundColor3 = Theme.Text
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, 10.5)
            
            local toggled = config.Default or false
            
            local function UpdateToggle()
                if toggled then
                    CreateTween(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.Success})
                    CreateTween(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.fromOffset(27, 2)})
                else
                    CreateTween(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Theme.Border})
                    CreateTween(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.fromOffset(2, 2)})
                end
                
                if config.Callback then
                    config.Callback(toggled)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            local Toggle = {
                Value = toggled,
                OnChanged = function(self, callback)
                    config.Callback = callback
                end,
                SetValue = function(self, value)
                    toggled = value
                    self.Value = value
                    UpdateToggle()
                end
            }
            
            UpdateCanvasSize()
            return Toggle
        end
        
      function Tab:AddSlider(config)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = "SliderFrame"
        SliderFrame.Size = UDim2.new(1, 0, 0, 70)
        SliderFrame.BackgroundColor3 = Theme.Surface
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Parent = TabContent
        
        CreateCorner(SliderFrame, 10)
        CreateStroke(SliderFrame, Theme.Border, 1, 0.5)
        CreatePadding(SliderFrame, 15)
        
        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Name = "SliderLabel"
        SliderLabel.Size = UDim2.new(1, -60, 0, 20)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = config.Title or "Slider"
        SliderLabel.TextColor3 = Theme.Text
        SliderLabel.TextSize = 16
        SliderLabel.Font = Enum.Font.GothamSemibold
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = SliderFrame
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Name = "ValueLabel"
        ValueLabel.Size = UDim2.fromOffset(60, 20)
        ValueLabel.Position = UDim2.new(1, -60, 0, 0)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(config.Default or config.Min or 0)
        ValueLabel.TextColor3 = Theme.Primary
        ValueLabel.TextSize = 14
        ValueLabel.Font = Enum.Font.GothamBold
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValueLabel.Parent = SliderFrame
        
        -- Description
        if config.Description then
            SliderFrame.Size = UDim2.new(1, 0, 0, 85)
            
            local Description = Instance.new("TextLabel")
            Description.Name = "Description"
            Description.Size = UDim2.new(1, 0, 0, 15)
            Description.Position = UDim2.fromOffset(0, 20)
            Description.BackgroundTransparency = 1
            Description.Text = config.Description
            Description.TextColor3 = Theme.TextMuted
            Description.TextSize = 12
            Description.Font = Enum.Font.Gotham
            Description.TextXAlignment = Enum.TextXAlignment.Left
            Description.Parent = SliderFrame
        end
        
        local SliderTrack = Instance.new("Frame")
        SliderTrack.Name = "SliderTrack"
        SliderTrack.Size = UDim2.new(1, 0, 0, 6)
        SliderTrack.Position = UDim2.fromOffset(0, config.Description and 45 or 30)
        SliderTrack.BackgroundColor3 = Theme.Border
        SliderTrack.BorderSizePixel = 0
        SliderTrack.Parent = SliderFrame
        
        CreateCorner(SliderTrack, 3)
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "SliderFill"
        SliderFill.Size = UDim2.new(0, 0, 1, 0)
        SliderFill.BackgroundColor3 = Theme.Primary
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderTrack
        
        CreateCorner(SliderFill, 3)
        CreateGradient(SliderFill, ColorSequence.new{
            ColorSequenceKeypoint.new(0, Theme.Primary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }, 45)
        
        -- FIXED: Parent the handle to SliderTrack instead of SliderFill
        local SliderHandle = Instance.new("Frame")
        SliderHandle.Name = "SliderHandle"
        SliderHandle.Size = UDim2.fromOffset(20, 20)
        SliderHandle.Position = UDim2.fromOffset(-10, -7) -- Start at the beginning
        SliderHandle.BackgroundColor3 = Theme.Text
        SliderHandle.BorderSizePixel = 0
        SliderHandle.Parent = SliderTrack -- Changed from SliderFill to SliderTrack
        
        CreateCorner(SliderHandle, 10)
        CreateStroke(SliderHandle, Theme.Primary, 2)
        
        local min = config.Min or 0
        local max = config.Max or 100
        local value = config.Default or min
        local rounding = config.Rounding or 1
        local dragging = false
        
        -- FIXED: Update both fill and handle position
        local function UpdateSlider()
            local percent = (value - min) / (max - min)
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            
            -- Update handle position based on percentage
            local handleX = (SliderTrack.AbsoluteSize.X * percent) - 10
            SliderHandle.Position = UDim2.fromOffset(handleX, -7)
            
            local roundedValue = math.floor(value * (10 ^ rounding)) / (10 ^ rounding)
            ValueLabel.Text = tostring(roundedValue)
            
            if config.Callback then
                config.Callback(roundedValue)
            end
        end
        
        local function SetValue(newValue)
            value = math.clamp(newValue, min, max)
            UpdateSlider()
        end
        
        SliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local percent = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                SetValue(min + (max - min) * percent)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local percent = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                SetValue(min + (max - min) * percent)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        -- Hover effects
        SliderHandle.MouseEnter:Connect(function()
            CreateTween(SliderHandle, TweenInfo.new(0.2), {Size = UDim2.fromOffset(24, 24)})
        end)
        
        SliderHandle.MouseLeave:Connect(function()
            if not dragging then
                CreateTween(SliderHandle, TweenInfo.new(0.2), {Size = UDim2.fromOffset(20, 20)})
            end
        end)
        
        UpdateSlider()
        
        local Slider = {
            Value = value,
            OnChanged = function(self, callback)
                config.Callback = callback
            end,
            SetValue = function(self, newValue)
                SetValue(newValue)
                self.Value = value
            end
        }
        
        UpdateCanvasSize()
        return Slider
    end
        
        function Tab:AddDropdown(config)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
            DropdownFrame.BackgroundColor3 = Theme.Surface
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent
            
            CreateCorner(DropdownFrame, 10)
            CreateStroke(DropdownFrame, Theme.Border, 1, 0.5)
            CreatePadding(DropdownFrame, 15)
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Size = UDim2.new(1, 0, 1, 0)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = ""
            DropdownButton.Parent = DropdownFrame
            
            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Name = "DropdownLabel"
            DropdownLabel.Size = UDim2.new(1, -30, 1, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = config.Values[config.Default] or config.Values[1] or "Select..."
            DropdownLabel.TextColor3 = Theme.Text
            DropdownLabel.TextSize = 16
            DropdownLabel.Font = Enum.Font.GothamSemibold
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = DropdownButton
            
            local DropdownArrow = Instance.new("TextLabel")
            DropdownArrow.Name = "DropdownArrow"
            DropdownArrow.Size = UDim2.fromOffset(20, 20)
            DropdownArrow.Position = UDim2.new(1, -20, 0.5, -10)
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = Theme.TextSecondary
            DropdownArrow.TextSize = 12
            DropdownArrow.Font = Enum.Font.Gotham
            DropdownArrow.Parent = DropdownButton
            
            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 5)
            DropdownList.BackgroundColor3 = Theme.Background
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.ZIndex = 10
            DropdownList.Parent = DropdownFrame
            
            CreateCorner(DropdownList, 10)w
            CreateStroke(DropdownList, Theme.BorderLight, 1)
   
            local ListScrollFrame = Instance.new("ScrollingFrame")
            ListScrollFrame.Name = "ListScrollFrame"
            ListScrollFrame.Size = UDim2.new(1, 0, 1, 0)
            ListScrollFrame.BackgroundTransparency = 1
            ListScrollFrame.BorderSizePixel = 0
            ListScrollFrame.ScrollBarThickness = 4
            ListScrollFrame.ScrollBarImageColor3 = Theme.Primary
            ListScrollFrame.CanvasSize = UDim2.fromOffset(0, 0)
            ListScrollFrame.Parent = DropdownList
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = ListScrollFrame
            
            local selectedValue = config.Values[config.Default] or config.Values[1] or nil
            local isOpen = false
            
            local function UpdateCanvasSize()
                ListScrollFrame.CanvasSize = UDim2.fromOffset(0, ListLayout.AbsoluteContentSize.Y)
            end
            
            local function ToggleDropdown()
                isOpen = not isOpen
                if isOpen then
                    DropdownList.Visible = true
                    local maxHeight = math.min(#config.Values * 35, 150)
                    CreateTween(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, maxHeight)})
                    CreateTween(DropdownArrow, TweenInfo.new(0.3), {Rotation = 180})
                else
                    CreateTween(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)})
                    CreateTween(DropdownArrow, TweenInfo.new(0.3), {Rotation = 0})
                    wait(0.3)
                    DropdownList.Visible = false
                end
            end
            
            -- Multi-select support
            local selectedValues = {}
            if config.Multi and config.Default then
                for _, value in pairs(config.Default) do
                    selectedValues[value] = true
                end
            end
            
            for i, value in ipairs(config.Values) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option" .. i
                OptionButton.Size = UDim2.new(1, 0, 0, 35)
                OptionButton.BackgroundColor3 = Theme.Secondary
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = ""
                OptionButton.Parent = ListScrollFrame
                
                local OptionLabel = Instance.new("TextLabel")
                OptionLabel.Name = "OptionLabel"
                OptionLabel.Size = UDim2.new(1, -30, 1, 0)
                OptionLabel.Position = UDim2.fromOffset(15, 0)
                OptionLabel.BackgroundTransparency = 1
                OptionLabel.Text = value
                OptionLabel.TextColor3 = Theme.Text
                OptionLabel.TextSize = 14
                OptionLabel.Font = Enum.Font.Gotham
                OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                OptionLabel.Parent = OptionButton
                
                if config.Multi then
                    local CheckBox = Instance.new("Frame")
                    CheckBox.Name = "CheckBox"
                    CheckBox.Size = UDim2.fromOffset(16, 16)
                    CheckBox.Position = UDim2.new(1, -20, 0.5, -8)
                    CheckBox.BackgroundColor3 = Theme.Border
                    CheckBox.BorderSizePixel = 0
                    CheckBox.Parent = OptionButton
                    
                    CreateCorner(CheckBox, 4)
                    
                    local CheckMark = Instance.new("TextLabel")
                    CheckMark.Size = UDim2.new(1, 0, 1, 0)
                    CheckMark.BackgroundTransparency = 1
                    CheckMark.Text = "✓"
                    CheckMark.TextColor3 = Theme.Text
                    CheckMark.TextSize = 12
                    CheckMark.Font = Enum.Font.GothamBold
                    CheckMark.Visible = selectedValues[value] or false
                    CheckMark.Parent = CheckBox
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        selectedValues[value] = not selectedValues[value]
                        CheckMark.Visible = selectedValues[value]
                        CheckBox.BackgroundColor3 = selectedValues[value] and Theme.Success or Theme.Border
                        
                        if config.Callback then
                            config.Callback(selectedValues)
                        end
                    end)
                else
                    OptionButton.MouseButton1Click:Connect(function()
                        selectedValue = value
                        DropdownLabel.Text = value
                        ToggleDropdown()
                        
                        if config.Callback then
                            config.Callback(value)
                        end
                    end)
                end
                
                OptionButton.MouseEnter:Connect(function()
                    CreateTween(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Primary})
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    CreateTween(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Secondary})
                end)
            end
            
            DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
            UpdateCanvasSize()
            
            local Dropdown = {
                Value = selectedValue,
                OnChanged = function(self, callback)
                    config.Callback = callback
                end,
                SetValue = function(self, value)
                    if config.Multi then
                        selectedValues = value
                        -- Update checkboxes
                        for _, option in pairs(ListScrollFrame:GetChildren()) do
                            if option:IsA("TextButton") then
                                local checkbox = option:FindFirstChild("CheckBox")
                                if checkbox then
                                    local checkmark = checkbox:FindFirstChild("TextLabel")
                                    local optionValue = option:FindFirstChild("OptionLabel").Text
                                    checkmark.Visible = selectedValues[optionValue] or false
                                    checkbox.BackgroundColor3 = selectedValues[optionValue] and Theme.Success or Theme.Border
                                end
                            end
                        end
                    else
                        selectedValue = value
                        DropdownLabel.Text = value
                        self.Value = value
                    end
                end
            }
            
            UpdateCanvasSize()
            return Dropdown
        end
        
        function Tab:AddColorpicker(config)
            local ColorPickerFrame = Instance.new("Frame")
            ColorPickerFrame.Name = "ColorPickerFrame"
            ColorPickerFrame.Size = UDim2.new(1, 0, 0, 45)
            ColorPickerFrame.BackgroundColor3 = Theme.Surface
            ColorPickerFrame.BorderSizePixel = 0
            ColorPickerFrame.Parent = TabContent
            
            CreateCorner(ColorPickerFrame, 10)
            CreateStroke(ColorPickerFrame, Theme.Border, 1, 0.5)
            CreatePadding(ColorPickerFrame, 15)
            
            local ColorLabel = Instance.new("TextLabel")
            ColorLabel.Name = "ColorLabel"
            ColorLabel.Size = UDim2.new(1, -50, 1, 0)
            ColorLabel.BackgroundTransparency = 1
            ColorLabel.Text = config.Title or "Color Picker"
            ColorLabel.TextColor3 = Theme.Text
            ColorLabel.TextSize = 16
            ColorLabel.Font = Enum.Font.GothamSemibold
            ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
            ColorLabel.Parent = ColorPickerFrame
            
            local ColorDisplay = Instance.new("TextButton")
            ColorDisplay.Name = "ColorDisplay"
            ColorDisplay.Size = UDim2.fromOffset(35, 25)
            ColorDisplay.Position = UDim2.new(1, -35, 0.5, -12.5)
            ColorDisplay.BackgroundColor3 = config.Default or Color3.fromRGB(255, 255, 255)
            ColorDisplay.BorderSizePixel = 0
            ColorDisplay.Text = ""
            ColorDisplay.Parent = ColorPickerFrame
            
            CreateCorner(ColorDisplay, 6)
            CreateStroke(ColorDisplay, Theme.BorderLight, 2)
            
            local currentColor = config.Default or Color3.fromRGB(255, 255, 255)
            local currentTransparency = config.Transparency or 0
            
            local ColorPicker = {
                Value = currentColor,
                Transparency = currentTransparency,
                OnChanged = function(self, callback)
                    config.Callback = callback
                end,
                SetValueRGB = function(self, color)
                    currentColor = color
                    self.Value = color
                    ColorDisplay.BackgroundColor3 = color
                    if config.Callback then
                        config.Callback(color)
                    end
                end
            }
            
            -- Simple color picker (could be expanded with full color wheel)
            ColorDisplay.MouseButton1Click:Connect(function()
                -- For now, cycle through some preset colors
                local colors = {
                    Color3.fromRGB(255, 0, 0),
                    Color3.fromRGB(0, 255, 0),
                    Color3.fromRGB(0, 0, 255),
                    Color3.fromRGB(255, 255, 0),
                    Color3.fromRGB(255, 0, 255),
                    Color3.fromRGB(0, 255, 255),
                    Color3.fromRGB(255, 255, 255)
                }
                
                local currentIndex = 1
                for i, color in ipairs(colors) do
                    if color == currentColor then
                        currentIndex = i
                        break
                    end
                end
                
                currentIndex = currentIndex % #colors + 1
                ColorPicker:SetValueRGB(colors[currentIndex])
            end)
            
            UpdateCanvasSize()
            return ColorPicker
        end
        
        function Tab:AddKeybind(config)
            local KeybindFrame = Instance.new("Frame")
            KeybindFrame.Name = "KeybindFrame"
            KeybindFrame.Size = UDim2.new(1, 0, 0, 45)
            KeybindFrame.BackgroundColor3 = Theme.Surface
            KeybindFrame.BorderSizePixel = 0
            KeybindFrame.Parent = TabContent
            
            CreateCorner(KeybindFrame, 10)
            CreateStroke(KeybindFrame, Theme.Border, 1, 0.5)
            CreatePadding(KeybindFrame, 15)
            
            local KeybindLabel = Instance.new("TextLabel")
            KeybindLabel.Name = "KeybindLabel"
            KeybindLabel.Size = UDim2.new(1, -80, 1, 0)
            KeybindLabel.BackgroundTransparency = 1
            KeybindLabel.Text = config.Title or "Keybind"
            KeybindLabel.TextColor3 = Theme.Text
            KeybindLabel.TextSize = 16
            KeybindLabel.Font = Enum.Font.GothamSemibold
            KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            KeybindLabel.Parent = KeybindFrame
            
            local KeybindButton = Instance.new("TextButton")
            KeybindButton.Name = "KeybindButton"
            KeybindButton.Size = UDim2.fromOffset(70, 25)
            KeybindButton.Position = UDim2.new(1, -70, 0.5, -12.5)
            KeybindButton.BackgroundColor3 = Theme.Secondary
            KeybindButton.BorderSizePixel = 0
            KeybindButton.Text = config.Default or "None"
            KeybindButton.TextColor3 = Theme.Text
            KeybindButton.TextSize = 12
            KeybindButton.Font = Enum.Font.Gotham
            KeybindButton.Parent = KeybindFrame
            
            CreateCorner(KeybindButton, 6)
            CreateStroke(KeybindButton, Theme.Border)
            
            local currentKey = config.Default or "None"
            local mode = config.Mode or "Toggle"
            local isListening = false
            local isPressed = false
            
            local function UpdateKeybind(key)
                currentKey = key
                KeybindButton.Text = key
                if config.ChangedCallback then
                    config.ChangedCallback(key)
                end
            end
            
            KeybindButton.MouseButton1Click:Connect(function()
                if not isListening then
                    isListening = true
                    KeybindButton.Text = "..."
                    KeybindButton.BackgroundColor3 = Theme.Primary
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                
                if isListening then
                    local keyName = input.KeyCode.Name
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        keyName = "MB1"
                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                        keyName = "MB2"
                    end
                    
                    UpdateKeybind(keyName)
                    isListening = false
                    KeybindButton.BackgroundColor3 = Theme.Secondary
                elseif input.KeyCode.Name == currentKey or 
                       (input.UserInputType == Enum.UserInputType.MouseButton1 and currentKey == "MB1") or
                       (input.UserInputType == Enum.UserInputType.MouseButton2 and currentKey == "MB2") then
                    
                    if mode == "Toggle" then
                        isPressed = not isPressed
                        if config.Callback then
                            config.Callback(isPressed)
                        end
                    elseif mode == "Hold" then
                        isPressed = true
                        if config.Callback then
                            config.Callback(true)
                        end
                    end
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if (input.KeyCode.Name == currentKey or 
                   (input.UserInputType == Enum.UserInputType.MouseButton1 and currentKey == "MB1") or
                   (input.UserInputType == Enum.UserInputType.MouseButton2 and currentKey == "MB2")) and mode == "Hold" then
                    isPressed = false
                    if config.Callback then
                        config.Callback(false)
                    end
                end
            end)
            
            local Keybind = {
                Value = currentKey,
                OnChanged = function(self, callback)
                    config.ChangedCallback = callback
                end,
                OnClick = function(self, callback)
                    config.Callback = callback
                end,
                GetState = function(self)
                    return isPressed
                end,
                SetValue = function(self, key, newMode)
                    UpdateKeybind(key)
                    if newMode then
                        mode = newMode
                    end
                    self.Value = key
                end
            }
            
            UpdateCanvasSize()
            return Keybind
        end
        
        function Tab:AddInput(config)
            local InputFrame = Instance.new("Frame")
            InputFrame.Name = "InputFrame"
            InputFrame.Size = UDim2.new(1, 0, 0, 45)
            InputFrame.BackgroundColor3 = Theme.Surface
            InputFrame.BorderSizePixel = 0
            InputFrame.Parent = TabContent
            
            CreateCorner(InputFrame, 10)
            CreateStroke(InputFrame, Theme.Border, 1, 0.5)
            CreatePadding(InputFrame, 15)
            
            local InputBox = Instance.new("TextBox")
            InputBox.Name = "InputBox"
            InputBox.Size = UDim2.new(1, 0, 1, 0)
            InputBox.BackgroundTransparency = 1
            InputBox.Text = config.Default or ""
            InputBox.PlaceholderText = config.Placeholder or "Enter text..."
            InputBox.TextColor3 = Theme.Text
            InputBox.PlaceholderColor3 = Theme.TextMuted
            InputBox.TextSize = 16
            InputBox.Font = Enum.Font.Gotham
            InputBox.TextXAlignment = Enum.TextXAlignment.Left
            InputBox.ClearTextOnFocus = false
            InputBox.Parent = InputFrame
            
            if config.Numeric then
                InputBox.PlaceholderText = config.Placeholder or "Enter number..."
                InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local text = InputBox.Text
                    local newText = string.gsub(text, "[^%d%.%-]", "")
                    if newText ~= text then
                        InputBox.Text = newText
                    end
                end)
            end
            
            -- Focus effects
            InputBox.Focused:Connect(function()
                CreateTween(InputFrame, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Tertiary})
                CreateStroke(InputFrame, Theme.Primary, 2, 0)
            end)
            
            InputBox.FocusLost:Connect(function(enterPressed)
                CreateTween(InputFrame, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Surface})
                CreateStroke(InputFrame, Theme.Border, 1, 0.5)
                
                if config.Finished and enterPressed and config.Callback then
                    config.Callback(InputBox.Text)
                elseif not config.Finished and config.Callback then
                    config.Callback(InputBox.Text)
                end
            end)
            
            if not config.Finished then
                InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    if config.Callback then
                        config.Callback(InputBox.Text)
                    end
                end)
            end
            
            local Input = {
                Value = InputBox.Text,
                OnChanged = function(self, callback)
                    config.Callback = callback
                end
            }
            
            InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                Input.Value = InputBox.Text
            end)
            
            UpdateCanvasSize()
            return Input
        end
        
        return Tab
    end
    
    function Window:SelectTab(index)
        if Window.Tabs[index] then
            Window.Tabs[index].Button.MouseButton1Click:Fire()
        end
    end
    
    function Window:Dialog(config)
        -- Create dialog overlay
        local DialogOverlay = Instance.new("Frame")
        DialogOverlay.Name = "DialogOverlay"
        DialogOverlay.Size = UDim2.new(1, 0, 1, 0)
        DialogOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        DialogOverlay.BackgroundTransparency = 0.5
        DialogOverlay.BorderSizePixel = 0
        DialogOverlay.ZIndex = 100
        DialogOverlay.Parent = ScreenGui
        
        local DialogFrame = Instance.new("Frame")
        DialogFrame.Name = "DialogFrame"
        DialogFrame.Size = UDim2.fromOffset(400, 200)
        DialogFrame.Position = UDim2.fromScale(0.5, 0.5)
        DialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DialogFrame.BackgroundColor3 = Theme.Background
        DialogFrame.BorderSizePixel = 0
        DialogFrame.ZIndex = 101
        DialogFrame.Parent = DialogOverlay
        
        CreateCorner(DialogFrame, 16)
        CreateStroke(DialogFrame, Theme.BorderLight, 2)
        CreatePadding(DialogFrame, 20)
        
        local DialogTitle = Instance.new("TextLabel")
        DialogTitle.Name = "DialogTitle"
        DialogTitle.Size = UDim2.new(1, 0, 0, 30)
        DialogTitle.BackgroundTransparency = 1
        DialogTitle.Text = config.Title or "Dialog"
        DialogTitle.TextColor3 = Theme.Text
        DialogTitle.TextSize = 20
        DialogTitle.Font = Enum.Font.GothamBold
        DialogTitle.TextXAlignment = Enum.TextXAlignment.Left
        DialogTitle.Parent = DialogFrame
        
        local DialogContent = Instance.new("TextLabel")
        DialogContent.Name = "DialogContent"
        DialogContent.Size = UDim2.new(1, 0, 1, -80)
        DialogContent.Position = UDim2.fromOffset(0, 40)
        DialogContent.BackgroundTransparency = 1
        DialogContent.Text = config.Content or "This is a dialog."
        DialogContent.TextColor3 = Theme.TextSecondary
        DialogContent.TextSize = 16
        DialogContent.Font = Enum.Font.Gotham
        DialogContent.TextXAlignment = Enum.TextXAlignment.Left
        DialogContent.TextYAlignment = Enum.TextYAlignment.Top
        DialogContent.TextWrapped = true
        DialogContent.Parent = DialogFrame
        
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = "ButtonContainer"
        ButtonContainer.Size = UDim2.new(1, 0, 0, 40)
        ButtonContainer.Position = UDim2.new(0, 0, 1, -40)
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Parent = DialogFrame
        
        local ButtonLayout = Instance.new("UIListLayout")
        ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
        ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        ButtonLayout.Padding = UDim.new(0, 10)
        ButtonLayout.Parent = ButtonContainer
        
        -- Add buttons
        if config.Buttons then
            for _, buttonConfig in ipairs(config.Buttons) do
                local DialogButton = Instance.new("TextButton")
                DialogButton.Name = "DialogButton"
                DialogButton.Size = UDim2.fromOffset(100, 40)
                DialogButton.BackgroundColor3 = buttonConfig.Title == "Confirm" and Theme.Primary or Theme.Secondary
                DialogButton.BorderSizePixel = 0
                DialogButton.Text = buttonConfig.Title or "Button"
                DialogButton.TextColor3 = Theme.Text
                DialogButton.TextSize = 14
                DialogButton.Font = Enum.Font.GothamSemibold
                DialogButton.Parent = ButtonContainer
                
                CreateCorner(DialogButton, 8)
                
                DialogButton.MouseButton1Click:Connect(function()
                    if buttonConfig.Callback then
                        buttonConfig.Callback()
                    end
                    DialogOverlay:Destroy()
                end)
                
                -- Hover effects
                DialogButton.MouseEnter:Connect(function()
                    CreateTween(DialogButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = buttonConfig.Title == "Confirm" and Theme.PrimaryHover or Theme.Tertiary
                    })
                end)
                
                DialogButton.MouseLeave:Connect(function()
                    CreateTween(DialogButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = buttonConfig.Title == "Confirm" and Theme.Primary or Theme.Secondary
                    })
                end)
            end
        else
            -- Default OK button
            local OKButton = Instance.new("TextButton")
            OKButton.Name = "OKButton"
            OKButton.Size = UDim2.fromOffset(100, 40)
            OKButton.BackgroundColor3 = Theme.Primary
            OKButton.BorderSizePixel = 0
            OKButton.Text = "OK"
            OKButton.TextColor3 = Theme.Text
            OKButton.TextSize = 14
            OKButton.Font = Enum.Font.GothamSemibold
            OKButton.Parent = ButtonContainer
            
            CreateCorner(OKButton, 8)
            
            OKButton.MouseButton1Click:Connect(function()
                DialogOverlay:Destroy()
            end)
        end
        
        -- Animate dialog in
        DialogFrame.Size = UDim2.fromOffset(0, 0)
        CreateTween(DialogFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.fromOffset(400, 200)
        })
        
        return DialogOverlay
    end
    
    function Window:Notification(config)
        local NotificationFrame = Instance.new("Frame")
        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Size = UDim2.fromOffset(350, 80)
        NotificationFrame.Position = UDim2.new(1, -370, 1, -100)
        NotificationFrame.BackgroundColor3 = Theme.Background
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ZIndex = 200
        NotificationFrame.Parent = ScreenGui
        
        CreateCorner(NotificationFrame, 12)
        CreateStroke(NotificationFrame, Theme.BorderLight, 1)
        CreatePadding(NotificationFrame, 15)
        
        local NotificationIcon = Instance.new("TextLabel")
        NotificationIcon.Name = "NotificationIcon"
        NotificationIcon.Size = UDim2.fromOffset(24, 24)
        NotificationIcon.Position = UDim2.fromOffset(0, 8)
        NotificationIcon.BackgroundTransparency = 1
        NotificationIcon.Text = config.Icon or "ℹ"
        NotificationIcon.TextColor3 = Theme.Primary
        NotificationIcon.TextSize = 20
        NotificationIcon.Font = Enum.Font.GothamBold
        NotificationIcon.Parent = NotificationFrame
        
        local NotificationTitle = Instance.new("TextLabel")
        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Size = UDim2.new(1, -40, 0, 20)
        NotificationTitle.Position = UDim2.fromOffset(35, 0)
        NotificationTitle.BackgroundTransparency = 1
        NotificationTitle.Text = config.Title or "Notification"
        NotificationTitle.TextColor3 = Theme.Text
        NotificationTitle.TextSize = 16
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotificationTitle.Parent = NotificationFrame
        
        local NotificationContent = Instance.new("TextLabel")
        NotificationContent.Name = "NotificationContent"
        NotificationContent.Size = UDim2.new(1, -40, 0, 20)
        NotificationContent.Position = UDim2.fromOffset(35, 25)
        NotificationContent.BackgroundTransparency = 1
        NotificationContent.Text = config.Content or "This is a notification."
        NotificationContent.TextColor3 = Theme.TextSecondary
        NotificationContent.TextSize = 14
        NotificationContent.Font = Enum.Font.Gotham
        NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
        NotificationContent.TextWrapped = true
        NotificationContent.Parent = NotificationFrame
        
        -- Animate in
        NotificationFrame.Position = UDim2.new(1, 0, 1, -100)
        CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, -370, 1, -100)
        })
        
        -- Auto-dismiss after duration
        local duration = config.Duration or 5
        wait(duration)
        
        CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 0, 1, -100)
        })
        wait(0.3)
        NotificationFrame:Destroy()
        
        return NotificationFrame
    end
    
    function Window:Destroy()
        if ScreenGui then
            ScreenGui:Destroy()
        end
    end
    
    return Window
end

-- Notification System
function FluentUI:Notify(config)
    local ScreenGui = PlayerGui:FindFirstChild("FluentUI") or PlayerGui:FindFirstChild("FluentUINotifications")
    
    if not ScreenGui then
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "FluentUINotifications"
        ScreenGui.Parent = PlayerGui
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Name = "NotificationFrame"
    NotificationFrame.Size = UDim2.fromOffset(350, 80)
    NotificationFrame.Position = UDim2.new(1, 0, 1, -100)
    NotificationFrame.BackgroundColor3 = Theme.Background
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.ZIndex = 200
    NotificationFrame.Parent = ScreenGui
    
    CreateCorner(NotificationFrame, 12)
    CreateStroke(NotificationFrame, Theme.BorderLight, 1)
    CreatePadding(NotificationFrame, 15)
    
    local typeColors = {
        ["Info"] = Theme.Primary,
        ["Success"] = Theme.Success,
        ["Warning"] = Theme.Warning,
        ["Error"] = Theme.Error
    }
    
    local typeIcons = {
        ["Info"] = "ℹ",
        ["Success"] = "✓",
        ["Warning"] = "⚠",
        ["Error"] = "✕"
    }
    
    local notificationType = config.Type or "Info"
    local iconColor = typeColors[notificationType] or Theme.Primary
    local iconText = typeIcons[notificationType] or config.Icon or "ℹ"
    
    local NotificationIcon = Instance.new("TextLabel")
    NotificationIcon.Name = "NotificationIcon"
    NotificationIcon.Size = UDim2.fromOffset(24, 24)
    NotificationIcon.Position = UDim2.fromOffset(0, 8)
    NotificationIcon.BackgroundTransparency = 1
    NotificationIcon.Text = iconText
    NotificationIcon.TextColor3 = iconColor
    NotificationIcon.TextSize = 20
    NotificationIcon.Font = Enum.Font.GothamBold
    NotificationIcon.Parent = NotificationFrame
    
    local NotificationTitle = Instance.new("TextLabel")
    NotificationTitle.Name = "NotificationTitle"
    NotificationTitle.Size = UDim2.new(1, -40, 0, 20)
    NotificationTitle.Position = UDim2.fromOffset(35, 0)
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.Text = config.Title or "Notification"
    NotificationTitle.TextColor3 = Theme.Text
    NotificationTitle.TextSize = 16
    NotificationTitle.Font = Enum.Font.GothamBold
    NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotificationTitle.Parent = NotificationFrame
    
    local NotificationContent = Instance.new("TextLabel")
    NotificationContent.Name = "NotificationContent"
    NotificationContent.Size = UDim2.new(1, -40, 0, 20)
    NotificationContent.Position = UDim2.fromOffset(35, 25)
    NotificationContent.BackgroundTransparency = 1
    NotificationContent.Text = config.Content or "This is a notification."
    NotificationContent.TextColor3 = Theme.TextSecondary
    NotificationContent.TextSize = 14
    NotificationContent.Font = Enum.Font.Gotham
    NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
    NotificationContent.TextWrapped = true
    NotificationContent.Parent = NotificationFrame
    
    -- Animate in
    CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Position = UDim2.new(1, -370, 1, -100)
    })
    
    -- Auto-dismiss after duration
    local duration = config.Duration or 5
    spawn(function()
        wait(duration)
        CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 0, 1, -100)
        })
        wait(0.3)
        NotificationFrame:Destroy()
    end)
    
    return NotificationFrame
end

-- Load configuration from file (optional)
function FluentUI:LoadConfig(fileName)
    -- Implementation for loading config from file would go here
    -- This is just a placeholder for the concept
    return {}
end

-- Save configuration to file (optional)
function FluentUI:SaveConfig(config, fileName)
    -- Implementation for saving config to file would go here
    -- This is just a placeholder for the concept
    return true
end

-- Example usage and demo
function FluentUI:Demo()
    local Window = FluentUI:CreateWindow({
        Title = "FluentUI Demo",
        SubTitle = "Showcase of all features",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true
    })
    
    local HomeTab = Window:AddTab({
        Title = "Home",
        Icon = "🏠"
    })
    
    HomeTab:AddParagraph({
        Title = "Welcome to FluentUI",
        Content = "This is a modern, beautiful UI library for Roblox with smooth animations and professional styling."
    })
    
    HomeTab:AddButton({
        Title = "Test Button",
        Description = "Click me to test the button functionality",
        Callback = function()
            FluentUI:Notify({
                Title = "Button Clicked!",
                Content = "The button was successfully clicked.",
                Type = "Success",
                Duration = 3
            })
        end
    })
    
    local ControlsTab = Window:AddTab({
        Title = "Controls",
        Icon = "⚙️"
    })
    
    ControlsTab:AddToggle({
        Title = "Enable Feature",
        Default = false,
        Callback = function(value)
            print("Toggle changed to:", value)
        end
    })
    
    ControlsTab:AddSlider({
        Title = "Speed",
        Description = "Adjust the speed value",
        Min = 0,
        Max = 100,
        Default = 50,
        Rounding = 1,
        Callback = function(value)
            print("Slider value:", value)
        end
    })
    
    ControlsTab:AddDropdown({
        Title = "Select Option",
        Values = {"Option 1", "Option 2", "Option 3", "Option 4"},
        Default = 1,
        Callback = function(value)
            print("Selected:", value)
        end
    })
    
    ControlsTab:AddInput({
        Title = "Text Input",
        Placeholder = "Enter some text...",
        Callback = function(text)
            print("Input text:", text)
        end
    })
    
    ControlsTab:AddKeybind({
        Title = "Toggle Keybind",
        Default = "F",
        Mode = "Toggle",
        Callback = function(state)
            print("Keybind state:", state)
        end
    })
    
    ControlsTab:AddColorpicker({
        Title = "Theme Color",
        Default = Color3.fromRGB(88, 101, 242),
        Callback = function(color)
            print("Color selected:", color)
        end
    })
    
    local MiscTab = Window:AddTab({
        Title = "Misc",
        Icon = "🔧"
    })
    
    MiscTab:AddButton({
        Title = "Show Dialog",
        Callback = function()
            Window:Dialog({
                Title = "Test Dialog",
                Content = "This is a test dialog with multiple buttons.",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed!")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled!")
                        end
                    }
                }
            })
        end
    })
    
    MiscTab:AddButton({
        Title = "Show Notifications",
        Callback = function()
            FluentUI:Notify({
                Title = "Info",
                Content = "This is an info notification.",
                Type = "Info"
            })
            
            wait(1)
            
            FluentUI:Notify({
                Title = "Success",
                Content = "Operation completed successfully!",
                Type = "Success"
            })
            
            wait(1)
            
            FluentUI:Notify({
                Title = "Warning",
                Content = "This is a warning message.",
                Type = "Warning"
            })
            
            wait(1)
            
            FluentUI:Notify({
                Title = "Error",
                Content = "An error has occurred!",
                Type = "Error"
            })
        end
    })
    
    return Window
end

return FluentUI
