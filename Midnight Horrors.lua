local library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/javasparrow1/roblox-script/refs/heads/main/ui/0x-ui.lua"))()

local main = library:Window("main")

main:Button("Killer esp", function()
    local npcFolder = workspace:FindFirstChild("Killer Storage")
    local highlightColor = Color3.fromRGB(255, 0, 0)
    
    local function addESP(npc)
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if not hrp then
            for _, part in ipairs(npc:GetChildren()) do
                if part:IsA("BasePart") then
                    hrp = part
                    break
                end
            end
        end
        if not hrp then return end
        if npc:FindFirstChild("ESP_Highlight") then return end
    
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.Adornee = npc
        highlight.FillColor = highlightColor
        highlight.OutlineColor = highlightColor
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = npc
    
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Label"
        billboard.Size = UDim2.new(25, 0, 7, 0)  -- 2.5倍に拡大
        billboard.StudsOffset = Vector3.new(0, 12, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 10000
        billboard.Parent = hrp
    
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Text = npc.Name
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextScaled = true
        nameLabel.Parent = billboard
    
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.TextColor3 = Color3.new(1, 1, 1)
        distanceLabel.TextStrokeTransparency = 0
        distanceLabel.Text = ""
        distanceLabel.Font = Enum.Font.SourceSansBold
        distanceLabel.TextScaled = true
        distanceLabel.Parent = billboard
    
        local updateConn
        updateConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not npc.Parent or not hrp.Parent then
                if updateConn then updateConn:Disconnect() end
                return
            end
            local player = game.Players.LocalPlayer
            if player and player.Character then
                local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
                if playerHRP then
                    local dist = (hrp.Position - playerHRP.Position).Magnitude
                    distanceLabel.Text = string.format("%.1f studs", dist)
                    local minDist, maxDist = 10, 1000
                    local minScale, maxScale = 2.5, 20
                    local t = math.clamp((dist - minDist) / (maxDist - minDist), 0, 1)
                    local scale = minScale + (maxScale - minScale) * t
                    billboard.Size = UDim2.new(scale * 3, 0, scale, 0)
                    nameLabel.TextSize = math.min(32 * scale * 2.5, 100)
                    distanceLabel.TextSize = math.min(28 * scale * 2.5, 100)
                end
            end
        end)
    end
    
    local function updateAllNPCs()
        if not npcFolder then return end
        for _, npc in ipairs(npcFolder:GetChildren()) do
            if npc:IsA("Model") then
                local hasPart = false
                for _, child in ipairs(npc:GetChildren()) do
                    if child:IsA("BasePart") then
                        hasPart = true
                        break
                    end
                end
                if hasPart then
                    addESP(npc)
                end
            end
        end
    end
    
    if npcFolder then
        npcFolder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                local hasPart = false
                for _, c in ipairs(child:GetChildren()) do
                    if c:IsA("BasePart") then
                        hasPart = true
                        break
                    end
                end
                if hasPart then
                    addESP(child)
                end
            end
        end)
    end
    
    game:GetService("RunService").RenderStepped:Connect(function()
        updateAllNPCs()
    end)
    
end)

main:Button("no fog", function()
    local Lighting = game:GetService("Lighting")
    Lighting.FogEnd = 100000
    for i,v in pairs(Lighting:GetDescendants()) do
        if v:IsA("Atmosphere") then
            v:Destroy()
        end
    end    
end)

main:Button("停電解除", function()
    local Lighting = game:GetService("Lighting")
    Lighting.TimeOfDay = "12:00:00"
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.Brightness = 2
end)
