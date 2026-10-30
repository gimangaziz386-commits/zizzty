
-- ANIME BLUE HUB | TRACKER EDITION

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AnimeBlueHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local screen = Instance.new("Frame")
screen.Size = UDim2.fromOffset(290, 360)
screen.Position = UDim2.new(0.5, -145, 0.5, -180)
screen.BackgroundColor3 = Color3.fromRGB(10, 22, 48)
screen.Parent = gui

Instance.new("UICorner", screen).CornerRadius = UDim.new(0, 14)

local border = Instance.new("UIStroke", screen)
border.Color = Color3.fromRGB(30, 145, 255)
border.Thickness = 2

local function label(text, y, height)
    local obj = Instance.new("TextLabel")
    obj.Size = UDim2.new(1, -20, 0, height)
    obj.Position = UDim2.fromOffset(10, y)
    obj.BackgroundTransparency = 1
    obj.TextColor3 = Color3.fromRGB(120, 205, 255)
    obj.Text = text
    obj.Font = Enum.Font.GothamBold
    obj.TextSize = 15
    obj.Parent = screen
    return obj
end

local function button(text, y)
    local obj = Instance.new("TextButton")
    obj.Size = UDim2.new(1, -20, 0, 38)
    obj.Position = UDim2.fromOffset(10, y)
    obj.BackgroundColor3 = Color3.fromRGB(25, 75, 135)
    obj.TextColor3 = Color3.new(1, 1, 1)
    obj.Text = text
    obj.Font = Enum.Font.GothamBold
    obj.TextSize = 13
    obj.Parent = screen
    Instance.new("UICorner", obj).CornerRadius = UDim.new(0, 8)
    return obj
end

label("⚡ ANIME BLUE HUB", 10, 30)
local timer = label("Session: 00:00", 45, 25)
local level = label("Level: 1", 80, 25)
local mastery = label("Mastery: 0", 110, 25)
local notes = label("Tracker siap digunakan!", 270, 55)

local levelButton = button("+ Level", 150)
local masteryButton = button("+ Mastery", 195)
local resetButton = button("Reset Tracker", 240)
local closeButton = button("CLOSE", 325)

local currentLevel = 1
local currentMastery = 0
local seconds = 0

levelButton.MouseButton1Click:Connect(function()
    currentLevel += 1
    level.Text = "Level: " .. currentLevel
    notes.Text = "Level berhasil diperbarui!"
end)

masteryButton.MouseButton1Click:Connect(function()
    currentMastery += 1
    mastery.Text = "Mastery: " .. currentMastery
    notes.Text = "Mastery berhasil diperbarui!"
end)

resetButton.MouseButton1Click:Connect(function()
    currentLevel = 1
    currentMastery = 0
    level.Text = "Level: 1"
    mastery.Text = "Mastery: 0"
    notes.Text = "Tracker berhasil direset!"
end)

task.spawn(function()
    while gui.Parent do
        task.wait(1)
        seconds += 1
        timer.Text = string.format(
            "Session: %02d:%02d",
            math.floor(seconds / 60),
            seconds % 60
        )
    end
end)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
