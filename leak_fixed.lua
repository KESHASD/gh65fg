-- Bee Swarm Simulator Auto Farm Script - Fixed Version
-- Compatible with most executors
-- Features: Auto Farm, Auto Sprinkler, Auto Dig, Multi-select options

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Anti Idle
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Variables
local autoFarmEnabled = false
local autoSprinklerEnabled = false
local autoDigEnabled = false
local selectedField = "Pine Tree Forest"
local farmingSettings = {
    farmPetals = false,
    farmBubbles = false,
    farmBlooms = false,
    farmLeaves = false,
    farmMarks = false,
    ignoreHoneyTokens = false,
    farmUnderBalloons = false
}
local priorityTokens = {
    blueBoost = false,
    inflateBalloon = false
}

-- Field positions
local fieldPositions = {
    ["Pine Tree Forest"] = CFrame.new(-258.5, 67.2, 299.3),
    ["Strawberry"] = CFrame.new(-169.3, 66.2, 103.4)
}

-- Remove existing GUI if exists
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "BeeSwarmAutoFarm" then
        gui:Destroy()
    end
end

-- Create main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeeSwarmAutoFarm"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.new(0.098, 0.098, 0.137)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.ClipsDescendants = true

-- Add corner rounding
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Parent = mainFrame
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BorderSizePixel = 0
shadow.Position = UDim2.new(0, 2, 0, 2)
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.ZIndex = -1
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Parent = mainFrame
titleBar.BackgroundColor3 = Color3.new(0.176, 0.176, 0.255)
titleBar.BorderSizePixel = 0
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Size = UDim2.new(1, 0, 0, 40)
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = titleBar
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 20, 0, 0)
title.Size = UDim2.new(1, -40, 1, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "Bee Swarm Simulator - Auto Farm"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Parent = titleBar
closeButton.BackgroundColor3 = Color3.new(1, 0.333, 0.333)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -35, 0, 8)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "×"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 18
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Tab Container
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Parent = mainFrame
tabContainer.BackgroundColor3 = Color3.new(0.137, 0.137, 0.196)
tabContainer.BorderSizePixel = 0
tabContainer.Position = UDim2.new(0, 0, 0, 40)
tabContainer.Size = UDim2.new(1, 0, 0, 50)

-- Auto Farm Tab Button
local autoFarmTab = Instance.new("TextButton")
autoFarmTab.Name = "AutoFarmTab"
autoFarmTab.Parent = tabContainer
autoFarmTab.BackgroundColor3 = Color3.new(0.255, 0.412, 0.882)
autoFarmTab.BorderSizePixel = 0
autoFarmTab.Position = UDim2.new(0, 10, 0, 10)
autoFarmTab.Size = UDim2.new(0, 120, 0, 30)
autoFarmTab.Font = Enum.Font.SourceSans
autoFarmTab.Text = "Auto Farm"
autoFarmTab.TextColor3 = Color3.new(1, 1, 1)
autoFarmTab.TextSize = 14
local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 6)
autoFarmCorner.Parent = autoFarmTab

-- Farm Settings Sub-Tab Button (inside Auto Farm)
local farmSettingsTab = Instance.new("TextButton")
farmSettingsTab.Name = "FarmSettingsTab"
farmSettingsTab.Parent = tabContainer
farmSettingsTab.BackgroundColor3 = Color3.new(0.176, 0.176, 0.255)
farmSettingsTab.BorderSizePixel = 0
farmSettingsTab.Position = UDim2.new(0, 140, 0, 10)
farmSettingsTab.Size = UDim2.new(0, 120, 0, 30)
farmSettingsTab.Font = Enum.Font.SourceSans
farmSettingsTab.Text = "Farm Settings"
farmSettingsTab.TextColor3 = Color3.new(0.784, 0.784, 0.784)
farmSettingsTab.TextSize = 14
local farmSettingsCorner = Instance.new("UICorner")
farmSettingsCorner.CornerRadius = UDim.new(0, 6)
farmSettingsCorner.Parent = farmSettingsTab

-- Content Container
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Parent = mainFrame
contentContainer.BackgroundColor3 = Color3.new(0.118, 0.118, 0.176)
contentContainer.BorderSizePixel = 0
contentContainer.Position = UDim2.new(0, 0, 0, 90)
contentContainer.Size = UDim2.new(1, 0, 1, -90)

