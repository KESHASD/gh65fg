-- Bee Swarm Simulator | ImGui-style GUI (UI only)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =====================================================
--  COLORS
-- =====================================================
local C = {
    BG          = Color3.fromRGB(18, 18, 28),
    WindowBG    = Color3.fromRGB(24, 24, 36),
    SidebarBG   = Color3.fromRGB(20, 20, 30),
    TitleBG     = Color3.fromRGB(35, 75, 195),
    SectionHdr  = Color3.fromRGB(30, 30, 46),
    SectionBdr  = Color3.fromRGB(50, 50, 80),
    Accent      = Color3.fromRGB(60, 120, 255),
    AccentHover = Color3.fromRGB(80, 140, 255),
    CheckOff    = Color3.fromRGB(45, 45, 65),
    CheckOn     = Color3.fromRGB(60, 120, 255),
    Tick        = Color3.fromRGB(255, 255, 255),
    Text        = Color3.fromRGB(200, 200, 220),
    TextDim     = Color3.fromRGB(120, 120, 150),
    TextHdr     = Color3.fromRGB(255, 255, 255),
    SliderBG    = Color3.fromRGB(40, 40, 60),
    SliderFill  = Color3.fromRGB(60, 120, 255),
    SliderKnob  = Color3.fromRGB(200, 210, 255),
    DropBG      = Color3.fromRGB(30, 30, 48),
    DropItem    = Color3.fromRGB(36, 36, 56),
    DropSel     = Color3.fromRGB(50, 90, 200),
    SubHdr      = Color3.fromRGB(255, 190, 60),
    SideActive  = Color3.fromRGB(60, 120, 255),
    SideText    = Color3.fromRGB(170, 170, 200),
    SideTextA   = Color3.fromRGB(255, 255, 255),
}

-- =====================================================
--  SCREENUI + ROOT WINDOW
-- =====================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeeSwarmGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local WIN_W, WIN_H = 700, 520
local SIDEBAR_W    = 130
local CONTENT_W    = WIN_W - SIDEBAR_W

local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Window.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
Window.BackgroundColor3 = C.WindowBG
Window.BorderSizePixel = 0
Window.Active = true
Window.Draggable = true
Window.ClipsDescendants = true
Window.Parent = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 10)

-- =====================================================
--  TITLE BAR
-- =====================================================
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = C.TitleBG
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 5
TitleBar.Parent = Window
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = C.TitleBG
TitleFix.BorderSizePixel = 0
TitleFix.ZIndex = 5
TitleFix.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "🐝  Bee Swarm Simulator"
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = C.TextHdr
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 6
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 6
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- =====================================================
--  SIDEBAR
-- =====================================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, SIDEBAR_W, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = C.SidebarBG
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Window

local SideList = Instance.new("UIListLayout")
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Padding = UDim.new(0, 2)
SideList.Parent = Sidebar

local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop = UDim.new(0, 8)
SidePad.PaddingLeft = UDim.new(0, 6)
SidePad.PaddingRight = UDim.new(0, 6)
SidePad.Parent = Sidebar

-- =====================================================
--  CONTENT AREA
-- =====================================================
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(0, CONTENT_W, 1, -36)
ContentArea.Position = UDim2.new(0, SIDEBAR_W, 0, 36)
ContentArea.BackgroundColor3 = C.BG
ContentArea.BorderSizePixel = 0
ContentArea.ClipsDescendants = true
ContentArea.Parent = Window

-- Sidebar divider
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 1, 1, -36)
Divider.Position = UDim2.new(0, SIDEBAR_W, 0, 36)
Divider.BackgroundColor3 = C.SectionBdr
Divider.BorderSizePixel = 0
Divider.Parent = Window

-- =====================================================
--  HELPERS
-- =====================================================
local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end

local function label(parent, text, size, color, bold, xalign)
    local l = Instance.new("TextLabel")
    l.Text = text
    l.Size = size or UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.TextColor3 = color or C.Text
    l.TextSize = 13
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextXAlignment = xalign or Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

