-- Bee Swarm Simulator | GUI v2
local Players       = game:GetService("Players")
local UIS           = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")
local LocalPlayer   = Players.LocalPlayer

-- ══════════════════════════════════════════════════════
--  THEME
-- ══════════════════════════════════════════════════════
local T = {
    -- window
    WinBG       = Color3.fromRGB(15, 15, 23),
    TitleBG     = Color3.fromRGB(22, 22, 34),
    TitleLine   = Color3.fromRGB(60, 120, 255),
    -- sidebar
    SideBG      = Color3.fromRGB(18, 18, 28),
    SideHover   = Color3.fromRGB(26, 26, 42),
    SideActive  = Color3.fromRGB(30, 30, 50),
    SidePill    = Color3.fromRGB(80, 140, 255),
    SideText    = Color3.fromRGB(140, 140, 175),
    SideTextA   = Color3.fromRGB(220, 220, 255),
    SideDivider = Color3.fromRGB(30, 30, 48),
    -- content
    ContentBG   = Color3.fromRGB(15, 15, 23),
    CardBG      = Color3.fromRGB(20, 20, 32),
    CardBorder  = Color3.fromRGB(35, 35, 58),
    -- group header
    GroupBG     = Color3.fromRGB(22, 22, 36),
    GroupPill   = Color3.fromRGB(80, 140, 255),
    GroupText   = Color3.fromRGB(180, 200, 255),
    -- checkbox
    CbOff       = Color3.fromRGB(35, 35, 55),
    CbOn        = Color3.fromRGB(60, 120, 255),
    CbBorder    = Color3.fromRGB(55, 55, 80),
    CbTick      = Color3.fromRGB(255, 255, 255),
    -- text
    TextPrimary = Color3.fromRGB(215, 215, 235),
    TextSecond  = Color3.fromRGB(130, 130, 165),
    TextAccent  = Color3.fromRGB(100, 160, 255),
    TextWhite   = Color3.fromRGB(255, 255, 255),
    -- slider
    SlBG        = Color3.fromRGB(30, 30, 48),
    SlFill      = Color3.fromRGB(60, 120, 255),
    SlKnob      = Color3.fromRGB(160, 190, 255),
    -- dropdown
    DropBG      = Color3.fromRGB(22, 22, 36),
    DropItem    = Color3.fromRGB(26, 26, 42),
    DropSel     = Color3.fromRGB(40, 75, 180),
    DropHov     = Color3.fromRGB(30, 30, 50),
    -- accent
    Accent      = Color3.fromRGB(80, 140, 255),
    AccentDim   = Color3.fromRGB(40, 75, 180),
    Red         = Color3.fromRGB(210, 65, 65),
    Gold        = Color3.fromRGB(255, 195, 70),
    Divider     = Color3.fromRGB(30, 30, 50),
}

local TI = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ══════════════════════════════════════════════════════
--  SCREENUI
-- ══════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeeSwarmGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local WIN_W, WIN_H = 720, 540
local SIDE_W       = 148

-- ══════════════════════════════════════════════════════
--  WINDOW
-- ══════════════════════════════════════════════════════
local Window = Instance.new("Frame")
Window.Name       = "Window"
Window.Size       = UDim2.new(0, WIN_W, 0, WIN_H)
Window.Position   = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
Window.BackgroundColor3 = T.WinBG
Window.BorderSizePixel  = 0
Window.Active     = true
Window.Draggable  = true
Window.ClipsDescendants = true
Window.Parent     = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 12)

-- outer glow / shadow via stroke
local WinStroke = Instance.new("UIStroke")
WinStroke.Color     = Color3.fromRGB(60, 80, 160)
WinStroke.Thickness = 1.5
WinStroke.Transparency = 0.5
WinStroke.Parent    = Window

-- ══════════════════════════════════════════════════════
--  TITLE BAR
-- ══════════════════════════════════════════════════════
local TitleBar = Instance.new("Frame")
TitleBar.Size   = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = T.TitleBG
TitleBar.BorderSizePixel  = 0
TitleBar.ZIndex = 4
TitleBar.Parent = Window

-- Gradient overlay on title
local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 60, 140)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 30)),
})
TitleGrad.Rotation = 90
TitleGrad.Parent   = TitleBar

-- bottom accent line
local TitleLine = Instance.new("Frame")
TitleLine.Size   = UDim2.new(1, 0, 0, 2)
TitleLine.Position = UDim2.new(0, 0, 1, -2)
TitleLine.BackgroundColor3 = T.TitleLine
TitleLine.BorderSizePixel  = 0
TitleLine.ZIndex = 5
TitleLine.Parent = TitleBar

local TitleLineGrad = Instance.new("UIGradient")
TitleLineGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, T.Accent),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 200, 255)),
    ColorSequenceKeypoint.new(1, T.AccentDim),
})
TitleLineGrad.Parent = TitleLine

-- bee icon frame
local IconFrame = Instance.new("Frame")
IconFrame.Size   = UDim2.new(0, 32, 0, 32)
IconFrame.Position = UDim2.new(0, 10, 0.5, -16)
IconFrame.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
IconFrame.BorderSizePixel  = 0
IconFrame.ZIndex = 6
IconFrame.Parent = TitleBar
Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(0, 8)

local IconGrad = Instance.new("UIGradient")
IconGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 90, 200)),
})
IconGrad.Rotation = 135
IconGrad.Parent   = IconFrame

