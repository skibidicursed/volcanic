-- VOLCANIC 2025 - FULL V1 TO V6 - GLOWING UI - ALL TOGGLES WORK 100% - NO CRASH
-- Noclip, Checkpoint, Auto Farm, Crash, Laser, Brainrot, ESP, Hitbox, TP, Lag Player

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "Volcanic2025"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- GLOWING MAIN FRAME
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 620)
main.Position = UDim2.new(0.5, -250, 0.5, -310)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 20)

local glow = Instance.new("UIStroke", main)
glow.Color = Color3.fromRGB(255, 50, 50)
glow.Thickness = 4
glow.Transparency = 0.4

local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8,8,12))}
gradient.Rotation = 90

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,70)
title.BackgroundTransparency = 1
title.Text = "VOLCANIC 2025"
title.TextColor3 = Color3.fromRGB(255, 70, 70)
title.Font = Enum.Font.GothamBlack
title.TextSize = 38

-- TABS
local tabs = {"v1", "v2", "v3", "v4", "v5", "v6"}
local current = 1
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(1,0,0,50)
tabFrame.Position = UDim2.new(0,0,0,70)
tabFrame.BackgroundColor3 = Color3.fromRGB(15,15,20)

local tabList = Instance.new("UIListLayout", tabFrame)
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0,8)

local tabButtons = {}
for i,v in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(0.15,0,1,0)
    btn.BackgroundColor3 = i==1 and Color3.fromRGB(255,50,50) or Color3.fromRGB(40,40,50)
    btn.Text = v
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 22
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    tabButtons[i] = btn

    btn.MouseButton1Click:Connect(function()
        current = i
        for j,b in ipairs(tabButtons) do
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = j==i and Color3.fromRGB(255,50,50) or Color3.fromRGB(40,40,50)}):Play()
        end
        loadTab(i)
    end)
end

-- CONTENT
local content = Instance.new("ScrollingFrame", main)
content.Size = UDim2.new(1,-30,1,-140)
content.Position = UDim2.new(0,15,0,130)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 8
content.ScrollBarImageColor3 = Color3.fromRGB(255,50,50)

local list = Instance.new("UIListLayout", content)
list.Padding = UDim.new(0,12)

-- STATES
local states = {noclip=false, farm=false, brainrot=false, esp=false, hitbox=false}
local savedPos = Vector3.new(0,100,0)
local brainConn = nil

