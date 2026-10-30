
-- ANIME BLUE HUB
-- Lightweight Mobile GUI
-- For your own Roblox experience

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AnimeBlueHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(270, 300)
main.Position = UDim2.new(0.5, -135, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(12, 20, 39)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(55, 145, 255)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 42)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "✦ ANIME BLUE HUB"
title.TextColor3 = Color3.fromRGB(110, 190, 255)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -38, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(35, 70, 120)
close.Text = "×"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

local line = Instance.new("Frame")
line.Size = UDim2.new(1, -20, 0, 1)
line.Position = UDim2.fromOffset(10, 43)
line.BackgroundColor3 = Color3.fromRGB(45, 110, 180)
line.BorderSizePixel = 0
line.Parent = main

local menu = Instance.new("Frame")
menu.Size = UDim2.new(1, -20, 1, -60)
menu.Position = UDim2.fromOffset(10, 52)
menu.BackgroundTransparency = 1
menu.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = menu

local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(24, 43, 75)
    button.Text = "  ✦  " .. name
    button.TextColor3 = Color3.fromRGB(220, 235, 255)
    button.TextSize = 13
    button.Font = Enum.Font.GothamMedium
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = true
    button.Parent = menu

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    button.Activated:Connect(callback)
    return button
end

createButton("Player Information", function()
    print("Player:", player.Name)
end)

createButton("Fruit Information", function()
    print("Fruit Information selected")
end)

createButton("Quest Guide", function()
    print("Quest Guide selected")
end)

createButton("Island Guide", function()
    print("Island Guide selected")
end)

createButton("Settings", function()
    print("Settings selected")
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

print("Anime Blue Hub Loaded!")