-- Auto Farm Content
local autoFarmContent = Instance.new("Frame")
autoFarmContent.Name = "AutoFarmContent"
autoFarmContent.Parent = contentContainer
autoFarmContent.BackgroundColor3 = Color3.new(1, 1, 1)
autoFarmContent.BackgroundTransparency = 1
autoFarmContent.BorderSizePixel = 0
autoFarmContent.Position = UDim2.new(0, 0, 0, 0)
autoFarmContent.Size = UDim2.new(1, 0, 1, 0)
autoFarmContent.Visible = true

-- Auto Farm Section
local autoFarmSection = createSection(autoFarmContent, "Auto Farm", UDim2.new(0, 20, 0, 20))

-- Auto Farm Toggles
local autoFarmToggle = createToggle(autoFarmSection, "Auto Farm", UDim2.new(0, 0, 0, 0), false)
local autoSprinklerToggle = createToggle(autoFarmSection, "Auto Sprinkler", UDim2.new(0, 0, 0, 40), false)
local autoDigToggle = createToggle(autoFarmSection, "Auto Dig", UDim2.new(0, 0, 0, 80), false)

-- Farming Sub-tab Container
local farmingSubTab = Instance.new("Frame")
farmingSubTab.Name = "FarmingSubTab"
farmingSubTab.Parent = autoFarmContent
farmingSubTab.BackgroundColor3 = Color3.new(0.137, 0.137, 0.196)
farmingSubTab.BorderSizePixel = 0
farmingSubTab.Position = UDim2.new(0, 20, 0, 20)
farmingSubTab.Size = UDim2.new(0, 560, 0, 40)
local farmingCorner = Instance.new("UICorner")
farmingCorner.CornerRadius = UDim.new(0, 8)
farmingCorner.Parent = farmingSubTab

-- Farming Label
local farmingLabel = Instance.new("TextLabel")
farmingLabel.Name = "FarmingLabel"
farmingLabel.Parent = farmingSubTab
farmingLabel.BackgroundColor3 = Color3.new(1, 1, 1)
farmingLabel.BackgroundTransparency = 1
farmingLabel.Position = UDim2.new(0, 15, 0, 0)
farmingLabel.Size = UDim2.new(0, 80, 1, 0)
farmingLabel.Font = Enum.Font.SourceSans
farmingLabel.Text = "Farming:"
farmingLabel.TextColor3 = Color3.new(1, 1, 1)
farmingLabel.TextSize = 14
farmingLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Field Selection ComboBox
local fieldComboBox = Instance.new("TextButton")
fieldComboBox.Name = "FieldComboBox"
fieldComboBox.Parent = farmingSubTab
fieldComboBox.BackgroundColor3 = Color3.new(0.216, 0.216, 0.294)
fieldComboBox.BorderSizePixel = 0
fieldComboBox.Position = UDim2.new(0, 100, 0, 8)
fieldComboBox.Size = UDim2.new(0, 150, 0, 24)
fieldComboBox.Font = Enum.Font.SourceSans
fieldComboBox.Text = "Pine Tree Forest"
fieldComboBox.TextColor3 = Color3.new(1, 1, 1)
fieldComboBox.TextSize = 12
fieldComboBox.TextXAlignment = Enum.TextXAlignment.Left
local fieldCorner = Instance.new("UICorner")
fieldCorner.CornerRadius = UDim.new(0, 4)
fieldCorner.Parent = fieldComboBox

-- Dropdown Arrow
local dropdownArrow = Instance.new("TextLabel")
dropdownArrow.Name = "DropdownArrow"
dropdownArrow.Parent = fieldComboBox
dropdownArrow.BackgroundColor3 = Color3.new(1, 1, 1)
dropdownArrow.BackgroundTransparency = 1
dropdownArrow.Position = UDim2.new(1, -20, 0, 0)
dropdownArrow.Size = UDim2.new(0, 15, 1, 0)
dropdownArrow.Font = Enum.Font.SourceSans
dropdownArrow.Text = "v"
dropdownArrow.TextColor3 = Color3.new(1, 1, 1)
dropdownArrow.TextSize = 12