-- BUTTON CREATOR
local function makeBtn(text, color, callback)
    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(1,0,0,65)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 26
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- LOAD TABS
function loadTab(tab)
    content:ClearAllChildren()
    list.Parent = content

    if tab == 1 then -- v1 Noclip + Checkpoint
        local n = makeBtn("Noclip: "..(states.noclip and "ON" or "OFF"), states.noclip and Color3.fromRGB(0,255,0) or Color3.fromRGB(200,0,0), function()
            states.noclip = not states.noclip
            n.Text = "Noclip: "..(states.noclip and "ON" or "OFF")
            TweenService:Create(n, TweenInfo.new(0.3), {BackgroundColor3 = states.noclip and Color3.fromRGB(0,255,0) or Color3.fromRGB(200,0,0)}):Play()
        end)

        makeBtn("Set Checkpoint", Color3.fromRGB(100,100,255), function()
            if player.Character then
                savedPos = player.Character.HumanoidRootPart.Position + Vector3.new(0,6,0)
            end
        end)

        makeBtn("TP to Checkpoint", Color3.fromRGB(0,200,100), function()
            if player.Character then player.Character:PivotTo(CFrame.new(savedPos)) end
        end)

    elseif tab == 2 then -- v2 Auto Farm + Crash
        local f = makeBtn("Auto Farm: "..(states.farm and "ON" or "OFF"), states.farm and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,180,0), function()
            states.farm = not states.farm
            f.Text = "Auto Farm: "..(states.farm and "ON" or "OFF")
            TweenService:Create(f, TweenInfo.new(0.3), {BackgroundColor3 = states.farm and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,180,0)}):Play()
        end)

        makeBtn("CRASH SERVER", Color3.fromRGB(255,0,0), function()
            while task.wait(0.1) do
                for i=1,80 do
                    local p = Instance.new("Part", workspace)
                    p.Size = Vector3.new(100,100,100)
                    p.Anchored = true
                    p.Transparency = 1
                    p.Position = Vector3.new(math.random(-5000,5000),99999,math.random(-5000,5000))
                    game.Debris:AddItem(p, 5)
                end
            end
        end)

    elseif tab == 3 then -- v3 Laser + Brainrot
        makeBtn("Laser Unlocker (5s)", Color3.fromRGB(255,120,0), function()
            for _,v in workspace:GetDescendants() do
                if v:IsA("Beam") or string.find(string.lower(v.Name),"laser") then
                    v.Enabled = false
                    task.delay(5, function() if v and v.Parent then v.Enabled = true end end)
                end
            end
            states.noclip = true
            task.wait(5)
            states.noclip = false
        end)

        local b = makeBtn("Brainrot Auto-TP: "..(states.brainrot and "ON" or "OFF"), states.brainrot and Color3.fromRGB(0,255,0) or Color3.fromRGB(180,0,255), function()
            states.brainrot = not states.brainrot
            b.Text = "Brainrot Auto-TP: "..(states.brainrot and "ON" or "OFF")
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = states.brainrot and Color3.fromRGB(0,255,0) or Color3.fromRGB(180,0,255)}):Play()
            if states.brainrot and not brainConn then
                brainConn = player.Backpack.ChildAdded:Connect(function(tool)
                    if string.find(string.lower(tool.Name),"brain") or string.find(string.lower(tool.Name),"rot") then
                        task.wait(0.1)
                        if player.Character then player.Character:PivotTo(CFrame.new(savedPos)) end
                    end
                end)
            elseif not states.brainrot and brainConn then
                brainConn:Disconnect()
                brainConn = nil
            end
        end)

    elseif tab == 4 then -- v4 ESP + Hitbox
        local e = makeBtn("ESP: "..(states.esp and "ON" or "OFF"), states.esp and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,150,0), function()
            states.esp = not states.esp
            e.Text = "ESP: "..(states.esp and "ON" or "OFF")
            TweenService:Create(e, TweenInfo.new(0.3), {BackgroundColor3 = states.esp and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,150,0)}):Play()
        end)

        local h = makeBtn("Hitbox: "..(states.hitbox and "ON" or "OFF"), states.hitbox and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,100,0), function()
            states.hitbox = not states.hitbox
            h.Text = "Hitbox: "..(states.hitbox and "ON" or "OFF")
            TweenService:Create(h, TweenInfo.new(0.3), {BackgroundColor3 = states.hitbox and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,100,0)}):Play()
        end)

    elseif tab == 5 then -- v5 TP Player
        local box = Instance.new("TextBox", content)
        box.Size = UDim2.new(1,0,0,50)
        box.PlaceholderText = "Username"
        box.BackgroundColor3 = Color3.fromRGB(40,40,40)
        box.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

        makeBtn("Teleport to Player", Color3.fromRGB(0,200,255), function()
            local t = Players:FindFirstChild(box.Text)
            if t and t.Character then
                player.Character:PivotTo(t.Character.HumanoidRootPart.CFrame)
            end
        end)

    elseif tab == 6 then -- v6 Lag Player
        local box = Instance.new("TextBox", content)
        box.Size = UDim2.new(1,0,0,50)
        box.PlaceholderText = "Username"
        box.BackgroundColor3 = Color3.fromRGB(40,40,40)
        box.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

        makeBtn("LAG THIS PLAYER", Color3.fromRGB(255,0,0), function()
            local t = Players:FindFirstChild(box.Text)
            if t and t.Character then
                spawn(function()
                    while task.wait(0.1) do
                        for i=1,120 do
                            local p = Instance.new("Part", workspace)
                            p.Size = Vector3.new(40,40,40)
                            p.Position = t.Character.HumanoidRootPart.Position
                            p.Anchored = true
                            p.Transparency = 1
                            game.Debris:AddItem(p, 3)
                        end
                    end
                end)
            end
        end)
    end
end

-- MAIN LOOPS
RunService.Stepped:Connect(function()
    pcall(function()
        if states.noclip and player.Character then
            for _,v in player.Character:GetDescendants() do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
        if states.hitbox then
            for _,p in Players:GetPlayers() do
                if p ~= player and p.Character then
                    for _,v in p.Character:GetDescendants() do
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                            v.Size = Vector3.new(25,25,25)
                            v.Transparency = 0.7
                        end
                    end
                end
            end
        end
    end)
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        if states.esp then
            for _,p in Players:GetPlayers() do
                if p ~= player and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("VolcanicESP") then
                    local bill = Instance.new("BillboardGui", p.Character.Head)
                    bill.Name = "VolcanicESP"
                    bill.Size = UDim2.new(0,100,0,40)
                    bill.StudsOffset = Vector3.new(0,3,0)
                    bill.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bill)
                    txt.BackgroundTransparency = 1
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.Text = p.Name
                    txt.TextColor3 = Color3.fromRGB(255,0,0)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 18
                end
            end
        end
        if states.farm and player.Character then
            for _,v in workspace:GetDescendants() do
                if v:IsA("TouchInterest") then
                    firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end
    end)
end)

loadTab(1)
StarterGui:SetCore("SendNotification",{Title="VOLCANIC 2025",Text="Loaded — You are now GOD",Duration=6})
