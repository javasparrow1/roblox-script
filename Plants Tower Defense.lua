local library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/javasparrow1/roblox-script/refs/heads/main/ui/0x-ui.lua"))()

local lobby = library:Window("lobby")
local main = library:Window("main")

lobby:Button("Get all plants", function()
    local seeds = {
        "CabbagePult",
        "Chomper",
        "FirePeashooter",
        "KernelPult",
        "MelonPult",
        "PotatoMine",
        "PuffShroom",
        "Repeater",
        "SunShroom",
        "Sunflower",
        "TwinSunflower",
        "WallNut"
    }

    local delay = 0.1
    local stopped = false

    for i = 1, #seeds do
        if stopped then break end
        game:GetService("ReplicatedStorage").Events.UpdatePlayerSeeds:FireServer(seeds[i], 150)
        if seeds[i] == "WallNut" then
            stopped = true
        else
            wait(delay)
        end
    end
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
        local args = {
            [1] = "Skip"
        }
        if players >= 3 then

            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
            wait(0.01)
            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
        else
            game:GetService("ReplicatedStorage").Events.VoteSkipEvent:FireServer(unpack(args))
        end
    end
end)
