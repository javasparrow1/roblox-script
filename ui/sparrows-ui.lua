local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local Theme = {
    Background = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.4,
    Accent = Color3.fromRGB(60, 120, 220),
    AccentHover = Color3.fromRGB(80, 140, 255),
    Section = Color3.fromRGB(20, 20, 30),
    SectionTransparency = 0.2,
    Text = Color3.fromRGB(230, 230, 230),
    SubText = Color3.fromRGB(180, 180, 255),
    Border = Color3.fromRGB(60, 60, 80),
    Toggle = {
        Background = Color3.fromRGB(50, 50, 70),
        Enabled = Color3.fromRGB(60, 220, 120),
        Disabled = Color3.fromRGB(150, 150, 170)
    },
    Slider = {
        Background = Color3.fromRGB(40, 40, 60),
        Fill = Color3.fromRGB(70, 140, 240)
    }
}

local coreGui = nil
local function ensureCoreGui()
    if not coreGui then
        coreGui = Instance.new("ScreenGui")
        coreGui.Name = "SparrowUILibraryCoreGui"
        coreGui.ResetOnSpawn = false
        coreGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        coreGui.Parent = game:GetService("CoreGui")
    end
end

local function makeElementDraggable(element, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = element.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    element.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            element.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Library:CreateWindow(config)
    ensureCoreGui()

    config = config or {}
    local title = config.Title or "Sparrow UI"
    local size = config.Size or UDim2.new(0, 400, 0, 320)
    
    local isMinimized = false
    local originalSize = size
    
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    frame.BackgroundColor3 = Theme.Background
    frame.BackgroundTransparency = Theme.BackgroundTransparency
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = coreGui
    frame.ClipsDescendants = true
    frame.Active = true
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local dropShadow = Instance.new("ImageLabel")
    dropShadow.Size = frame.Size + UDim2.new(0, 30, 0, 30)
    dropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    dropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    dropShadow.Image = "rbxassetid://6014261993"
    dropShadow.BackgroundTransparency = 1
    dropShadow.ImageTransparency = 0.5
    dropShadow.ZIndex = 0
    dropShadow.ScaleType = Enum.ScaleType.Slice
    dropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    dropShadow.Parent = frame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = Theme.Background:Lerp(Color3.new(0, 0, 0), 0.2)
    titleBar.BackgroundTransparency = Theme.BackgroundTransparency - 0.1
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleBarCorner = Instance.new("UICorner", titleBar)
    titleBarCorner.CornerRadius = UDim.new(0, 10)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
    minimizeBtn.Position = UDim2.new(1, -60, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 120)
    minimizeBtn.Text = "-"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 18
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Parent = titleBar
    
    local minimizeBtnCorner = Instance.new("UICorner", minimizeBtn)
    minimizeBtnCorner.CornerRadius = UDim.new(0, 5)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    closeBtn.Text = "x"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Parent = titleBar
    
    local closeBtnCorner = Instance.new("UICorner", closeBtn)
    closeBtnCorner.CornerRadius = UDim.new(0, 5)
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, 0, 1, -36)
    contentContainer.Position = UDim2.new(0, 0, 0, 36)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = frame
    
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            contentContainer.Visible = false
            TweenService:Create(frame, tweenInfo, {
                Size = UDim2.new(0, originalSize.X.Offset, 0, 36)
            }):Play()
            minimizeBtn.Text = "+"
        else
            contentContainer.Visible = true
            TweenService:Create(frame, tweenInfo, {
                Size = originalSize
            }):Play()
            minimizeBtn.Text = "-"
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
        dropShadow.Visible = false
    end)
    
    makeElementDraggable(frame, titleBar)
    
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Size = UDim2.new(1, 0, 0, 36)
    tabsContainer.Position = UDim2.new(0, 0, 0, 4)
    tabsContainer.BackgroundTransparency = 1
    tabsContainer.Parent = contentContainer
    
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -16, 1, -50)
    contentArea.Position = UDim2.new(0, 8, 0, 44)
    contentArea.BackgroundTransparency = 1
    contentArea.ClipsDescendants = true
    contentArea.Parent = contentContainer
    
    local tabFolder = Instance.new("Folder")
    tabFolder.Name = "Tabs"
    tabFolder.Parent = contentArea

    local tabs = {}
    local selectedTab = nil
    local tabCount = 0

    function Library:CreateTab(tabName)
        tabCount = tabCount + 1
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(0, 100, 0, 30)
        tabBtn.Position = UDim2.new(0, 8 + (tabCount-1)*104, 0, 3)
        tabBtn.BackgroundColor3 = Theme.Section
        tabBtn.BackgroundTransparency = Theme.SectionTransparency
        tabBtn.Text = tabName
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 14
        tabBtn.TextColor3 = Theme.Text
        tabBtn.Parent = tabsContainer
        
        local tabBtnCorner = Instance.new("UICorner", tabBtn)
        tabBtnCorner.CornerRadius = UDim.new(0, 6)
        
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.ScrollBarThickness = 4
        tabFrame.Visible = false
        tabFrame.Parent = tabFolder
        tabFrame.ScrollBarImageColor3 = Theme.Accent
        tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local itemsList = Instance.new("UIListLayout")
        itemsList.Padding = UDim.new(0, 8)
        itemsList.SortOrder = Enum.SortOrder.LayoutOrder
        itemsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        itemsList.Parent = tabFrame

        table.insert(tabs, {Button = tabBtn, Frame = tabFrame})

        tabBtn.MouseButton1Click:Connect(function()
            for _, tab in ipairs(tabs) do
                tab.Frame.Visible = false
                tab.Button.BackgroundColor3 = Theme.Section
                tab.Button.BackgroundTransparency = Theme.SectionTransparency
            end
            tabFrame.Visible = true
            tabBtn.BackgroundColor3 = Theme.Accent
            tabBtn.BackgroundTransparency = 0.1
            selectedTab = tabFrame
        end)

        if tabCount == 1 then
            tabBtn.BackgroundColor3 = Theme.Accent
            tabBtn.BackgroundTransparency = 0.1
            tabFrame.Visible = true
            selectedTab = tabFrame
        end

        local tabAPI = {}

        function tabAPI:AddSection(title)
            local section = Instance.new("Frame")
            section.Size = UDim2.new(1, -10, 0, 100)
            section.BackgroundColor3 = Theme.Section
            section.BackgroundTransparency = Theme.SectionTransparency
            section.AutomaticSize = Enum.AutomaticSize.Y
            section.Parent = tabFrame
            
            local sectionCorner = Instance.new("UICorner", section)
            sectionCorner.CornerRadius = UDim.new(0, 8)
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Size = UDim2.new(1, 0, 0, 24)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = title
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextSize = 14
            sectionTitle.TextColor3 = Theme.SubText
            sectionTitle.Parent = section
            
            local itemContainer = Instance.new("Frame")
            itemContainer.Size = UDim2.new(1, -20, 0, 0)
            itemContainer.Position = UDim2.new(0, 10, 0, 30)
            itemContainer.BackgroundTransparency = 1
            itemContainer.AutomaticSize = Enum.AutomaticSize.Y
            itemContainer.Parent = section
            
            local itemsList = Instance.new("UIListLayout")
            itemsList.Padding = UDim.new(0, 6)
            itemsList.SortOrder = Enum.SortOrder.LayoutOrder
            itemsList.Parent = itemContainer

            local sectionAPI = {}

            function sectionAPI:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 20)
                label.BackgroundTransparency = 1
                label.Text = text
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.TextColor3 = Theme.Text
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = itemContainer
                
                local labelAPI = {}
                function labelAPI:UpdateText(newText)
                    label.Text = newText
                end
                
                return labelAPI
            end

            function sectionAPI:AddButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = Theme.Accent
                btn.BackgroundTransparency = 0.2
                btn.Text = text
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 14
                btn.TextColor3 = Theme.Text
                btn.Parent = itemContainer
                
                local btnCorner = Instance.new("UICorner", btn)
                btnCorner.CornerRadius = UDim.new(0, 6)
                
                btn.MouseButton1Down:Connect(function()
                    TweenService:Create(btn, tweenInfo, {BackgroundColor3 = Theme.AccentHover}):Play()
                end)
                
                btn.MouseButton1Up:Connect(function()
                    TweenService:Create(btn, tweenInfo, {BackgroundColor3 = Theme.Accent}):Play()
                end)
                
                btn.MouseButton1Click:Connect(function()
                    if callback then callback() end
                end)
                
                local buttonAPI = {}
                function buttonAPI:UpdateText(newText)
                    btn.Text = newText
                end
                
                return buttonAPI
            end
            
            function sectionAPI:AddToggle(text, default, callback)
                local toggleValue = default or false
                
                local toggleContainer = Instance.new("Frame")
                toggleContainer.Size = UDim2.new(1, 0, 0, 30)
                toggleContainer.BackgroundTransparency = 1
                toggleContainer.Parent = itemContainer
                
                local toggleLabel = Instance.new("TextLabel")
                toggleLabel.Size = UDim2.new(1, -54, 1, 0)
                toggleLabel.BackgroundTransparency = 1
                toggleLabel.Text = text
                toggleLabel.Font = Enum.Font.Gotham
                toggleLabel.TextSize = 14
                toggleLabel.TextColor3 = Theme.Text
                toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                toggleLabel.Parent = toggleContainer
                
                local toggleBtn = Instance.new("Frame")
                toggleBtn.Size = UDim2.new(0, 44, 0, 22)
                toggleBtn.Position = UDim2.new(1, -44, 0.5, -11)
                toggleBtn.BackgroundColor3 = Theme.Toggle.Background
                toggleBtn.Parent = toggleContainer
                
                local toggleBtnCorner = Instance.new("UICorner", toggleBtn)
                toggleBtnCorner.CornerRadius = UDim.new(1, 0)
                
                local toggleCircle = Instance.new("Frame")
                toggleCircle.Size = UDim2.new(0, 16, 0, 16)
                toggleCircle.Position = UDim2.new(0, 3, 0.5, -8)
                toggleCircle.BackgroundColor3 = toggleValue and Theme.Toggle.Enabled or Theme.Toggle.Disabled
                toggleCircle.Parent = toggleBtn
                
                local toggleCircleCorner = Instance.new("UICorner", toggleCircle)
                toggleCircleCorner.CornerRadius = UDim.new(1, 0)
                
                local toggleClickArea = Instance.new("TextButton")
                toggleClickArea.Size = UDim2.new(1, 0, 1, 0)
                toggleClickArea.BackgroundTransparency = 1
                toggleClickArea.Text = ""
                toggleClickArea.Parent = toggleContainer
                
                local function updateToggle()
                    local targetPos = toggleValue and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                    local targetColor = toggleValue and Theme.Toggle.Enabled or Theme.Toggle.Disabled
                    
                    TweenService:Create(toggleCircle, tweenInfo, {
                        Position = targetPos,
                        BackgroundColor3 = targetColor
                    }):Play()
                    
                    if callback then
                        callback(toggleValue)
                    end
                end
                
                updateToggle()
                
                toggleClickArea.MouseButton1Click:Connect(function()
                    toggleValue = not toggleValue
                    updateToggle()
                end)
                
                local toggleAPI = {}
                
                function toggleAPI:Set(value)
                    if toggleValue ~= value then
                        toggleValue = value
                        updateToggle()
                    end
                end
                
                function toggleAPI:Get()
                    return toggleValue
                end
                
                return toggleAPI
            end
            
            function sectionAPI:AddSlider(text, minVal, maxVal, defaultVal, precision, callback)
                local sliderValue = defaultVal or minVal
                precision = precision or 1
                
                local sliderContainer = Instance.new("Frame")
                sliderContainer.Size = UDim2.new(1, 0, 0, 50)
                sliderContainer.BackgroundTransparency = 1
                sliderContainer.Parent = itemContainer
                
                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Text = text
                sliderLabel.Font = Enum.Font.Gotham
                sliderLabel.TextSize = 14
                sliderLabel.TextColor3 = Theme.Text
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                sliderLabel.Parent = sliderContainer
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Size = UDim2.new(0, 50, 0, 20)
                valueLabel.Position = UDim2.new(1, -50, 0, 0)
                valueLabel.BackgroundTransparency = 1
                valueLabel.Text = tostring(sliderValue)
                valueLabel.Font = Enum.Font.GothamBold
                valueLabel.TextSize = 14
                valueLabel.TextColor3 = Theme.Text
                valueLabel.Parent = sliderContainer
                
                local sliderBg = Instance.new("Frame")
                sliderBg.Size = UDim2.new(1, 0, 0, 10)
                sliderBg.Position = UDim2.new(0, 0, 0, 30)
                sliderBg.BackgroundColor3 = Theme.Slider.Background
                sliderBg.BackgroundTransparency = 0.2
                sliderBg.Parent = sliderContainer
                
                local sliderBgCorner = Instance.new("UICorner", sliderBg)
                sliderBgCorner.CornerRadius = UDim.new(0, 5)
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Size = UDim2.new((sliderValue - minVal) / (maxVal - minVal), 0, 1, 0)
                sliderFill.BackgroundColor3 = Theme.Slider.Fill
                sliderFill.Parent = sliderBg
                
                local sliderFillCorner = Instance.new("UICorner", sliderFill)
                sliderFillCorner.CornerRadius = UDim.new(0, 5)
                
                local sliderBtn = Instance.new("TextButton")
                sliderBtn.Size = UDim2.new(1, 0, 1, 0)
                sliderBtn.BackgroundTransparency = 1
                sliderBtn.Text = ""
                sliderBtn.Parent = sliderBg
                
                local function updateSlider(value)
                    value = math.clamp(value, minVal, maxVal)
                    value = math.floor(value * 10^precision) / 10^precision
                    
                    sliderValue = value
                    valueLabel.Text = tostring(value)
                    
                    local percent = (value - minVal) / (maxVal - minVal)
                    TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                        Size = UDim2.new(percent, 0, 1, 0)
                    }):Play()
                    
                    if callback then
                        callback(value)
                    end
                end
                
                updateSlider(sliderValue)
                
                local dragging = false
                
                sliderBtn.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mousePos = UserInputService:GetMouseLocation().X
                        local sliderPos = sliderBg.AbsolutePosition.X
                        local sliderWidth = sliderBg.AbsoluteSize.X
                        
                        local relativePos = math.clamp(mousePos - sliderPos, 0, sliderWidth)
                        local percent = relativePos / sliderWidth
                        
                        local value = minVal + (maxVal - minVal) * percent
                        updateSlider(value)
                    end
                end)
                
                local sliderAPI = {}
                
                function sliderAPI:Set(value)
                    updateSlider(value)
                end
                
                function sliderAPI:Get()
                    return sliderValue
                end
                
                return sliderAPI
            end
            
            return sectionAPI
        end

        return tabAPI
    end

    return Library
end

return Library
