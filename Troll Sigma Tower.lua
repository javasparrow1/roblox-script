local function VoidSlap(isVoid)
    if isVoid then
        return Vector3.new(8.398977279663086, -999999, -5.427446365356445)
    else
        return Vector3.new(8.398977279663086, 2.2562765877864877e-07, -5.427446365356445)
    end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local actionName = "slash"
local isVoid = false
local running = false
local attackThread = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoSlapGUI"
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundTransparency = 1
title.Text = "Auto Slap"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 26)
toggle.Position = UDim2.new(0, 10, 0, 32)
toggle.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
toggle.Text = "OFF"
toggle.Font = Enum.Font.SourceSans
toggle.TextSize = 18
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Parent = frame

local function ensureSecretSlapEquipped()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local character = LocalPlayer.Character
    if not backpack or not character then return false end
    if character:FindFirstChild("SecretSlap") then
        return true
    end
    if backpack:FindFirstChild("SecretSlap") then
        backpack.SecretSlap.Parent = character
        return true
    end
    local args = { "SecretSlap" }
    ReplicatedStorage.Z:FireServer(unpack(args))
    local timeout = 3
    local start = tick()
    while tick() - start < timeout do
        if backpack:FindFirstChild("SecretSlap") then
            backpack.SecretSlap.Parent = character
            return true
        end
        task.wait(0.1)
    end
    return character:FindFirstChild("SecretSlap") ~= nil
end

local function attackLoop()
    while running do
        if ensureSecretSlapEquipped() then
            local targets = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    table.insert(targets, player)
                end
            end
            for _, player in ipairs(targets) do
                if not running then return end
                if player.Character then
                    local position = VoidSlap(isVoid)
                    local args = { actionName, player.Character, position }
                    LocalPlayer.Character.SecretSlap.Event:FireServer(unpack(args))
                    task.wait(0.01)
                end
            end
        else
            task.wait(0.5)
        end
    end
end

local function startAutoSlap()
    if not running then return end
    if attackThread and coroutine.status(attackThread) ~= "dead" then
        return
    end
    attackThread = coroutine.create(attackLoop)
    coroutine.resume(attackThread)
end

toggle.MouseButton1Click:Connect(function()
    running = not running
    toggle.Text = running and "ON" or "OFF"
    toggle.BackgroundColor3 = running and Color3.fromRGB(180, 80, 80) or Color3.fromRGB(80, 180, 80)
    if running then
        startAutoSlap()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    if running then
        task.wait(1)
        startAutoSlap()
    end
end)