local IconLbl = Instance.new("TextLabel")
IconLbl.Text  = "🐝"
IconLbl.Size  = UDim2.new(1, 0, 1, 0)
IconLbl.BackgroundTransparency = 1
IconLbl.TextSize = 18
IconLbl.Font  = Enum.Font.GothamBold
IconLbl.ZIndex = 7
IconLbl.Parent = IconFrame

-- title text
local TitleLbl = Instance.new("TextLabel")
TitleLbl.Text  = "Bee Swarm Simulator"
TitleLbl.Size  = UDim2.new(0, 220, 1, 0)
TitleLbl.Position = UDim2.new(0, 50, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.TextColor3 = T.TextWhite
TitleLbl.TextSize   = 15
TitleLbl.Font  = Enum.Font.GothamBold
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 6
TitleLbl.Parent = TitleBar

local SubTitleLbl = Instance.new("TextLabel")
SubTitleLbl.Text  = "Script Hub"
SubTitleLbl.Size  = UDim2.new(0, 200, 0, 14)
SubTitleLbl.Position = UDim2.new(0, 51, 0.5, 3)
SubTitleLbl.BackgroundTransparency = 1
SubTitleLbl.TextColor3 = T.TextSecond
SubTitleLbl.TextSize   = 11
SubTitleLbl.Font  = Enum.Font.Gotham
SubTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLbl.ZIndex = 6
SubTitleLbl.Parent = TitleBar

-- close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size   = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundColor3 = T.Red
CloseBtn.Text   = "✕"
CloseBtn.TextColor3 = T.TextWhite
CloseBtn.TextSize   = 13
CloseBtn.Font   = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 6
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TI, {BackgroundColor3 = Color3.fromRGB(240, 80, 80)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TI, {BackgroundColor3 = T.Red}):Play()
end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ══════════════════════════════════════════════════════
--  SIDEBAR
-- ══════════════════════════════════════════════════════
local Sidebar = Instance.new("Frame")
Sidebar.Size   = UDim2.new(0, SIDE_W, 1, -46)
Sidebar.Position = UDim2.new(0, 0, 0, 46)
Sidebar.BackgroundColor3 = T.SideBG
Sidebar.BorderSizePixel  = 0
Sidebar.ClipsDescendants = true
Sidebar.ZIndex = 3
Sidebar.Parent = Window

local SideStroke = Instance.new("UIStroke")
SideStroke.Color     = T.SideDivider
SideStroke.Thickness = 1
SideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SideStroke.Parent    = Sidebar

local SideList = Instance.new("UIListLayout")
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Padding   = UDim.new(0, 3)
SideList.Parent    = Sidebar

local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop    = UDim.new(0, 12)
SidePad.PaddingBottom = UDim.new(0, 12)
SidePad.PaddingLeft   = UDim.new(0, 8)
SidePad.PaddingRight  = UDim.new(0, 8)
SidePad.Parent = Sidebar

-- ══════════════════════════════════════════════════════
--  CONTENT AREA
-- ══════════════════════════════════════════════════════
local ContentArea = Instance.new("Frame")
ContentArea.Size   = UDim2.new(0, WIN_W - SIDE_W - 1, 1, -46)
ContentArea.Position = UDim2.new(0, SIDE_W + 1, 0, 46)
ContentArea.BackgroundColor3 = T.ContentBG
ContentArea.BorderSizePixel  = 0
ContentArea.ClipsDescendants = true
ContentArea.ZIndex = 3
ContentArea.Parent = Window

-- vertical divider line
local DivLine = Instance.new("Frame")
DivLine.Size   = UDim2.new(0, 1, 1, -46)
DivLine.Position = UDim2.new(0, SIDE_W, 0, 46)
DivLine.BackgroundColor3 = T.Divider
DivLine.BorderSizePixel  = 0
DivLine.ZIndex = 4
DivLine.Parent = Window

-- ══════════════════════════════════════════════════════
--  UTILITY FUNCTIONS
-- ══════════════════════════════════════════════════════
local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
    return c
end

local function stroke(p, color, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color       = color or T.CardBorder
    s.Thickness   = thick or 1
    s.Transparency = trans or 0
    s.Parent = p
    return s
end

-- ── CHECKBOX ─────────────────────────────────────────
local function makeCheckbox(parent, text, state)
    local Row = Instance.new("Frame")
    Row.Size   = UDim2.new(1, 0, 0, 32)
    Row.BackgroundColor3 = T.CardBG
    Row.BorderSizePixel  = 0
    Row.Parent = parent
    corner(Row, 7)
    stroke(Row, T.CardBorder, 1, 0.6)

    -- toggle pill (right side)
    local PillBG = Instance.new("Frame")
    PillBG.Size   = UDim2.new(0, 38, 0, 20)
    PillBG.Position = UDim2.new(1, -46, 0.5, -10)
    PillBG.BackgroundColor3 = T.CbOff
    PillBG.BorderSizePixel  = 0
    PillBG.ZIndex = 2
    PillBG.Parent = Row
    corner(PillBG, 10)

    local PillKnob = Instance.new("Frame")
    PillKnob.Size   = UDim2.new(0, 14, 0, 14)
    PillKnob.Position = UDim2.new(0, 3, 0.5, -7)
    PillKnob.BackgroundColor3 = Color3.fromRGB(160, 160, 190)
    PillKnob.BorderSizePixel  = 0
    PillKnob.ZIndex = 3
    PillKnob.Parent = PillBG
    corner(PillKnob, 7)

    local Lbl = Instance.new("TextLabel")
    Lbl.Text  = text
    Lbl.Size  = UDim2.new(1, -56, 1, 0)
    Lbl.Position = UDim2.new(0, 12, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = T.TextPrimary
    Lbl.TextSize   = 13
    Lbl.Font  = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 2
    Lbl.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size  = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text  = ""
    Btn.ZIndex = 4
    Btn.Parent = Row

    local function refresh(anim)
        if state.value then
            if anim then
                TweenService:Create(PillBG,   TI, {BackgroundColor3 = T.CbOn}):Play()
                TweenService:Create(PillKnob, TI, {Position = UDim2.new(0, 21, 0.5, -7), BackgroundColor3 = T.TextWhite}):Play()
                TweenService:Create(Lbl,      TI, {TextColor3 = T.TextWhite}):Play()
            else
                PillBG.BackgroundColor3   = T.CbOn
                PillKnob.Position         = UDim2.new(0, 21, 0.5, -7)
                PillKnob.BackgroundColor3 = T.TextWhite
                Lbl.TextColor3            = T.TextWhite
            end
        else
            if anim then
                TweenService:Create(PillBG,   TI, {BackgroundColor3 = T.CbOff}):Play()
                TweenService:Create(PillKnob, TI, {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Color3.fromRGB(160, 160, 190)}):Play()
                TweenService:Create(Lbl,      TI, {TextColor3 = T.TextPrimary}):Play()
            else
                PillBG.BackgroundColor3   = T.CbOff
                PillKnob.Position         = UDim2.new(0, 3, 0.5, -7)
                PillKnob.BackgroundColor3 = Color3.fromRGB(160, 160, 190)
                Lbl.TextColor3            = T.TextPrimary
            end
        end
    end

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Row, TI, {BackgroundColor3 = Color3.fromRGB(25, 25, 40)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Row, TI, {BackgroundColor3 = T.CardBG}):Play()
    end)
    Btn.MouseButton1Click:Connect(function()
        state.value = not state.value
        refresh(true)
        if state.onChange then state.onChange(state.value) end
    end)
    refresh(false)
    return Row
end

-- ── SECTION HEADER ────────────────────────────────────
local function makeSectionHeader(parent, text)
    local F = Instance.new("Frame")
    F.Size   = UDim2.new(1, 0, 0, 32)
    F.BackgroundColor3 = T.GroupBG
    F.BorderSizePixel  = 0
    F.Parent = parent
    corner(F, 8)

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 55, 130)),
        ColorSequenceKeypoint.new(1, T.GroupBG),
    })
    grad.Parent = F

    local pill = Instance.new("Frame")
    pill.Size   = UDim2.new(0, 3, 0.6, 0)
    pill.Position = UDim2.new(0, 10, 0.2, 0)
    pill.BackgroundColor3 = T.Gold
    pill.BorderSizePixel  = 0
    pill.Parent = F
    corner(pill, 2)

    local L = Instance.new("TextLabel")
    L.Text  = text:upper()
    L.Size  = UDim2.new(1, -24, 1, 0)
    L.Position = UDim2.new(0, 20, 0, 0)
    L.BackgroundTransparency = 1
    L.TextColor3 = T.Gold
    L.TextSize   = 11
    L.Font  = Enum.Font.GothamBold
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.LetterSpacing  = 2
    L.Parent = F
    return F