-- Checkbox  (state is a plain table {value=bool})
local function makeCheckbox(parent, text, state)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundTransparency = 1
    Row.Parent = parent

    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 18, 0, 18)
    Box.Position = UDim2.new(0, 0, 0.5, -9)
    Box.BackgroundColor3 = C.CheckOff
    Box.BorderSizePixel = 0
    Box.Parent = Row
    corner(Box, 4)

    local Tick = Instance.new("TextLabel")
    Tick.Text = "✓"
    Tick.Size = UDim2.new(1, 0, 1, 0)
    Tick.BackgroundTransparency = 1
    Tick.TextColor3 = C.Tick
    Tick.TextSize = 13
    Tick.Font = Enum.Font.GothamBold
    Tick.Visible = false
    Tick.Parent = Box

    local Lbl = Instance.new("TextLabel")
    Lbl.Text = text
    Lbl.Size = UDim2.new(1, -26, 1, 0)
    Lbl.Position = UDim2.new(0, 26, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = C.Text
    Lbl.TextSize = 13
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 3
    Btn.Parent = Row

    local function refresh()
        Box.BackgroundColor3 = state.value and C.CheckOn or C.CheckOff
        Tick.Visible = state.value
        Lbl.TextColor3 = state.value and C.TextHdr or C.Text
    end
    Btn.MouseButton1Click:Connect(function()
        state.value = not state.value
        refresh()
        if state.onChange then state.onChange(state.value) end
    end)
    refresh()
    return Row
end

-- Section header label inside content
local function makeSectionHeader(parent, text)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 26)
    F.BackgroundColor3 = C.SectionHdr
    F.BorderSizePixel = 0
    F.Parent = parent
    corner(F, 5)

    local L = label(F, "  " .. text, UDim2.new(1, 0, 1, 0), C.SubHdr, true)
    L.TextSize = 12
    return F
end

-- Subgroup label
local function makeGroupHeader(parent, text)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 22)
    F.BackgroundColor3 = Color3.fromRGB(28, 28, 44)
    F.BorderSizePixel = 0
    F.Parent = parent
    corner(F, 4)

    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(0, 3, 1, -6)
    sep.Position = UDim2.new(0, 0, 0, 3)
    sep.BackgroundColor3 = C.Accent
    sep.BorderSizePixel = 0
    sep.Parent = F
    corner(sep, 2)

    local L = label(F, "   " .. text, UDim2.new(1, 0, 1, 0), C.SubHdr, true)
    L.TextSize = 12
    return F
end

-- Slider (state = {value=number, min=n, max=n})
local function makeSlider(parent, text, state)
    local SLIDER_H = 46
    local Wrap = Instance.new("Frame")
    Wrap.Size = UDim2.new(1, 0, 0, SLIDER_H)
    Wrap.BackgroundTransparency = 1
    Wrap.Parent = parent

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.6, 0, 0, 18)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = C.Text
    Lbl.TextSize = 13
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Wrap

    local ValLbl = Instance.new("TextLabel")
    ValLbl.Size = UDim2.new(0.4, 0, 0, 18)
    ValLbl.Position = UDim2.new(0.6, 0, 0, 0)
    ValLbl.BackgroundTransparency = 1
    ValLbl.TextColor3 = C.Accent
    ValLbl.TextSize = 13
    ValLbl.Font = Enum.Font.GothamBold
    ValLbl.TextXAlignment = Enum.TextXAlignment.Right
    ValLbl.Parent = Wrap

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 8)
    Track.Position = UDim2.new(0, 0, 0, 26)
    Track.BackgroundColor3 = C.SliderBG
    Track.BorderSizePixel = 0
    Track.Parent = Wrap
    corner(Track, 4)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = C.SliderFill
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    corner(Fill, 4)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(0, -7, 0.5, -7)
    Knob.BackgroundColor3 = C.SliderKnob
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 3
    Knob.Parent = Track
    corner(Knob, 7)

    local DragBtn = Instance.new("TextButton")
    DragBtn.Size = UDim2.new(1, 0, 0, 20)
    DragBtn.Position = UDim2.new(0, 0, 0, 22)
    DragBtn.BackgroundTransparency = 1
    DragBtn.Text = ""
    DragBtn.ZIndex = 4
    DragBtn.Parent = Wrap

    local function updateVisual()
        local range = state.max - state.min
        local pct = (state.value - state.min) / range
        Fill.Size = UDim2.new(pct, 0, 1, 0)
        Knob.Position = UDim2.new(pct, -7, 0.5, -7)
        Lbl.Text = text
        ValLbl.Text = tostring(math.floor(state.value))
    end
    updateVisual()

    local dragging = false
    DragBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = Track.AbsolutePosition
            local sz  = Track.AbsoluteSize
            local pct = math.clamp((inp.Position.X - abs.X) / sz.X, 0, 1)
            state.value = state.min + pct * (state.max - state.min)
            updateVisual()
        end
    end)

    return Wrap