-- Dropdown Menu
local dropdownMenu = Instance.new("Frame")
dropdownMenu.Name = "DropdownMenu"
dropdownMenu.Parent = screenGui
dropdownMenu.BackgroundColor3 = Color3.new(0.216, 0.216, 0.294)
dropdownMenu.BorderSizePixel = 0
dropdownMenu.Visible = false
dropdownMenu.ZIndex = 10
local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 4)
dropdownCorner.Parent = dropdownMenu

-- Dropdown Options
local pineTreeOption = Instance.new("TextButton")
pineTreeOption.Name = "PineTreeOption"
pineTreeOption.Parent = dropdownMenu
pineTreeOption.BackgroundColor3 = Color3.new(0.216, 0.216, 0.294)
pineTreeOption.BorderSizePixel = 0
pineTreeOption.Position = UDim2.new(0, 0, 0, 0)
pineTreeOption.Size = UDim2.new(0, 150, 0, 30)
pineTreeOption.Font = Enum.Font.SourceSans
pineTreeOption.Text = "Pine Tree Forest"
pineTreeOption.TextColor3 = Color3.new(1, 1, 1)
pineTreeOption.TextSize = 12
pineTreeOption.TextXAlignment = Enum.TextXAlignment.Left

local strawberryOption = Instance.new("TextButton")
strawberryOption.Name = "StrawberryOption"
strawberryOption.Parent = dropdownMenu
strawberryOption.BackgroundColor3 = Color3.new(0.216, 0.216, 0.294)
strawberryOption.BorderSizePixel = 0
strawberryOption.Position = UDim2.new(0, 0, 0, 30)
strawberryOption.Size = UDim2.new(0, 150, 0, 30)
strawberryOption.Font = Enum.Font.SourceSans
strawberryOption.Text = "Strawberry"
strawberryOption.TextColor3 = Color3.new(1, 1, 1)
strawberryOption.TextSize = 12
strawberryOption.TextXAlignment = Enum.TextXAlignment.Left

-- Update dropdown menu position
local function updateDropdownPosition()
    local comboBoxPos = fieldComboBox.AbsolutePosition
    local comboBoxSize = fieldComboBox.AbsoluteSize
    dropdownMenu.Position = UDim2.new(0, comboBoxPos.X, 0, comboBoxPos.Y + comboBoxSize.Y)
    dropdownMenu.Size = UDim2.new(0, 150, 0, 60)
end

-- Farm Settings Content (as sub-tab inside Auto Farm)
local farmSettingsContent = Instance.new("Frame")
farmSettingsContent.Name = "FarmSettingsContent"
farmSettingsContent.Parent = autoFarmContent
farmSettingsContent.BackgroundColor3 = Color3.new(1, 1, 1)
farmSettingsContent.BackgroundTransparency = 1
farmSettingsContent.BorderSizePixel = 0
farmSettingsContent.Position = UDim2.new(0, 0, 0, 0)
farmSettingsContent.Size = UDim2.new(1, 0, 1, 0)
farmSettingsContent.Visible = false