end

-- ── GROUP HEADER ──────────────────────────────────────
local function makeGroupHeader(parent, text)
    local F = Instance.new("Frame")
    F.Size   = UDim2.new(1, 0, 0, 26)
    F.BackgroundTransparency = 1
    F.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size   = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 0.5, 0)
    Line.BackgroundColor3 = T.Divider
    Line.BorderSizePixel  = 0
    Line.Parent = F

    local Badge = Instance.new("Frame")
    Badge.Size   = UDim2.new(0, 0, 0, 20)
    Badge.Position = UDim2.new(0, 0, 0.5, -10)
    Badge.AutomaticSize = Enum.AutomaticSize.X
    Badge.BackgroundColor3 = T.AccentDim
    Badge.BorderSizePixel  = 0
    Badge.Parent = F
    corner(Badge, 5)

    local BadgePad = Instance.new("UIPadding")
    BadgePad.PaddingLeft  = UDim.new(0, 8)
    BadgePad.PaddingRight = UDim.new(0, 8)
    BadgePad.Parent = Badge

    local L = Instance.new("TextLabel")
    L.Text  = text
    L.Size  = UDim2.new(0, 0, 1, 0)
    L.AutomaticSize = Enum.AutomaticSize.X
    L.BackgroundTransparency = 1
    L.TextColor3 = T.GroupText
    L.TextSize   = 11
    L.Font  = Enum.Font.GothamBold
    L.Parent = Badge

    return F
end