end

-- Multiselect dropdown
local function makeMultiselect(parent, titleText, options, selectedSet)
    local ITEM_H = 24
    local HDR_H  = 30
    local open   = false
    local totalH = HDR_H + #options * ITEM_H + 6

    local Outer = Instance.new("Frame")
    Outer.Size = UDim2.new(1, 0, 0, HDR_H)
    Outer.BackgroundTransparency = 1
    Outer.ClipsDescendants = false
    Outer.Parent = parent

    local Hdr = Instance.new("TextButton")
    Hdr.Size = UDim2.new(1, 0, 0, HDR_H)
    Hdr.BackgroundColor3 = C.DropBG
    Hdr.BorderSizePixel = 0
    Hdr.Text = ""
    Hdr.ZIndex = 5
    Hdr.Parent = Outer
    corner(Hdr, 6)

    local HdrLbl = Instance.new("TextLabel")
    HdrLbl.Size = UDim2.new(1, -30, 1, 0)
    HdrLbl.Position = UDim2.new(0, 10, 0, 0)
    HdrLbl.BackgroundTransparency = 1
    HdrLbl.TextColor3 = C.Text
    HdrLbl.TextSize = 13
    HdrLbl.Font = Enum.Font.Gotham
    HdrLbl.TextXAlignment = Enum.TextXAlignment.Left
    HdrLbl.ZIndex = 6
    HdrLbl.Parent = Hdr

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -24, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.TextColor3 = C.TextDim
    Arrow.TextSize = 12
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "▾"
    Arrow.ZIndex = 6
    Arrow.Parent = Hdr

    local Dropdown = Instance.new("Frame")
    Dropdown.Size = UDim2.new(1, 0, 0, #options * ITEM_H + 6)
    Dropdown.Position = UDim2.new(0, 0, 0, HDR_H + 2)
    Dropdown.BackgroundColor3 = C.DropBG
    Dropdown.BorderSizePixel = 0
    Dropdown.Visible = false
    Dropdown.ZIndex = 10
    Dropdown.ClipsDescendants = true
    Dropdown.Parent = Outer
    corner(Dropdown, 6)

    local DdList = Instance.new("UIListLayout")
    DdList.SortOrder = Enum.SortOrder.LayoutOrder
    DdList.Padding = UDim.new(0, 2)
    DdList.Parent = Dropdown

    local DdPad = Instance.new("UIPadding")
    DdPad.PaddingTop = UDim.new(0, 3)
    DdPad.PaddingLeft = UDim.new(0, 4)
    DdPad.PaddingRight = UDim.new(0, 4)
    DdPad.Parent = Dropdown

    local function refreshHeader()
        local sel = {}
        for k in pairs(selectedSet) do table.insert(sel, k) end
        if #sel == 0 then
            HdrLbl.Text = titleText
            HdrLbl.TextColor3 = C.TextDim
        elseif #sel <= 2 then
            HdrLbl.Text = titleText .. ": " .. table.concat(sel, ", ")
            HdrLbl.TextColor3 = C.Text
        else
            HdrLbl.Text = titleText .. ": " .. #sel .. " selected"
            HdrLbl.TextColor3 = C.Text
        end
    end
    refreshHeader()

    for _, opt in ipairs(options) do
        local Row = Instance.new("TextButton")
        Row.Size = UDim2.new(1, 0, 0, ITEM_H)
        Row.BackgroundColor3 = C.DropItem
        Row.BorderSizePixel = 0
        Row.Text = ""
        Row.ZIndex = 11
        Row.Parent = Dropdown
        corner(Row, 4)

        local Check = Instance.new("Frame")
        Check.Size = UDim2.new(0, 14, 0, 14)
        Check.Position = UDim2.new(0, 4, 0.5, -7)
        Check.BackgroundColor3 = C.CheckOff
        Check.BorderSizePixel = 0
        Check.ZIndex = 12
        Check.Parent = Row
        corner(Check, 3)

        local Tick = Instance.new("TextLabel")
        Tick.Text = "✓"
        Tick.Size = UDim2.new(1, 0, 1, 0)
        Tick.BackgroundTransparency = 1
        Tick.TextColor3 = C.Tick
        Tick.TextSize = 11
        Tick.Font = Enum.Font.GothamBold
        Tick.Visible = false
        Tick.ZIndex = 13
        Tick.Parent = Check

        local OptLbl = Instance.new("TextLabel")
        OptLbl.Text = opt
        OptLbl.Size = UDim2.new(1, -26, 1, 0)
        OptLbl.Position = UDim2.new(0, 24, 0, 0)
        OptLbl.BackgroundTransparency = 1
        OptLbl.TextColor3 = C.Text
        OptLbl.TextSize = 12
        OptLbl.Font = Enum.Font.Gotham
        OptLbl.TextXAlignment = Enum.TextXAlignment.Left
        OptLbl.ZIndex = 12
        OptLbl.Parent = Row

        local function refreshItem()
            local sel = selectedSet[opt]
            Check.BackgroundColor3 = sel and C.CheckOn or C.CheckOff
            Tick.Visible = sel == true
            OptLbl.TextColor3 = sel and C.TextHdr or C.Text
            Row.BackgroundColor3 = sel and C.DropSel or C.DropItem
        end
        refreshItem()

        Row.MouseButton1Click:Connect(function()
            if selectedSet[opt] then
                selectedSet[opt] = nil
            else
                selectedSet[opt] = true
            end
            refreshItem()
            refreshHeader()
        end)
    end

    Hdr.MouseButton1Click:Connect(function()
        open = not open
        Dropdown.Visible = open
        Arrow.Text = open and "▴" or "▾"
        Outer.Size = UDim2.new(1, 0, 0, open and totalH or HDR_H)
    end)

    return Outer
end

-- =====================================================
--  SCROLLING CONTENT FRAME BUILDER
-- =====================================================
local function makeScrollContent(parent)
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = C.Accent
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.Parent = parent

    local Inner = Instance.new("Frame")
    Inner.Size = UDim2.new(1, -14, 0, 0)
    Inner.BackgroundTransparency = 1
    Inner.AutomaticSize = Enum.AutomaticSize.Y
    Inner.Parent = Scroll

    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 6)
    List.Parent = Inner

    local Pad = Instance.new("UIPadding")
    Pad.PaddingTop = UDim.new(0, 10)
    Pad.PaddingLeft = UDim.new(0, 12)
    Pad.PaddingRight = UDim.new(0, 8)
    Pad.PaddingBottom = UDim.new(0, 10)
    Pad.Parent = Inner

    return Inner
