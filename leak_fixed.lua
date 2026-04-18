-- Bee Swarm Simulator | Simple ImGui-style GUI
-- Auto Farm + Auto Dig

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== STATE ====================
local State = {
    AutoFarm = false,
    AutoDig  = false,
}

-- ==================== GUI SETUP ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeeSwarmGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main window frame
local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, 220, 0, 140)
Window.Position = UDim2.new(0, 20, 0, 20)
Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Window.BorderSizePixel = 0
Window.Active = true
Window.Draggable = true
Window.Parent = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 8)
WindowCorner.Parent = Window

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 80, 200)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Window

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Fix bottom corners of title bar
local TitleBarFix = Instance.new("Frame")
TitleBarFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleBarFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleBarFix.BackgroundColor3 = Color3.fromRGB(40, 80, 200)
TitleBarFix.BorderSizePixel = 0
TitleBarFix.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "🐝 Bee Swarm GUI"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

-- ==================== HELPERS ====================
local function makeCheckbox(parent, labelText, yPos, stateKey)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -20, 0, 36)
    Row.Position = UDim2.new(0, 10, 0, yPos)
    Row.BackgroundTransparency = 1
    Row.Parent = parent

    local Box = Instance.new("Frame")
    Box.Name = "Box"
    Box.Size = UDim2.new(0, 20, 0, 20)
    Box.Position = UDim2.new(0, 0, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Box.BorderSizePixel = 0
    Box.Parent = Row

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = Box

    local Tick = Instance.new("TextLabel")
    Tick.Text = "✓"
    Tick.Size = UDim2.new(1, 0, 1, 0)
    Tick.BackgroundTransparency = 1
    Tick.TextColor3 = Color3.fromRGB(80, 200, 120)
    Tick.TextSize = 16
    Tick.Font = Enum.Font.GothamBold
    Tick.Visible = false
    Tick.Parent = Box

    local Label = Instance.new("TextLabel")
    Label.Text = labelText
    Label.Size = UDim2.new(1, -30, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(210, 210, 230)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = Row

    local function refresh()
        if State[stateKey] then
            Box.BackgroundColor3 = Color3.fromRGB(40, 80, 200)
            Tick.Visible = true
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Box.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            Tick.Visible = false
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
        end
    end

    Button.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        refresh()
    end)

    refresh()
    return Row
end

-- ==================== CHECKBOXES ====================
makeCheckbox(Window, "Auto Farm", 40, "AutoFarm")
makeCheckbox(Window, "Auto Dig",  84, "AutoDig")

-- ==================== STATUS BAR ====================
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 20)
StatusBar.Position = UDim2.new(0, 0, 1, -20)
StatusBar.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = Window

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusBar

local StatusFix = Instance.new("Frame")
StatusFix.Size = UDim2.new(1, 0, 0.5, 0)
StatusFix.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
StatusFix.BorderSizePixel = 0
StatusFix.Parent = StatusBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 1, 0)
StatusLabel.Position = UDim2.new(0, 8, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 150)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Text = "Idle"
StatusLabel.Parent = StatusBar

-- ==================== LOGIC ====================

-- Auto Farm: collect pollen near the player
local function doAutoFarm()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Try to use in-game collect tool if present
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local activateRemote = tool:FindFirstChild("Activate") or tool:FindFirstChild("RemoteEvent")
        if activateRemote then
            activateRemote:FireServer()
        end
    end

    -- Find nearby flowers / pollen objects and walk to them
    local workspace = game:GetService("Workspace")
    local closest, closestDist = nil, 60
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (
            obj.Name:lower():find("flower") or
            obj.Name:lower():find("pollen") or
            obj.Name:lower():find("clover")
        ) then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < closestDist then
                closest = obj
                closestDist = dist
            end
        end
    end

    if closest then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:MoveTo(closest.Position)
        end
    end
end

-- Auto Dig: find and interact with dig spots
local function doAutoDig()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local workspace = game:GetService("Workspace")
    local closest, closestDist = nil, 80
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (
            obj.Name:lower():find("dig") or
            obj.Name:lower():find("tunnel") or
            obj.Name:lower():find("sprout")
        ) then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < closestDist then
                closest = obj
                closestDist = dist
            end
        end
    end

    if closest then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:MoveTo(closest.Position)
        end
    end
end

-- Main loop
local tick = 0
RunService.Heartbeat:Connect(function(dt)
    tick = tick + dt
    if tick < 0.5 then return end
    tick = 0

    local parts = {}
    if State.AutoFarm then table.insert(parts, "AutoFarm: ON") end
    if State.AutoDig  then table.insert(parts, "AutoDig: ON")  end
    StatusLabel.Text = #parts > 0 and table.concat(parts, " | ") or "Idle"

    if State.AutoFarm then
        pcall(doAutoFarm)
    end
    if State.AutoDig then
        pcall(doAutoDig)
    end
end)

print("[BeeSwarmGUI] Loaded successfully!")
