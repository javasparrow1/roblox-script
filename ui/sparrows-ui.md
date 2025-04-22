## Load Library
```lua
local SparrLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/javasparrow1/roblox-script/refs/heads/main/ui/sparrows-ui.lua"))()
```

## Creating a Window
```lua
local Window = SparrLib:CreateWindow({
    Title = "Window Title", 
    Size = UDim2.new(0, 400, 0, 300)
})

```

## Creating a Tab
```lua
local MainTab = Window:CreateTab("Tab Name")
```

## Creating a Section
```lua
local MainSection = MainTab:AddSection("Section Name")
```

## Creating a Label
```lua
local aLabel = MainSection:AddLabel("Label text")

--[[
Changing the value of an existing label
aLabel:UpdateText("New Label text")
]]
```

## Creating a Button
```lua
local aButton = MainSection:AddButton("Button text", function()
    print("Hello")
end)

--[[
Changing the value of an existing Butoon
aButton:UpdateText("New Button text")
]]
```

## Creating a toggle
```lua
local aToggle = MainSection:AddToggle("toggle text", false, function(value)
    print("toggle:", value)
end)

--[[
Changing the value of an existing Toggle
aToggle:Set(true)
]]
```

## Creating a Slider
```lua
local aSlider = MainSection:AddSlider("Slider tsxt", 0, 100, 50, 1, function(value) -- Minimum, maximum, default value, precision
    print("Slider:", value)
end)

--[[
Change Slider Value
aSlider:Set(75)
]]
```