end

-- =====================================================
--  PAGES (content panels)
-- =====================================================
local pages = {}

local function newPage(name)
    local F = Instance.new("Frame")
    F.Name = name
    F.Size = UDim2.new(1, 0, 1, 0)
    F.BackgroundTransparency = 1
    F.Visible = false
    F.Parent = ContentArea
    pages[name] = F
    return F
end

local function showPage(name)
    for k, v in pairs(pages) do
        v.Visible = (k == name)
    end
end

-- =====================================================
--  SIDEBAR TABS
-- =====================================================
local sideButtons = {}
local activeTab = nil

local function addSideTab(name, icon)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = C.SidebarBG
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.LayoutOrder = #sideButtons + 1
    Btn.Parent = Sidebar
    corner(Btn, 6)

    local BtnLbl = Instance.new("TextLabel")
    BtnLbl.Text = icon .. "  " .. name
    BtnLbl.Size = UDim2.new(1, 0, 1, 0)
    BtnLbl.BackgroundTransparency = 1
    BtnLbl.TextColor3 = C.SideText
    BtnLbl.TextSize = 13
    BtnLbl.Font = Enum.Font.Gotham
    BtnLbl.TextXAlignment = Enum.TextXAlignment.Left
    BtnLbl.Parent = Btn

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0.7, 0)
    Indicator.Position = UDim2.new(0, -6, 0.15, 0)
    Indicator.BackgroundColor3 = C.SideActive
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = Btn
    corner(Indicator, 2)

    sideButtons[name] = {btn = Btn, lbl = BtnLbl, ind = Indicator}

    Btn.MouseButton1Click:Connect(function()
        if activeTab then
            local prev = sideButtons[activeTab]
            prev.btn.BackgroundColor3 = C.SidebarBG
            prev.lbl.TextColor3 = C.SideText
            prev.lbl.Font = Enum.Font.Gotham
            prev.ind.Visible = false
        end
        activeTab = name
        Btn.BackgroundColor3 = Color3.fromRGB(32, 32, 52)
        BtnLbl.TextColor3 = C.SideTextA
        BtnLbl.Font = Enum.Font.GothamBold
        Indicator.Visible = true
        showPage(name)
    end)

    return Btn
