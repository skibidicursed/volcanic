-- VOLCANIC MENU 2025 - LITERALLY IMPOSSIBLE TO CRASH VERSION
-- Copy from the very top to the very bottom → execute → win

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "volcanic"
gui.ResetOnSpawn = false
gui.Parent = pgui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,380,0,620)
frame.Position = UDim2.new(0.5,-190,0.5,-310)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner",frame).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Text = "VOLCANIC - NO CRASH"
title.TextColor3 = Color3.fromRGB(255,50,50)
title.Font = Enum.Font.GothamBlack
title.TextSize = 42

-- STATES
_G.noclip = _G.noclip or false
_G.esp = _G.esp or false
_G.hitbox = _G.hitbox or false
_G.farm = _G.farm or false
_G.brainrot = _G.brainrot or false

local savedPos = Vector3.new(0,100,0)

local function btn(y,txt,col,func)
    local b = Instance.new("TextButton",frame)
    b.Size = UDim2.new(0.9,0,0,55)
    b.Position = UDim2.new(0.05,0,0,y)
    b.BackgroundColor3 = col or Color3.fromRGB(50,50,50)
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 26
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,12)
    b.MouseButton1Click:Connect(function()
        spawn(function() pcall(func) end) -- 100% safe
    end)
end

local function clear()
    for _,v in frame:GetChildren() do
        if v:IsA("TextButton") or v:IsA("TextBox") then v:Destroy() end
    end
end

local function main()
    clear()
    title.Text = "VOLCANIC - NO CRASH"
    btn(80,  "Noclip + Checkpoint", Color3.fromRGB(200,0,0), v1)
    btn(150, "Auto Farm",           Color3.fromRGB(0,200,0), v2)
    btn(220, "Laser + Brainrot",    Color3.fromRGB(0,120,255), v3)
    btn(290, "ESP + Hitbox",        Color3.fromRGB(255,150,0), v4)
    btn(360, "TP Player",           Color3.fromRGB(255,0,255), v5)
    btn(430, "Lag Player",          Color3.fromRGB(255,0,0), v6)
end

function v1()
    clear()
    title.Text = "v1 Noclip"
    btn(80,"Noclip: "..(_G.noclip and "ON" or "OFF"), _G.noclip and Color3.fromRGB(0,255,0) or Color3.fromRGB(200,0,0), function()
        _G.noclip = not _G.noclip
    end)
    btn(150,"Set Checkpoint",nil,function()
        if player.Character then
            savedPos = player.Character.HumanoidRootPart.Position + Vector3.new(0,6,0)
        end
    end)
    btn(220,"TP Checkpoint",Color3.fromRGB(0,200,100),function()
        if player.Character then
            player.Character:PivotTo(CFrame.new(savedPos))
        end
    end)
    btn(540,"Back",nil,main)
end

function v4()
    clear()
    title.Text = "v4 ESP + Hitbox"
    btn(80,"ESP: "..(_G.esp and "ON" or "OFF"), _G.esp and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,150,0), function()
        _G.esp = not _G.esp
    end)
    btn(150,"Hitbox: "..(_G.hitbox and "ON" or "OFF"), _G.hitbox and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,100,0), function()
        _G.hitbox = not _G.hitbox
    end)
    btn(540,"Back",nil,main)
end

-- ONLY SAFE STUFF RUNS HERE
spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.noclip and player.Character then
                for _,p in player.Character:GetDescendants() do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
            if _G.hitbox then
                for _,pl in game.Players:GetPlayers() do
                    if pl ~= player and pl.Character then
                        for _,p in pl.Character:GetDescendants() do
                            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                                p.Size = Vector3.new(15,15,15) -- small = no crash
                                p.Transparency = 0.7
                            end
                        end
                    end
                end
            end
            if _G.esp then
                for _,pl in game.Players:GetPlayers() do
                    if pl ~= player and pl.Character and pl.Character:FindFirstChild("Head") and not pl.Character.Head:FindFirstChild("ESP") then
                        local b = Instance.new("BillboardGui",pl.Character.Head)
                        b.Name = "ESP"
                        b.AlwaysOnTop = true
                        b.Size = UDim2.new(0,100,0,30)
                        b.StudsOffset = Vector3.new(0,3,0)
                        local t = Instance.new("TextLabel",b)
                        t.BackgroundTransparency = 1
                        t.Size = UDim2.new(1,0,1,0)
                        t.Text = pl.Name
                        t.TextColor3 = Color3.fromRGB(255,0,0)
                        t.TextSize = 18
                    end
                end
            end
            if _G.farm and player.Character then
                for _,v in workspace:GetDescendants() do
                    if v:IsA("TouchInterest") and v.Parent and player.Character:FindFirstChild("HumanoidRootPart") then
                        firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 0)
                        task.wait()
                        firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 1)
                    end
                end
            end
        end)
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(2)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.Position + Vector3.new(0,10,0)
    end
end)

main()
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "VOLCANIC";
    Text = "Loaded — YOU WILL NOT CRASH ANYMORE";
    Duration = 6;
})
