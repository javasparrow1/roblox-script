local library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/javasparrow1/roblox-script/refs/heads/main/ui/0x-ui.lua"))()

local lobby = library:Window("lobby")
local main = library:Window("main")

lobby:Button("Unlock All Plants", function()
    local plants = {
        "CabbagePult",
        "Chomper",
        "FirePeashooter",
        "KernelPult",
        "MelonPult",
        "PotatoMine",
        "CandyPea",
        "ElectricPeashooter",
        "GatlingPea",
        "GiftSunflower",
        "SnowPea",
        "PuffShroom",
        "Repeater",
        "SunShroom",
        "Sunflower",
        "TwinSunflower",
        "BonkChoy",
        "Endurian",
        "IcebergLettuce",
        "ExplodeONut",
        "WallNut"
    }

    local delay = 0.1
    local stopped = false

    for i = 1, #plants do
        if stopped then break end
        local args = { plants[i] }
        game:GetService("ReplicatedStorage").Events.UnlockPremiumPlant:FireServer(unpack(args))
        if plants[i] == "WallNut" then
            stopped = true
        else
            wait(delay)
        end
    end
end)

lobby:Button("Member Tag", function()
    local args = {
        [1] = "Member"
    }
    
    game:GetService("ReplicatedStorage").Events.RequestPlayerTags:FireServer(unpack(args))
end)

lobby:Button("SpecialMember Tag", function()
    local args = {
        [1] = "SpecialMember"
    }
    
    game:GetService("ReplicatedStorage").Events.RequestPlayerTags:FireServer(unpack(args))
end)

lobby:Button("VIP Tag", function()
    local args = {
        [1] = "VIP"
    }
    
    game:GetService("ReplicatedStorage").Events.RequestPlayerTags:FireServer(unpack(args))
end)

lobby:Button("Developer Tag", function()
    local args = {
        [1] = "Developer"
    }
    
    game:GetService("ReplicatedStorage").Events.RequestPlayerTags:FireServer(unpack(args))
end)

main:Button("SnowPea Spawn(175)", function()
    local args = {
        [1] = "SnowPea",
        [2] = CFrame.new(203, 2.5129995346069336, -31.5) * CFrame.Angles(-0, 0, -0)
    }
    game:GetService("ReplicatedStorage").Functions.Spawn_Plant:InvokeServer(unpack(args))
end)

main:Button("RepeatShroom Spawn(500)", function()
    local args = {
        [1] = "RepeatShroom",
        [2] = CFrame.new(203, 2.5129995346069336, -28) * CFrame.Angles(-0, 0, -0)
    }
    game:GetService("ReplicatedStorage").Functions.Spawn_Plant:InvokeServer(unpack(args))
end)

main:Button("MegaGatlingSnowPea Spawn(1200)", function()
    local args = {
        [1] = "MegaGatlingSnowPea",
        [2] = CFrame.new(203, 2.5129995346069336, -25.5) * CFrame.Angles(-0, 0, -0)
    }
    game:GetService("ReplicatedStorage").Functions.Spawn_Plant:InvokeServer(unpack(args))
end)

main:Button("FlowerPot Spawn(500)", function()
    local args = {
        [1] = "FlowerPot",
        [2] = CFrame.new(203, 2.5129995346069336, -22) * CFrame.Angles(-0, 0, -0)
    }
    game:GetService("ReplicatedStorage").Functions.Spawn_Plant:InvokeServer(unpack(args))
end)

main:Button("Wave Skip", function()
    local players = #game:GetService("Players"):GetPlayers()
    local timerText = game:GetService("Players").LocalPlayer.PlayerGui.GameGUI.Timer.Text
    if timerText ~= "00:00" then
        local args = { [1] = "Skip" }
        if players >= 3 then
            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
            wait(0.01)
            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
        else
            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
        end
    end
end)