end

-- =====================================================
--  SIDEBAR TABS LIST
-- =====================================================
addSideTab("Farm", "🌸")
addSideTab("Bees", "🐝")
addSideTab("Quests", "📋")
addSideTab("Travel", "🗺️")
addSideTab("Misc", "⚙️")

-- =====================================================
--  PAGE: FARM
-- =====================================================
local FarmPage = newPage("Farm")
local FarmInner = makeScrollContent(FarmPage)

-- Section header
makeSectionHeader(FarmInner, "Farm")

-- Field multiselect
local fieldOptions = {
    "Pine Tree Forest", "Strawberry", "Pepper", "Bamboo",
    "Pineapple", "Coconut", "Mountain Top", "Pumpkin",
    "Cactus", "Stump", "Spider", "Blue Flower",
    "Mushroom", "Dandelion", "Sunflower", "Clover"
}
local selectedFields = {}
makeMultiselect(FarmInner, "Select Field", fieldOptions, selectedFields)

-- Main checkboxes
local cbAutoFarm      = {value = false}
local cbAutoSprinkler = {value = false}
local cbAutoDig       = {value = false}
makeCheckbox(FarmInner, "Auto Farm",      cbAutoFarm)
makeCheckbox(FarmInner, "Auto Sprinkler", cbAutoSprinkler)
makeCheckbox(FarmInner, "Auto Dig",       cbAutoDig)

-- ── Farm Settings subgroup ──────────────────────────
makeGroupHeader(FarmInner, "Farm Settings")

local cbPetals       = {value = false}
local cbBlooms       = {value = false}
local cbLeaves       = {value = false}
local cbMarks        = {value = false}
local cbIgnoreHoney  = {value = false}
local cbUnderBalloon = {value = false}
makeCheckbox(FarmInner, "Farm Petals",        cbPetals)
makeCheckbox(FarmInner, "Farm Blooms",        cbBlooms)
makeCheckbox(FarmInner, "Farm Leaves",        cbLeaves)
makeCheckbox(FarmInner, "Farm Marks",         cbMarks)
makeCheckbox(FarmInner, "Ignore Honey Tokens",cbIgnoreHoney)
makeCheckbox(FarmInner, "Farm Under Balloons",cbUnderBalloon)