-- Helper Functions
function createToggle(parent, labelText, position, defaultState)
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Name = labelText .. "Container"
    toggleContainer.Parent = parent
    toggleContainer.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.BorderSizePixel = 0
    toggleContainer.Position = position
    toggleContainer.Size = UDim2.new(0, 200, 0, 30)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = toggleContainer
    label.BackgroundColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Font = Enum.Font.SourceSans
    label.Text = labelText
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Parent = toggleContainer
    toggleButton.BackgroundColor3 = defaultState and Color3.new(0.298, 0.686, 0.314) or Color3.new(0.62, 0.62, 0.62)
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.new(0, 160, 0, 5)
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Font = Enum.Font.SourceSans
    toggleButton.Text = ""
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.TextSize = 12
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleButton

    local toggleKnob = Instance.new("Frame")
    toggleKnob.Name = "ToggleKnob"
    toggleKnob.Parent = toggleButton
    toggleKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleKnob.BorderSizePixel = 0
    toggleKnob.Position = defaultState and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0)
    toggleKnob.Size = UDim2.new(0, 20, 1, 0)
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 10)
    knobCorner.Parent = toggleKnob

    local state = defaultState

    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local colorTween = TweenService:Create(toggleButton, tweenInfo, {
            BackgroundColor3 = state and Color3.new(0.298, 0.686, 0.314) or Color3.new(0.62, 0.62, 0.62)
        })
        local positionTween = TweenService:Create(toggleKnob, tweenInfo, {
            Position = state and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0)
        })
        colorTween:Play()
        positionTween:Play()

        -- Update corresponding variables
        if labelText == "Auto Farm" then
            autoFarmEnabled = state
        elseif labelText == "Auto Sprinkler" then
            autoSprinklerEnabled = state
        elseif labelText == "Auto Dig" then
            autoDigEnabled = state
        elseif labelText == "Farm Petals" then
            farmingSettings.farmPetals = state
        elseif labelText == "Farm Bubbles" then
            farmingSettings.farmBubbles = state
        elseif labelText == "Farm Blooms" then
            farmingSettings.farmBlooms = state
        elseif labelText == "Farm Leaves" then
            farmingSettings.farmLeaves = state
        elseif labelText == "Farm Marks" then
            farmingSettings.farmMarks = state
        elseif labelText == "Ignore Honey Tokens" then
            farmingSettings.ignoreHoneyTokens = state
        elseif labelText == "Farm Under Balloons" then
            farmingSettings.farmUnderBalloons = state
        elseif labelText == "Blue Boost" then
            priorityTokens.blueBoost = state
        elseif labelText == "Inflate Balloon" then
            priorityTokens.inflateBalloon = state
        end
    end)

    return toggleButton
end

function createSection(parent, sectionTitle, position)
    local section = Instance.new("Frame")
    section.Name = sectionTitle .. "Section"
    section.Parent = parent
    section.BackgroundColor3 = Color3.new(0.137, 0.137, 0.196)
    section.BorderSizePixel = 0
    section.Position = position
    section.Size = UDim2.new(0, 520, 0, 180)
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = section
    titleLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.Size = UDim2.new(1, -30, 0, 25)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Text = sectionTitle
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    return section
end

-- Farm Options Section
local farmOptionsSection = createSection(farmSettingsContent, "Farm Options", UDim2.new(0, 20, 0, 20))

-- Farm Options Multi-select
local farmMarksToggle = createToggle(farmOptionsSection, "Farm Marks", UDim2.new(0, 0, 0, 0), false)
local farmBubblesToggle = createToggle(farmOptionsSection, "Farm Bubbles", UDim2.new(0, 0, 0, 40), false)
local ignoreHoneyToggle = createToggle(farmOptionsSection, "Ignore Honey Tokens", UDim2.new(0, 0, 0, 80), false)
local farmBloomsToggle = createToggle(farmOptionsSection, "Farm Blooms", UDim2.new(0, 200, 0, 0), false)
local farmUnderBalloonsToggle = createToggle(farmOptionsSection, "Farm Under Balloons", UDim2.new(0, 200, 0, 40), false)
local farmLeavesToggle = createToggle(farmOptionsSection, "Farm Leaves", UDim2.new(0, 200, 0, 80), false)

-- Priority Tokens Section
local priorityTokensSection = createSection(farmSettingsContent, "Priority Tokens", UDim2.new(0, 20, 0, 220))

-- Priority Tokens Multi-select
local inflateBalloonToggle = createToggle(priorityTokensSection, "Inflate Balloon", UDim2.new(0, 0, 0, 0), false)

-- Tab Switching Logic
local currentTab = "AutoFarm"

function switchTab(tabName)
    currentTab = tabName
    
    -- Update tab button colors
    if tabName == "AutoFarm" then
        autoFarmTab.BackgroundColor3 = Color3.new(0.255, 0.412, 0.882)
        autoFarmTab.TextColor3 = Color3.new(1, 1, 1)
        farmSettingsTab.BackgroundColor3 = Color3.new(0.176, 0.176, 0.255)
        farmSettingsTab.TextColor3 = Color3.new(0.784, 0.784, 0.784)
        -- Show Auto Farm content, hide Farm Settings
        autoFarmContent.Visible = true
        farmSettingsContent.Visible = false
        farmingSubTab.Visible = true
        autoFarmSection.Visible = true
    elseif tabName == "FarmSettings" then
        farmSettingsTab.BackgroundColor3 = Color3.new(0.255, 0.412, 0.882)
        farmSettingsTab.TextColor3 = Color3.new(1, 1, 1)
        autoFarmTab.BackgroundColor3 = Color3.new(0.176, 0.176, 0.255)
        autoFarmTab.TextColor3 = Color3.new(0.784, 0.784, 0.784)
        -- Show Farm Settings content
        autoFarmContent.Visible = true
        farmSettingsContent.Visible = true
        farmingSubTab.Visible = false
        autoFarmSection.Visible = false
    end
