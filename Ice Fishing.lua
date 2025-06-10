local SparrLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/javasparrow1/roblox-script/refs/heads/main/ui/sparrows-ui.lua"))()

local Window = SparrLib:CreateWindow({
    Title = "Ice Fisching Script", 
    Size = UDim2.new(0, 400, 0, 300)
})

local MainTab = Window:CreateTab("Main")
local buyTab = Window:CreateTab("buy")

local MainSection = MainTab:AddSection("Main")
local TeleportSection = MainTab:AddSection("Teleport")
local rodSection = buyTab:AddSection("rod")

local autoFishEnabled = false
local autoSellEnabled = false

local aToggle = MainSection:AddToggle("Auto fish", false, function(value)
    autoFishEnabled = value
    if autoFishEnabled then
        startAutoFish()
    end
end)

local sellToggle = MainSection:AddToggle("Auto sell (Other than 1~9)", false, function(value)
    autoSellEnabled = value
    if autoSellEnabled then
        startAutoSell()
    end
end)

local aButton = MainSection:AddButton("All code", function()
    local codes = { "1KLIKE", "2KLIKE", "3KLIKE", "4KLIKE", "5KLIKE", "6KLIKE", "WELCOME", "M4YUP3ATE" }
    for _, code in ipairs(codes) do
        local args = {
            [1] = 2073358730,
            [2] = code
        }
        game:GetService("ReplicatedStorage").Remote.RemoteEvent:FireServer(unpack(args))
    end
end)

local aButton = TeleportSection:AddButton("House", function()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-1965.9681396484375, 49.9720344543457, 2182.21728515625)
    end
end)

local aButton = TeleportSection:AddButton("Smithy", function()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-1902.2081298828125, 53.68596649169922, 2079.948486328125)
    end
end)

local aButton = TeleportSection:AddButton("bridge", function()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-2019.1195068359375, 51.38005065917969, 1966.832763671875)
    end
end)

local rodItems = {
    {name = "Rustic Pine Rod $0", id = 2001},
    {name = "Ironclad Reel $1", id = 2002},
    {name = "Gilded Abyss Hunter $1", id = 2003},
    {name = "Frostbite Spire $1", id = 2004},
    {name = "Emberfloe Devourer $1", id = 2005},
    {name = "Glowspine Angler $1", id = 2006},
    {name = "Bamboo Whisper $1", id = 2007},
    {name = "Eldertree's Vein $1", id = 2008},
    {name = "Desert Spine $1", id = 2009},
    {name = "Kraken's Bane $1", id = 2010},
    {name = "Prism Serpent $1", id = 2011},
    {name = "Stardust Lancer $1", id = 2012},
    {name = "Monarch's Proboscis $1", id = 2013}
}

for _, item in ipairs(rodItems) do
    rodSection:AddButton(item.name, function()
        local args = {
            [1] = 4125519940,
            [2] = item.id,
            [3] = 0.0000000000001,
            [4] = 1001
        }
        game:GetService("ReplicatedStorage").Remote.RemoteEvent:FireServer(unpack(args))
    end)
end

function startAutoFish()
    spawn(function()
        while autoFishEnabled do
            local args1 = {
                [1] = "TrigerSkill",
                [2] = "Fish",
                [3] = "Enter"
            }
            game:GetService("ReplicatedStorage").Remote.PlayerReplicated:FireServer(unpack(args1))

            local fishFrame = game:GetService("Players").LocalPlayer.PlayerGui.FishPanel.Main.Fish
            local startTime = tick()
            repeat
                wait()
            until fishFrame.Visible or tick() - startTime >= 30

            if not fishFrame.Visible then
                game:GetService("ReplicatedStorage").Remote.PlayerReplicated:FireServer(unpack(args1))
            else
                wait(0.1)
                local args2 = {
                    [1] = 1112256688,
                    [2] = true
                }
                game:GetService("ReplicatedStorage").Remote.RemoteEvent:FireServer(unpack(args2))
                fishFrame.Visible = false
                wait(1)
            end
        end
    end)
end

function startAutoSell()
    spawn(function()
        while autoSellEnabled do
            local args1 = {
                [1] = 1083462120,
                [2] = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36}
            }
            game:GetService("ReplicatedStorage").Remote.RemoteEvent:FireServer(unpack(args1))
            wait(1)
            local args2 = {
                [1] = 2038610031
            }
            game:GetService("ReplicatedStorage").Remote.RemoteEvent:FireServer(unpack(args2))
            wait(3)
        end
    end)
end