-- ── SLIDER ────────────────────────────────────────────
local function makeSlider(parent, text, state)
    local Wrap = Instance.new("Frame")
    Wrap.Size   = UDim2.new(1, 0, 0, 52)
    Wrap.BackgroundColor3 = T.CardBG
    Wrap.BorderSizePixel  = 0
    Wrap.Parent = parent
    corner(Wrap, 7)
    stroke(Wrap, T.CardBorder, 1, 0.6)

    local TopRow = Instance.new("Frame")
    TopRow.Size   = UDim2.new(1, -20, 0, 20)
    TopRow.Position = UDim2.new(0, 10, 0, 8)
    TopRow.BackgroundTransparency = 1
    TopRow.Parent = Wrap

    local Lbl = Instance.new("TextLabel")
    Lbl.Text  = text
    Lbl.Size  = UDim2.new(0.75, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = T.TextPrimary
    Lbl.TextSize   = 12
    Lbl.Font  = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = TopRow

    local ValBadge = Instance.new("Frame")
    ValBadge.Size   = UDim2.new(0, 40, 1, 0)
    ValBadge.Position = UDim2.new(1, -40, 0, 0)
    ValBadge.BackgroundColor3 = T.AccentDim
    ValBadge.BorderSizePixel  = 0
    ValBadge.Parent = TopRow
    corner(ValBadge, 5)

    local ValLbl = Instance.new("TextLabel")
    ValLbl.Size  = UDim2.new(1, 0, 1, 0)
    ValLbl.BackgroundTransparency = 1
    ValLbl.TextColor3 = T.TextAccent
    ValLbl.TextSize   = 12
    ValLbl.Font  = Enum.Font.GothamBold
    ValLbl.Parent = ValBadge

    local Track = Instance.new("Frame")
    Track.Size   = UDim2.new(1, -20, 0, 6)
    Track.Position = UDim2.new(0, 10, 0, 36)
    Track.BackgroundColor3 = T.SlBG
    Track.BorderSizePixel  = 0
    Track.Parent = Wrap
    corner(Track, 3)

    local Fill = Instance.new("Frame")
    Fill.Size   = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = T.SlFill
    Fill.BorderSizePixel  = 0
    Fill.Parent = Track
    corner(Fill, 3)

    local FillGrad = Instance.new("UIGradient")
    FillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 140, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 180, 255)),
    })
    FillGrad.Parent = Fill

    local Knob = Instance.new("Frame")
    Knob.Size   = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, -8, 0.5, -8)
    Knob.BackgroundColor3 = T.TextWhite
    Knob.BorderSizePixel  = 0
    Knob.ZIndex = 3
    Knob.Parent = Track
    corner(Knob, 8)
    stroke(Knob, T.SlFill, 2, 0)

    local DragBtn = Instance.new("TextButton")
    DragBtn.Size  = UDim2.new(1, 20, 0, 24)
    DragBtn.Position = UDim2.new(0, -10, 0.5, -12)
    DragBtn.BackgroundTransparency = 1
    DragBtn.Text  = ""
    DragBtn.ZIndex = 5
    DragBtn.Parent = Track

    local function updateVisual()
        local pct = (state.value - state.min) / (state.max - state.min)
        Fill.Size = UDim2.new(pct, 0, 1, 0)
        Knob.Position = UDim2.new(pct, -8, 0.5, -8)
        ValLbl.Text = tostring(math.floor(state.value))
    end
    updateVisual()

    local dragging = false
    DragBtn.MouseButton1Down:Connect(function()
        dragging = true
        TweenService:Create(Knob, TI, {Size = UDim2.new(0, 18, 0, 18)}):Play()
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
            TweenService:Create(Knob, TI, {Size = UDim2.new(0, 16, 0, 16)}):Play()
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local pct = math.clamp((inp.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            state.value = state.min + pct * (state.max - state.min)
            updateVisual()
        end
    end)

    return Wrap
end

-- ── COMBOBOX (single select, always-visible scroll list) ──
local function makeCombobox(parent, titleText, options, stateRef)
    local ITEM_H = 26
    local HDR_H  = 22
    local LIST_H = 130
    local TOTAL  = HDR_H + 4 + LIST_H

    local Outer = Instance.new("Frame")
    Outer.Size  = UDim2.new(1, 0, 0, TOTAL)
    Outer.BackgroundColor3 = T.DropBG
    Outer.BorderSizePixel  = 0
    Outer.ClipsDescendants = true
    Outer.Parent = parent
    corner(Outer, 8)
    stroke(Outer, T.CardBorder, 1, 0.3)

    -- header label row
    local HdrRow = Instance.new("Frame")
    HdrRow.Size  = UDim2.new(1, 0, 0, HDR_H)
    HdrRow.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
    HdrRow.BorderSizePixel  = 0
    HdrRow.Parent = Outer

    local HdrIcon = Instance.new("TextLabel")
    HdrIcon.Text  = "📍"
    HdrIcon.Size  = UDim2.new(0, 22, 1, 0)
    HdrIcon.Position = UDim2.new(0, 6, 0, 0)
    HdrIcon.BackgroundTransparency = 1
    HdrIcon.TextSize = 12
    HdrIcon.Parent = HdrRow

    local HdrLbl = Instance.new("TextLabel")
    HdrLbl.Text  = titleText
    HdrLbl.Size  = UDim2.new(1, -30, 1, 0)
    HdrLbl.Position = UDim2.new(0, 28, 0, 0)
    HdrLbl.BackgroundTransparency = 1
    HdrLbl.TextColor3 = T.TextSecond
    HdrLbl.TextSize   = 11
    HdrLbl.Font  = Enum.Font.GothamBold
    HdrLbl.TextXAlignment = Enum.TextXAlignment.Left
    HdrLbl.LetterSpacing  = 1
    HdrLbl.Parent = HdrRow

    -- divider
    local Sep = Instance.new("Frame")
    Sep.Size  = UDim2.new(1, 0, 0, 1)
    Sep.Position = UDim2.new(0, 0, 0, HDR_H)
    Sep.BackgroundColor3 = T.Divider
    Sep.BorderSizePixel  = 0
    Sep.Parent = Outer

    -- scroll list
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size  = UDim2.new(1, 0, 0, LIST_H)
    Scroll.Position = UDim2.new(0, 0, 0, HDR_H + 4)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 3
    Scroll.ScrollBarImageColor3 = T.Accent
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #options * (ITEM_H + 3) + 8)
    Scroll.Parent = Outer

    local DdList = Instance.new("UIListLayout")
    DdList.SortOrder = Enum.SortOrder.LayoutOrder
    DdList.Padding   = UDim.new(0, 3)
    DdList.Parent    = Scroll

    local DdPad = Instance.new("UIPadding")
    DdPad.PaddingTop    = UDim.new(0, 4)
    DdPad.PaddingLeft   = UDim.new(0, 5)
    DdPad.PaddingRight  = UDim.new(0, 5)
    DdPad.Parent = Scroll

    local allRows = {}

    local function refreshAllRows()
        for _, r in ipairs(allRows) do
            local sel = stateRef.value == r.opt
            TweenService:Create(r.row, TI, {BackgroundColor3 = sel and T.DropSel or T.DropItem}):Play()
            r.lbl.TextColor3 = sel and T.TextWhite or T.TextPrimary
            r.lbl.Font       = sel and Enum.Font.GothamBold or Enum.Font.Gotham
            if r.dot then r.dot.Visible = sel end
        end
    end

    for _, opt in ipairs(options) do
        local Row = Instance.new("TextButton")
        Row.Size  = UDim2.new(1, 0, 0, ITEM_H)
        Row.BackgroundColor3 = T.DropItem
        Row.BorderSizePixel  = 0
        Row.Text  = ""
        Row.Parent = Scroll
        corner(Row, 5)

        -- selected dot indicator
        local Dot = Instance.new("Frame")
        Dot.Size  = UDim2.new(0, 6, 0, 6)
        Dot.Position = UDim2.new(0, 7, 0.5, -3)
        Dot.BackgroundColor3 = T.Accent
        Dot.BorderSizePixel  = 0
        Dot.Visible = false
        Dot.Parent = Row
        corner(Dot, 3)

        local OptLbl = Instance.new("TextLabel")
        OptLbl.Text  = opt
        OptLbl.Size  = UDim2.new(1, -22, 1, 0)
        OptLbl.Position = UDim2.new(0, 18, 0, 0)
        OptLbl.BackgroundTransparency = 1
        OptLbl.TextColor3 = T.TextPrimary
        OptLbl.TextSize   = 12
        OptLbl.Font  = Enum.Font.Gotham
        OptLbl.TextXAlignment = Enum.TextXAlignment.Left
        OptLbl.Parent = Row

        table.insert(allRows, {row = Row, lbl = OptLbl, opt = opt, dot = Dot})

        Row.MouseEnter:Connect(function()
            if stateRef.value ~= opt then
                TweenService:Create(Row, TI, {BackgroundColor3 = T.DropHov}):Play()
            end
        end)
        Row.MouseLeave:Connect(function()
            if stateRef.value ~= opt then
                TweenService:Create(Row, TI, {BackgroundColor3 = T.DropItem}):Play()
            end
        end)
        Row.MouseButton1Click:Connect(function()
            stateRef.value = opt
            refreshAllRows()
        end)
    end

    return Outer
end

-- ── MULTISELECT (always-visible scroll list with checkboxes) ──
local function makeMultiselect(parent, titleText, options, selectedSet)
    local ITEM_H = 26
    local HDR_H  = 22
    local LIST_H = 150
    local TOTAL  = HDR_H + 4 + LIST_H

    local Outer = Instance.new("Frame")
    Outer.Size  = UDim2.new(1, 0, 0, TOTAL)
    Outer.BackgroundColor3 = T.DropBG
    Outer.BorderSizePixel  = 0
    Outer.ClipsDescendants = true
    Outer.Parent = parent
    corner(Outer, 8)
    stroke(Outer, T.CardBorder, 1, 0.3)

    -- header row with count badge
    local HdrRow = Instance.new("Frame")
    HdrRow.Size  = UDim2.new(1, 0, 0, HDR_H)
    HdrRow.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
    HdrRow.BorderSizePixel  = 0
    HdrRow.Parent = Outer

    local HdrLbl = Instance.new("TextLabel")
    HdrLbl.Text  = titleText:upper()
    HdrLbl.Size  = UDim2.new(1, -50, 1, 0)
    HdrLbl.Position = UDim2.new(0, 10, 0, 0)
    HdrLbl.BackgroundTransparency = 1
    HdrLbl.TextColor3 = T.TextSecond
    HdrLbl.TextSize   = 11
    HdrLbl.Font  = Enum.Font.GothamBold
    HdrLbl.TextXAlignment = Enum.TextXAlignment.Left
    HdrLbl.LetterSpacing  = 1
    HdrLbl.Parent = HdrRow

    local CountBadge = Instance.new("Frame")
    CountBadge.Size  = UDim2.new(0, 26, 0, 16)
    CountBadge.Position = UDim2.new(1, -32, 0.5, -8)
    CountBadge.BackgroundColor3 = T.AccentDim
    CountBadge.BorderSizePixel  = 0
    CountBadge.Visible = false
    CountBadge.Parent  = HdrRow
    corner(CountBadge, 5)

    local CountLbl = Instance.new("TextLabel")
    CountLbl.Size  = UDim2.new(1, 0, 1, 0)
    CountLbl.BackgroundTransparency = 1
    CountLbl.TextColor3 = T.TextAccent
    CountLbl.TextSize   = 10
    CountLbl.Font  = Enum.Font.GothamBold
    CountLbl.Text  = "0"
    CountLbl.Parent = CountBadge

    -- divider
    local Sep = Instance.new("Frame")
    Sep.Size  = UDim2.new(1, 0, 0, 1)
    Sep.Position = UDim2.new(0, 0, 0, HDR_H)
    Sep.BackgroundColor3 = T.Divider
    Sep.BorderSizePixel  = 0
    Sep.Parent = Outer

    -- scroll list
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size  = UDim2.new(1, 0, 0, LIST_H)
    Scroll.Position = UDim2.new(0, 0, 0, HDR_H + 4)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 3
    Scroll.ScrollBarImageColor3 = T.Accent
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #options * (ITEM_H + 3) + 8)
    Scroll.Parent = Outer

    local DdList = Instance.new("UIListLayout")
    DdList.SortOrder = Enum.SortOrder.LayoutOrder
    DdList.Padding   = UDim.new(0, 3)
    DdList.Parent    = Scroll

    local DdPad = Instance.new("UIPadding")
    DdPad.PaddingTop    = UDim.new(0, 4)
    DdPad.PaddingLeft   = UDim.new(0, 5)
    DdPad.PaddingRight  = UDim.new(0, 5)
    DdPad.Parent = Scroll

    local function refreshCount()
        local n = 0
        for _ in pairs(selectedSet) do n = n + 1 end
        CountBadge.Visible = n > 0
        CountLbl.Text = tostring(n)
    end
    refreshCount()

    for _, opt in ipairs(options) do
        local Row = Instance.new("TextButton")
        Row.Size  = UDim2.new(1, 0, 0, ITEM_H)
        Row.BackgroundColor3 = T.DropItem
        Row.BorderSizePixel  = 0
        Row.Text  = ""
        Row.Parent = Scroll
        corner(Row, 5)

        local Chk = Instance.new("Frame")
        Chk.Size  = UDim2.new(0, 14, 0, 14)
        Chk.Position = UDim2.new(0, 7, 0.5, -7)
        Chk.BackgroundColor3 = T.CbOff
        Chk.BorderSizePixel  = 0
        Chk.Parent = Row
        corner(Chk, 3)

        local ChkTick = Instance.new("TextLabel")
        ChkTick.Text  = "✓"
        ChkTick.Size  = UDim2.new(1, 0, 1, 0)
        ChkTick.BackgroundTransparency = 1
        ChkTick.TextColor3 = T.TextWhite
        ChkTick.TextSize   = 10
        ChkTick.Font  = Enum.Font.GothamBold
        ChkTick.Visible = false
        ChkTick.Parent  = Chk

        local OptLbl = Instance.new("TextLabel")
        OptLbl.Text  = opt
        OptLbl.Size  = UDim2.new(1, -30, 1, 0)
        OptLbl.Position = UDim2.new(0, 28, 0, 0)
        OptLbl.BackgroundTransparency = 1
        OptLbl.TextColor3 = T.TextPrimary
        OptLbl.TextSize   = 12
        OptLbl.Font  = Enum.Font.Gotham
        OptLbl.TextXAlignment = Enum.TextXAlignment.Left
        OptLbl.Parent = Row

        local function refreshItem()
            local sel = selectedSet[opt] == true
            TweenService:Create(Chk, TI, {BackgroundColor3 = sel and T.CbOn or T.CbOff}):Play()
            ChkTick.Visible   = sel
            OptLbl.TextColor3 = sel and T.TextWhite or T.TextPrimary
            OptLbl.Font       = sel and Enum.Font.GothamBold or Enum.Font.Gotham
            TweenService:Create(Row, TI, {BackgroundColor3 = sel and T.DropSel or T.DropItem}):Play()
        end
        refreshItem()

        Row.MouseEnter:Connect(function()
            if not selectedSet[opt] then
                TweenService:Create(Row, TI, {BackgroundColor3 = T.DropHov}):Play()
            end
        end)
        Row.MouseLeave:Connect(function()
            if not selectedSet[opt] then
                TweenService:Create(Row, TI, {BackgroundColor3 = T.DropItem}):Play()
            end
        end)
        Row.MouseButton1Click:Connect(function()
            selectedSet[opt] = not selectedSet[opt] or nil
            refreshItem()
            refreshCount()
        end)
    end

    return Outer
end

-- ══════════════════════════════════════════════════════
--  SCROLL CONTENT BUILDER
-- ══════════════════════════════════════════════════════
local function makeScrollContent(parent)
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size  = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = T.Accent
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.Parent = parent

    local Inner = Instance.new("Frame")
    Inner.Size  = UDim2.new(1, -18, 0, 0)
    Inner.BackgroundTransparency = 1
    Inner.AutomaticSize = Enum.AutomaticSize.Y
    Inner.Parent = Scroll

    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding   = UDim.new(0, 7)
    List.Parent    = Inner

    local Pad = Instance.new("UIPadding")
    Pad.PaddingTop    = UDim.new(0, 14)
    Pad.PaddingLeft   = UDim.new(0, 14)
    Pad.PaddingRight  = UDim.new(0, 10)
    Pad.PaddingBottom = UDim.new(0, 14)
    Pad.Parent = Inner

    return Inner
end

-- ══════════════════════════════════════════════════════
--  PAGE SYSTEM
-- ══════════════════════════════════════════════════════
local pages = {}

local function newPage(name)
    local F = Instance.new("Frame")
    F.Name    = name
    F.Size    = UDim2.new(1, 0, 1, 0)
    F.BackgroundTransparency = 1
    F.Visible = false
    F.Parent  = ContentArea
    pages[name] = F
    return F
end

local function showPage(name)
    for k, v in pairs(pages) do
        v.Visible = (k == name)
    end
end

-- ══════════════════════════════════════════════════════
--  SIDEBAR TAB BUILDER
-- ══════════════════════════════════════════════════════
local sideButtons = {}
local activeTab   = nil

local tabDefs = {
    {name = "Farm",   icon = "🌸"},
    {name = "Bees",   icon = "🐝"},
    {name = "Quests", icon = "📋"},
    {name = "Travel", icon = "🗺️"},
    {name = "Misc",   icon = "⚙️"},
}

local function addSideTab(name, icon, order)
    local Wrap = Instance.new("Frame")
    Wrap.Size  = UDim2.new(1, 0, 0, 40)
    Wrap.BackgroundColor3 = T.SideBG
    Wrap.BorderSizePixel  = 0
    Wrap.LayoutOrder = order
    Wrap.Parent = Sidebar
    corner(Wrap, 8)

    -- active pill (left edge)
    local Pill = Instance.new("Frame")
    Pill.Size   = UDim2.new(0, 3, 0.55, 0)
    Pill.Position = UDim2.new(0, 0, 0.225, 0)
    Pill.BackgroundColor3 = T.SidePill
    Pill.BorderSizePixel  = 0
    Pill.Visible = false
    Pill.Parent  = Wrap
    corner(Pill, 2)

    local IconLb = Instance.new("TextLabel")
    IconLb.Text  = icon
    IconLb.Size  = UDim2.new(0, 24, 1, 0)
    IconLb.Position = UDim2.new(0, 10, 0, 0)
    IconLb.BackgroundTransparency = 1
    IconLb.TextSize = 16
    IconLb.Font  = Enum.Font.Gotham
    IconLb.Parent = Wrap

    local NameLb = Instance.new("TextLabel")
    NameLb.Text  = name
    NameLb.Size  = UDim2.new(1, -42, 1, 0)
    NameLb.Position = UDim2.new(0, 38, 0, 0)
    NameLb.BackgroundTransparency = 1
    NameLb.TextColor3 = T.SideText
    NameLb.TextSize   = 13
    NameLb.Font  = Enum.Font.Gotham
    NameLb.TextXAlignment = Enum.TextXAlignment.Left
    NameLb.Parent = Wrap

    local Btn = Instance.new("TextButton")
    Btn.Size  = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text  = ""
    Btn.ZIndex = 2
    Btn.Parent = Wrap

    Btn.MouseEnter:Connect(function()
        if activeTab ~= name then
            TweenService:Create(Wrap, TI, {BackgroundColor3 = T.SideHover}):Play()
        end
    end)
    Btn.MouseLeave:Connect(function()
        if activeTab ~= name then
            TweenService:Create(Wrap, TI, {BackgroundColor3 = T.SideBG}):Play()
        end
    end)

    sideButtons[name] = {wrap = Wrap, pill = Pill, namelb = NameLb}

    Btn.MouseButton1Click:Connect(function()
        if activeTab then
            local prev = sideButtons[activeTab]
            TweenService:Create(prev.wrap, TI, {BackgroundColor3 = T.SideBG}):Play()
            prev.pill.Visible = false
            prev.namelb.Font  = Enum.Font.Gotham
            TweenService:Create(prev.namelb, TI, {TextColor3 = T.SideText}):Play()
        end
        activeTab = name
        TweenService:Create(Wrap, TI, {BackgroundColor3 = T.SideActive}):Play()
        Pill.Visible      = true
        NameLb.Font       = Enum.Font.GothamBold
        TweenService:Create(NameLb, TI, {TextColor3 = T.SideTextA}):Play()
        showPage(name)
    end)

    return Btn
end

for i, td in ipairs(tabDefs) do
    addSideTab(td.name, td.icon, i)
end

-- thin spacer line at bottom of sidebar
local SideSep = Instance.new("Frame")
SideSep.Size  = UDim2.new(1, -16, 0, 1)
SideSep.Position = UDim2.new(0, 8, 1, -24)
SideSep.BackgroundColor3 = T.Divider
SideSep.BorderSizePixel  = 0
SideSep.Parent = Sidebar

local VerLbl = Instance.new("TextLabel")
VerLbl.Text  = "v2.0"
VerLbl.Size  = UDim2.new(1, 0, 0, 18)
VerLbl.Position = UDim2.new(0, 0, 1, -20)
VerLbl.BackgroundTransparency = 1
VerLbl.TextColor3 = T.TextSecond
VerLbl.TextSize   = 10
VerLbl.Font  = Enum.Font.Gotham
VerLbl.Parent = Sidebar

-- ══════════════════════════════════════════════════════
--  FARM PAGE
-- ══════════════════════════════════════════════════════
local FarmPage  = newPage("Farm")
local FarmInner = makeScrollContent(FarmPage)

makeSectionHeader(FarmInner, "Farm")

local fieldOptions = {
    "Pine Tree Forest","Strawberry","Pepper","Bamboo",
    "Pineapple","Coconut","Mountain Top","Pumpkin",
    "Cactus","Stump","Spider","Blue Flower",
    "Mushroom","Dandelion","Sunflower","Clover",
}
local selectedField = {value = ""}
makeCombobox(FarmInner, "Select Field", fieldOptions, selectedField)

local cbAutoFarm      = {value = false}
local cbAutoSprinkler = {value = false}
local cbAutoDig       = {value = false}
makeCheckbox(FarmInner, "Auto Farm",      cbAutoFarm)
makeCheckbox(FarmInner, "Auto Sprinkler", cbAutoSprinkler)
makeCheckbox(FarmInner, "Auto Dig",       cbAutoDig)

-- ── Farm Settings ─────────────────────────────────────
makeGroupHeader(FarmInner, "Farm Settings")

local cbPetals       = {value = false}
local cbBlooms       = {value = false}
local cbLeaves       = {value = false}
local cbMarks        = {value = false}
local cbIgnoreHoney  = {value = false}
local cbUnderBalloon = {value = false}
makeCheckbox(FarmInner, "Farm Petals",         cbPetals)
makeCheckbox(FarmInner, "Farm Blooms",         cbBlooms)
makeCheckbox(FarmInner, "Farm Leaves",         cbLeaves)
makeCheckbox(FarmInner, "Farm Marks",          cbMarks)
makeCheckbox(FarmInner, "Ignore Honey Tokens", cbIgnoreHoney)
makeCheckbox(FarmInner, "Farm Under Balloons", cbUnderBalloon)

local tokenOptions = {
    "Blue Boost","Red Boost","Haste","Focus","Baby Love",
    "Melody","Inflate Balloon","Surprise Party","Fuzz Bombs",
    "Pollen Haze","Target Practice","Inferno","Flame Fuel",
    "Summon Frog","Triangulate","Pollen Mark","Mark Surge",
}
local selectedTokens = {}
makeMultiselect(FarmInner, "Priority Tokens", tokenOptions, selectedTokens)

-- ── Convert Settings ──────────────────────────────────
makeGroupHeader(FarmInner, "Convert Settings")

local cbConvertHoney   = {value = false}
local slConvertAt      = {value = 100, min = 0,  max = 100}
local cbConvertBalloon = {value = false}
local slBalloonAt      = {value = 15,  min = 5,  max = 50}

-- Convert Honey wrap (UIListLayout keeps checkbox + slider stacked)
local CHWrap = Instance.new("Frame")
CHWrap.Size  = UDim2.new(1, 0, 0, 32)
CHWrap.BackgroundTransparency = 1
CHWrap.ClipsDescendants = false
CHWrap.Parent = FarmInner

local CHLayout = Instance.new("UIListLayout")
CHLayout.SortOrder = Enum.SortOrder.LayoutOrder
CHLayout.Padding   = UDim.new(0, 7)
CHLayout.Parent    = CHWrap

local chRow = makeCheckbox(CHWrap, "Convert Honey", cbConvertHoney)
chRow.LayoutOrder = 1

local chSlider = makeSlider(CHWrap, "Convert Honey at", slConvertAt)
chSlider.LayoutOrder = 2
chSlider.Visible     = false

cbConvertHoney.onChange = function(val)
    chSlider.Visible = val
    CHWrap.Size = UDim2.new(1, 0, 0, val and (32 + 7 + 52) or 32)
end

-- Convert Hive Balloon wrap
local CBWrap = Instance.new("Frame")
CBWrap.Size  = UDim2.new(1, 0, 0, 32)
CBWrap.BackgroundTransparency = 1
CBWrap.ClipsDescendants = false
CBWrap.Parent = FarmInner

local CBLayout = Instance.new("UIListLayout")
CBLayout.SortOrder = Enum.SortOrder.LayoutOrder
CBLayout.Padding   = UDim.new(0, 7)
CBLayout.Parent    = CBWrap

local cbRow = makeCheckbox(CBWrap, "Convert Hive Balloon", cbConvertBalloon)
cbRow.LayoutOrder = 1

local cbSlider = makeSlider(CBWrap, "Convert Balloon at (blessing minutes)", slBalloonAt)
cbSlider.LayoutOrder = 2
cbSlider.Visible     = false

cbConvertBalloon.onChange = function(val)
    cbSlider.Visible = val
    CBWrap.Size = UDim2.new(1, 0, 0, val and (32 + 7 + 52) or 32)
end

-- ══════════════════════════════════════════════════════
--  PLACEHOLDER PAGES
-- ══════════════════════════════════════════════════════
local placeholders = {
    {name="Bees",   icon="🐝", sub="Bee management coming soon"},
    {name="Quests", icon="📋", sub="Quest tracker coming soon"},
    {name="Travel", icon="🗺️", sub="Fast travel coming soon"},
    {name="Misc",   icon="⚙️", sub="Misc settings coming soon"},
}
for _, p in ipairs(placeholders) do
    local P  = newPage(p.name)
    local Ci = Instance.new("TextLabel")
    Ci.Text  = p.icon
    Ci.Size  = UDim2.new(1, 0, 0, 60)
    Ci.Position = UDim2.new(0, 0, 0.35, 0)
    Ci.BackgroundTransparency = 1
    Ci.TextSize = 40
    Ci.Font = Enum.Font.Gotham
    Ci.Parent = P

    local Ct = Instance.new("TextLabel")
    Ct.Text  = p.sub
    Ct.Size  = UDim2.new(1, 0, 0, 24)
    Ct.Position = UDim2.new(0, 0, 0.35, 64)
    Ct.BackgroundTransparency = 1
    Ct.TextColor3 = T.TextSecond
    Ct.TextSize   = 14
    Ct.Font  = Enum.Font.Gotham
    Ct.Parent = P
end

-- ══════════════════════════════════════════════════════
--  ACTIVATE DEFAULT TAB
-- ══════════════════════════════════════════════════════
sideButtons["Farm"].wrap.Parent:FindFirstChild("TextButton"):ForceLostFocus()
-- simulate click on Farm
do
    local sb = sideButtons["Farm"]
    activeTab = "Farm"
    sb.wrap.BackgroundColor3 = T.SideActive
    sb.pill.Visible  = true
    sb.namelb.Font   = Enum.Font.GothamBold
    sb.namelb.TextColor3 = T.SideTextA
    showPage("Farm")
end

print("[BeeSwarmGUI v2] Loaded.")