end

autoFarmTab.MouseButton1Click:Connect(function()
    switchTab("AutoFarm")
end)

farmSettingsTab.MouseButton1Click:Connect(function()
    switchTab("FarmSettings")
end)

-- Dropdown Logic
local dropdownOpen = false

fieldComboBox.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    updateDropdownPosition()
    dropdownMenu.Visible = dropdownOpen
    dropdownArrow.Text = dropdownOpen and "^" or "v"
end)

pineTreeOption.MouseButton1Click:Connect(function()
    selectedField = "Pine Tree Forest"
    fieldComboBox.Text = selectedField
    dropdownMenu.Visible = false
    dropdownOpen = false
    dropdownArrow.Text = "v"
end)

strawberryOption.MouseButton1Click:Connect(function()
    selectedField = "Strawberry"
    fieldComboBox.Text = selectedField
    dropdownMenu.Visible = false
    dropdownOpen = false
    dropdownArrow.Text = "v"
end)

-- Close dropdown when clicking outside
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
        local mousePos = UserInputService:GetMouseLocation()
        local comboBoxPos = fieldComboBox.AbsolutePosition
        local comboBoxSize = fieldComboBox.AbsoluteSize
        local dropdownPos = dropdownMenu.AbsolutePosition
        local dropdownSize = dropdownMenu.AbsoluteSize
        
        local inComboBox = mousePos.X >= comboBoxPos.X and mousePos.X <= comboBoxPos.X + comboBoxSize.X and
                          mousePos.Y >= comboBoxPos.Y and mousePos.Y <= comboBoxPos.Y + comboBoxSize.Y
        local inDropdown = mousePos.X >= dropdownPos.X and mousePos.X <= dropdownPos.X + dropdownSize.X and
                           mousePos.Y >= dropdownPos.Y and mousePos.Y <= dropdownPos.Y + dropdownSize.Y
        
        if not inComboBox and not inDropdown then
            dropdownMenu.Visible = false
            dropdownOpen = false
            dropdownArrow.Text = "v"
        end
    end
end)

-- Close Button
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Make GUI draggable
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.MouseButton1Down:Connect(function()
    dragging = true
    dragStart = UserInputService:GetMouseLocation()
    startPos = mainFrame.Position
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseLocation = UserInputService:GetMouseLocation()
        local delta = mouseLocation - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Auto Farm Functions
function startAutoFarm()
    if autoFarmEnabled and character and character:FindFirstChild("HumanoidRootPart") then
        local fieldPos = fieldPositions[selectedField]
        if fieldPos then
            character.HumanoidRootPart.CFrame = fieldPos
        end
    end
end

-- Update dropdown position when GUI moves
RunService.Heartbeat:Connect(function()
    if dropdownOpen then
        updateDropdownPosition()
    end
end)

-- Farming Loop
RunService.Heartbeat:Connect(function()
    if autoFarmEnabled then
        startAutoFarm()
    end
    
    if autoSprinklerEnabled then
        -- Auto sprinkler logic here
        -- You can add sprinkler collection logic
    end
    
    if autoDigEnabled then
        -- Auto dig logic here
        -- You can add digging logic
    end
end)

print("Bee Swarm Simulator Auto Farm GUI loaded successfully!")
print("Use the interface to configure your farming settings.")

return {
    autoFarmEnabled = function() return autoFarmEnabled end,
    autoSprinklerEnabled = function() return autoSprinklerEnabled end,
    autoDigEnabled = function() return autoDigEnabled end,
    selectedField = function() return selectedField end,
    farmingSettings = function() return farmingSettings end,
    priorityTokens = function() return priorityTokens end
}