-- Priority Tokens multiselect
local tokenOptions = {
    "Blue Boost", "Red Boost", "Haste", "Focus", "Baby Love",
    "Melody", "Inflate Balloon", "Surprise Party", "Fuzz Bombs",
    "Pollen Haze", "Target Practice", "Inferno", "Flame Fuel",
    "Summon Frog", "Triangulate", "Pollen Mark", "Mark Surge"
}
local selectedTokens = {}
makeMultiselect(FarmInner, "Priority Tokens", tokenOptions, selectedTokens)

-- ── Convert Settings subgroup ───────────────────────
makeGroupHeader(FarmInner, "Convert Settings")

local cbConvertHoney   = {value = false}
local slConvertAt      = {value = 100, min = 0,  max = 100}
local cbConvertBalloon = {value = false}
local slBalloonAt      = {value = 15,  min = 5,  max = 50}

-- Convert Honey + conditional slider
local ConvertHoneySliderWrap = Instance.new("Frame")
ConvertHoneySliderWrap.Size = UDim2.new(1, 0, 0, 0)
ConvertHoneySliderWrap.AutomaticSize = Enum.AutomaticSize.Y
ConvertHoneySliderWrap.BackgroundTransparency = 1
ConvertHoneySliderWrap.Parent = FarmInner

local convertHoneyRow = makeCheckbox(ConvertHoneySliderWrap, "Convert Honey", cbConvertHoney)

local ConvertAtSlider = makeSlider(ConvertHoneySliderWrap, "Convert Honey at", slConvertAt)
ConvertAtSlider.Visible = false
local convertAtPad = Instance.new("UIPadding")
convertAtPad.PaddingLeft = UDim.new(0, 10)
convertAtPad.Parent = ConvertAtSlider

cbConvertHoney.onChange = function(val)
    ConvertAtSlider.Visible = val
    ConvertHoneySliderWrap.Size = UDim2.new(1, 0, 0, val and 74 or 28)
end
ConvertHoneySliderWrap.Size = UDim2.new(1, 0, 0, 28)

-- Convert Hive Balloon + conditional slider
local ConvertBalloonWrap = Instance.new("Frame")
ConvertBalloonWrap.Size = UDim2.new(1, 0, 0, 28)
ConvertBalloonWrap.AutomaticSize = Enum.AutomaticSize.None
ConvertBalloonWrap.BackgroundTransparency = 1
ConvertBalloonWrap.Parent = FarmInner

makeCheckbox(ConvertBalloonWrap, "Convert Hive Balloon", cbConvertBalloon)

local BalloonAtSlider = makeSlider(ConvertBalloonWrap, "Convert Balloon at (blessing minutes)", slBalloonAt)
BalloonAtSlider.Position = UDim2.new(0, 10, 0, 28)
BalloonAtSlider.Visible = false

cbConvertBalloon.onChange = function(val)
    BalloonAtSlider.Visible = val
    ConvertBalloonWrap.Size = UDim2.new(1, 0, 0, val and 74 or 28)
end

-- =====================================================
--  PLACEHOLDER PAGES
-- =====================================================
local function makePlaceholder(pageName, icon, txt)
    local P = newPage(pageName)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, 0, 1, 0)
    L.BackgroundTransparency = 1
    L.Text = icon .. "\n" .. txt
    L.TextColor3 = C.TextDim
    L.TextSize = 14
    L.Font = Enum.Font.Gotham
    L.Parent = P
end

makePlaceholder("Bees",   "🐝", "Bees section – coming soon")
makePlaceholder("Quests", "📋", "Quests section – coming soon")
makePlaceholder("Travel", "🗺️", "Travel section – coming soon")
makePlaceholder("Misc",   "⚙️", "Misc section – coming soon")

-- =====================================================
--  DEFAULT TAB
-- =====================================================
sideButtons["Farm"].btn:ForceLostFocus()  -- reset focus
sideButtons["Farm"].btn.MouseButton1Click:Fire()

print("[BeeSwarmGUI] Loaded.")
