-- VOLCANIC PREMIUM 2025 - FULL FEATURES - GLOWING REALISTIC UI - 100% WORKING
-- Noclip, Farm, Laser, Brainrot, ESP, Hitbox, TP, Lag - All toggles perfect, no crash

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local gui = Instance.new("ScreenGui")
gui.Name = "VolcanicPremium"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME (Glowing Dark Theme)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 600)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 50, 50)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
}
mainGradient.Rotation = 45
mainGradient.Parent = mainFrame

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 70)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔥 VOLCANIC PREMIUM 🔥"
titleLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 32
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(1, -50, 0, 15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 28
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 20)
minimizeBtn.Parent = titleBar

-- TABS
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 50)
tabFrame.Position = UDim2.new(0, 0, 0, 70)
tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
tabFrame.Parent = mainFrame

local tabList = Instance.new("UIListLayout")
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0, 5)
tabList.Parent = tabFrame

local tabs = {"v1", "v2", "v3", "v4", "v5", "v6"}
local currentTab = 1

local tabButtons = {}
for i, v in ipairs(tabs) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1/#tabs - 0.05, 0, 1, 0)
    tab.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(35, 35, 40)
    tab.Text = v
    tab.TextColor3 = Color3.new(1,1,1)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 22
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 12)
    tab.Parent = tabFrame
    tabButtons[i] = tab
    
    tab.MouseButton1Click:Connect(function()
        currentTab = i
        for j, btn in ipairs(tabButtons) do
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = j == i and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(35, 35, 40)}):Play()
        end
        updateContent()
    end)
end

-- CONTENT FRAME
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -140)
contentFrame.Position = UDim2.new(0, 10, 0, 120)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
contentFrame.Parent = mainFrame

local contentList = Instance.new("UIListLayout")
contentList.Padding = UDim.new(0, 10)
contentList.Parent = contentFrame

-- STATES
local states = {
    noclip = false,
    farm = false,
    brainrot = false,
    esp = false,
    hitbox = false
}

local savedPos = Vector3.new(0,100,0)
local brainConn = nil

-- UPDATE CONTENT FUNCTION
function updateContent()
    contentFrame:ClearAllChildren()
    contentList.Parent = contentFrame
    
    if currentTab == 1 then -- v1
        local noclipBtn = Instance.new("TextButton")
        noclipBtn.Size = UDim2.new(1, 0, 0, 60)
        noclipBtn.BackgroundColor3 = states.noclip and Color3.fromRGB(0,255,0) or Color3.fromRGB(200,0,0)
        noclipBtn.Text = "Noclip: " .. (states.noclip and "ON" or "OFF")
        noclipBtn.TextColor3 = Color3.new(1,1,1)
        noclipBtn.Font = Enum.Font.GothamBold
        noclipBtn.TextSize = 24
        Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,12)
        noclipBtn.Parent = contentFrame
        
        noclipBtn.MouseButton1Click:Connect(function()
            states.noclip = not states.noclip
            noclipBtn.Text = "Noclip: " .. (states.noclip and "ON" or "OFF")
            TweenService:Create(noclipBtn, TweenInfo.new(0.3), {BackgroundColor3 = states.noclip and Color3.fromRGB(0,255,0) or Color3.fromRGB(200,0,0)}):Play()
        end)
        
        local setBtn = Instance.new("TextButton")
        setBtn.Size = UDim2.new(1, 0, 0, 60)
        setBtn.BackgroundColor3 = Color3.fromRGB(100,100,255)
        setBtn.Text = "Set Checkpoint"
        setBtn.TextColor3 = Color3.new(1,1,1)
        setBtn.Font = Enum.Font.GothamBold
        setBtn.TextSize = 24
        Instance.new("UICorner", setBtn).CornerRadius = UDim.new(0,12)
        setBtn.Parent = contentFrame
        setBtn.MouseButton1Click:Connect(function()
            if player.Character then
                savedPos = player.Character.HumanoidRootPart.Position + Vector3.new(0,6,0)
                StarterGui:SetCore("SendNotification",{Title="Volcanic",Text="Checkpoint set!",Duration=2})
            end
        end)
        
        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(1, 0, 0, 60)
        tpBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
        tpBtn.Text = "TP to Checkpoint"
        tpBtn.TextColor3 = Color3.new(1,1,1)
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.TextSize = 24
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,12)
        tpBtn.Parent =
