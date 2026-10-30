
--==================================================
-- ANIME BLUE HUB V3
-- Anime Blue Mobile Edition
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Blue = Color3.fromRGB(65, 165, 255)
local Dark = Color3.fromRGB(10, 18, 35)
local Panel = Color3.fromRGB(20, 34, 58)
local White = Color3.fromRGB(235, 245, 255)

local Hub = Instance.new("ScreenGui")
Hub.Name = "AnimeBlueHubV3"
Hub.ResetOnSpawn = false
Hub.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(310, 350)
Main.Position = UDim2.new(0.5, -155, 0.5, -175)
Main.BackgroundColor3 = Dark
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = Hub

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Border = Instance.new("UIStroke")
Border.Color = Blue
Border.Thickness = 1.5
Border.Parent = Main

-- HEADER

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Panel
Header.BorderSizePixel = 0
Header.Parent = Main

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "✦ ANIME BLUE HUB"
Title.TextColor3 = Blue
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local function button(parent, text, size, position)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = Panel
    b.Text = text
    b.TextColor3 = White
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Parent = parent

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)

    return b
end

local Close = button(
    Header, "×",
    UDim2.fromOffset(30, 30),
    UDim2.new(1, -36, 0, 7)
)

local Minimize = button(
    Header, "−",
    UDim2.fromOffset(30, 30),
    UDim2.new(1, -70, 0, 7)
)

-- DRAG

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- SIDEBAR

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, -55)
Sidebar.Position = UDim2.fromOffset(7, 50)
Sidebar.BackgroundTransparency = 1
Sidebar.Parent = Main

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.Parent = Sidebar

-- CONTENT

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -118, 1, -60)
Content.Position = UDim2.fromOffset(112, 50)
Content.BackgroundColor3 = Panel
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Blue
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.CanvasSize = UDim2.new()
Content.Parent = Main

Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 9)

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Content

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.PaddingLeft = UDim.new(0, 8)
Padding.PaddingRight = UDim.new(0, 8)
Padding.Parent = Content

local function clear()
    for _, v in ipairs(Content:GetChildren()) do
        if v:IsA("GuiObject")
        and v ~= Layout
        and v ~= Padding then
            v:Destroy()
        end
    end
end

local function createLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 34)
    label.BackgroundColor3 = Dark
    label.Text = "  " .. text
    label.TextColor3 = White
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = Content

    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 7)

    return label
end

local function createToggle(name)
    local enabled = false

    local b = button(
        Content,
        name .. " [OFF]",
        UDim2.new(1, -4, 0, 36),
        UDim2.new()
    )

    b.Activated:Connect(function()
        enabled = not enabled

        b.Text = name .. (enabled and " [ON]" or " [OFF]")

        b.BackgroundColor3 = enabled and
            Color3.fromRGB(30, 100, 170) or Dark

        print(name, enabled)
    end)

    return b
end

-- TABS

local function createTab(name, callback)
    local b = button(
        Sidebar,
        name,
        UDim2.new(1, 0, 0, 35),
        UDim2.new()
    )

    b.Activated:Connect(function()
        clear()
        callback()
    end)

    return b
end

createTab("MAIN", function()
    createLabel("PLAYER INFORMATION")
    createLabel("Name: " .. Player.Name)
    createLabel("Level: " ..
        tostring(Player:GetAttribute("Level") or 1))

    createLabel("FRUIT INFORMATION")
    createLabel("Fruit: " ..
        tostring(Player:GetAttribute("EquippedFruit") or "None"))
end)

createTab("FARM", function()
    createLabel("AUTO FARM SYSTEM")
    createToggle("Auto Farm Level")
    createToggle("Auto Farm Boss")
    createToggle("Auto Farm Chest")
end)

createTab("RAID", function()
    createLabel("RAID SYSTEM")
    createToggle("Auto Raid")
    createLabel("Raid Progress: " ..
        tostring(Player:GetAttribute("RaidProgress") or 0))
end)

createTab("FRUIT", function()
    createLabel("FRUIT TRACKER")
    createLabel("Equipped: " ..
        tostring(Player:GetAttribute("EquippedFruit") or "None"))
    createLabel("Inventory: " ..
        tostring(Player:GetAttribute("FruitInventory") or "Empty"))
end)

createTab("QUEST", function()
    createLabel("QUEST TRACKER")
    createLabel("Quest: " ..
        tostring(Player:GetAttribute("QuestName") or "None"))
    createLabel("Progress: " ..
        tostring(Player:GetAttribute("QuestProgress") or 0))
end)

createTab("MASTERY", function()
    createLabel("MASTERY TRACKER")
    createLabel("Weapon: " ..
        tostring(Player:GetAttribute("MasteryName") or "None"))
    createLabel("Mastery: " ..
        tostring(Player:GetAttribute("Mastery") or 0))
end)

createTab("SETTINGS", function()
    createLabel("ANIME BLUE SETTINGS")
    createLabel("Version: 3.0")
    createLabel("Theme: Blue")
    createLabel("Layout: Compact")
    createLabel("Platform: Android")
end)

-- DEFAULT TAB

createLabel("WELCOME TO ANIME BLUE")
createLabel("Player: " .. Player.Name)
createLabel("Version: 3.0")

-- MINIMIZE

local minimized = false

Minimize.Activated:Connect(function()
    minimized = not minimized

    Sidebar.Visible = not minimized
    Content.Visible = not minimized

    Main:TweenSize(
        minimized and UDim2.fromOffset(310, 45)
        or UDim2.fromOffset(310, 350),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.15,
        true
    )
end)

-- CLOSE

Close.Activated:Connect(function()
    Hub:Destroy()
end)

print("Anime Blue Hub V3 Loaded!")
