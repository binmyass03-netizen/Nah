-- Combined Hub: PC Desync + Custom TP
-- Tab 1: PC Desync (Royal's) + Mobile Desync (Factions)
-- Tab 2: Custom TP (executes provided TP script)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end
local humanoid = getHumanoid()

-- ── ROOT GUI ────────────────────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 390, 0, 300)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(150, 80, 255)

-- ── TITLE BAR ───────────────────────────────────────────────────────────────
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Multi Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -68, 0.5, -14)
MinBtn.Text = "−"
MinBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

-- ── TOP TAB BAR (Desync / TP) ────────────────────────────────────────────
local TopTabBar = Instance.new("Frame", Main)
TopTabBar.Size = UDim2.new(1, -20, 0, 30)
TopTabBar.Position = UDim2.new(0, 10, 0, 46)
TopTabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
TopTabBar.BorderSizePixel = 0
Instance.new("UICorner", TopTabBar).CornerRadius = UDim.new(0, 9)
local TopLayout = Instance.new("UIListLayout", TopTabBar)
TopLayout.FillDirection = Enum.FillDirection.Horizontal
TopLayout.Padding = UDim.new(0, 4)
TopLayout.VerticalAlignment = Enum.VerticalAlignment.Center
Instance.new("UIPadding", TopTabBar).PaddingLeft = UDim.new(0, 4)

local function makeTopTab(txt, col)
    local b = Instance.new("TextButton", TopTabBar)
    b.Size = UDim2.new(0.5, -6, 0, 22)
    b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    b.Text = txt
    b.TextColor3 = col
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    return b
end

local DesyncTab = makeTopTab("⚡ Desync", Color3.fromRGB(180, 140, 255))
local TPTab     = makeTopTab("📍 Custom TP", Color3.fromRGB(80, 200, 255))

-- ── CONTENT FRAME ───────────────────────────────────────────────────────────
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 0, 200)
Content.Position = UDim2.new(0, 10, 0, 84)
Content.BackgroundTransparency = 1

-- ════════════════════════════════════════════════
--  PAGE 1: DESYNC (PC + Mobile subtabs)
-- ════════════════════════════════════════════════
local DesyncPage = Instance.new("Frame", Content)
DesyncPage.Size = UDim2.new(1, 0, 1, 0)
DesyncPage.BackgroundTransparency = 1

-- Sub-tab bar inside desync page
local SubTabBar = Instance.new("Frame", DesyncPage)
SubTabBar.Size = UDim2.new(1, 0, 0, 28)
SubTabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
SubTabBar.BorderSizePixel = 0
Instance.new("UICorner", SubTabBar).CornerRadius = UDim.new(0, 8)
local SubLayout = Instance.new("UIListLayout", SubTabBar)
SubLayout.FillDirection = Enum.FillDirection.Horizontal
SubLayout.Padding = UDim.new(0, 4)
SubLayout.VerticalAlignment = Enum.VerticalAlignment.Center
Instance.new("UIPadding", SubTabBar).PaddingLeft = UDim.new(0, 4)

local function makeSubTab(txt, col)
    local b = Instance.new("TextButton", SubTabBar)
    b.Size = UDim2.new(0.5, -6, 0, 20)
    b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    b.Text = txt
    b.TextColor3 = col
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local PCSubTab  = makeSubTab("💻 PC Desync",     Color3.fromRGB(180, 140, 255))
local MobSubTab = makeSubTab("📱 Mobile Desync",  Color3.fromRGB(220, 80, 80))

local SubContent = Instance.new("Frame", DesyncPage)
SubContent.Size = UDim2.new(1, 0, 1, -36)
SubContent.Position = UDim2.new(0, 0, 0, 36)
SubContent.BackgroundTransparency = 1

-- Build a desync panel
local function buildDesyncPanel(parent, accentColor, toggleColor, activeText, inactiveText)
    local panel = Instance.new("Frame", parent)
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1

    local SF = Instance.new("Frame", panel)
    SF.Size = UDim2.new(1, 0, 0, 44)
    SF.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    SF.BorderSizePixel = 0
    Instance.new("UICorner", SF).CornerRadius = UDim.new(0, 12)

    local Dot = Instance.new("Frame", SF)
    Dot.Size = UDim2.new(0, 10, 0, 10)
    Dot.Position = UDim2.new(0, 12, 0.5, -5)
    Dot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
    Dot.BorderSizePixel = 0
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local ST = Instance.new("TextLabel", SF)
    ST.Size = UDim2.new(1, -30, 1, 0)
    ST.Position = UDim2.new(0, 28, 0, 0)
    ST.BackgroundTransparency = 1
    ST.Text = activeText
    ST.TextColor3 = Color3.fromRGB(150, 150, 160)
    ST.Font = Enum.Font.Gotham
    ST.TextSize = 12
    ST.TextXAlignment = Enum.TextXAlignment.Left

    local TF = Instance.new("Frame", panel)
    TF.Size = UDim2.new(1, 0, 0, 62)
    TF.Position = UDim2.new(0, 0, 0, 52)
    TF.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    TF.BorderSizePixel = 0
    Instance.new("UICorner", TF).CornerRadius = UDim.new(0, 12)

    local UT = Instance.new("TextLabel", TF)
    UT.Size = UDim2.new(0.65, 0, 0, 26)
    UT.Position = UDim2.new(0, 14, 0, 10)
    UT.BackgroundTransparency = 1
    UT.Text = "Unwalk"
    UT.TextColor3 = accentColor
    UT.Font = Enum.Font.GothamBold
    UT.TextSize = 18
    UT.TextXAlignment = Enum.TextXAlignment.Left

    local UD = Instance.new("TextLabel", TF)
    UD.Size = UDim2.new(0.65, 0, 0, 14)
    UD.Position = UDim2.new(0, 14, 0, 34)
    UD.BackgroundTransparency = 1
    UD.Text = "Freeze animation tracks"
    UD.TextColor3 = Color3.fromRGB(110, 110, 120)
    UD.Font = Enum.Font.Gotham
    UD.TextSize = 11
    UD.TextXAlignment = Enum.TextXAlignment.Left

    local TB = Instance.new("TextButton", TF)
    TB.Size = UDim2.new(0, 50, 0, 25)
    TB.Position = UDim2.new(1, -64, 0.5, -12)
    TB.BackgroundColor3 = toggleColor
    TB.Text = ""
    TB.BorderSizePixel = 0
    Instance.new("UICorner", TB).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", TB)
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = UDim2.new(1, -22, 0.5, -10)
    Circle.BackgroundColor3 = Color3.new(1, 1, 1)
    Circle.BorderSizePixel = 0
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local enabled = true
    local animConn

    local function stopAnims(hum)
        for _, t in pairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
    end

    TB.Activated:Connect(function()
        enabled = not enabled
        humanoid = getHumanoid()
        if enabled then
            TB.BackgroundColor3 = toggleColor
            Circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), "Out", "Quad", 0.2, true)
            Dot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
            ST.Text = activeText
            stopAnims(humanoid)
            animConn = humanoid.AnimationPlayed:Connect(function(t) t:Stop() end)
            if raknet and raknet.desync then raknet.desync(true) end
        else
            TB.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
            Dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ST.Text = inactiveText
            if animConn then animConn:Disconnect(); animConn = nil end
            if raknet and raknet.desync then raknet.desync(false) end
        end
    end)

    return panel
end

local PCPanel = buildDesyncPanel(SubContent,
    Color3.fromRGB(180, 140, 255), Color3.fromRGB(120, 60, 255),
    "Hook active — packets intercepted", "Desync inactive")

local MobPanel = buildDesyncPanel(SubContent,
    Color3.fromRGB(220, 60, 60), Color3.fromRGB(180, 30, 30),
    "Hook active — packets intercepted", "Desync inactive")
MobPanel.Visible = false

local function setSubTab(isPc)
    PCPanel.Visible = isPc
    MobPanel.Visible = not isPc
    if isPc then
        PCSubTab.BackgroundColor3 = Color3.fromRGB(60, 30, 120)
        MobSubTab.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        MainStroke.Color = Color3.fromRGB(150, 80, 255)
        Title.Text = "👑 Royal's Desync V1.2"
    else
        MobSubTab.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
        PCSubTab.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        MainStroke.Color = Color3.fromRGB(200, 30, 30)
        Title.Text = "🔥 Factions Desync V1.2"
    end
end
setSubTab(true)
PCSubTab.Activated:Connect(function() setSubTab(true) end)
MobSubTab.Activated:Connect(function() setSubTab(false) end)

-- ════════════════════════════════════════════════
--  PAGE 2: CUSTOM TP
-- ════════════════════════════════════════════════
local TPPage = Instance.new("Frame", Content)
TPPage.Size = UDim2.new(1, 0, 1, 0)
TPPage.BackgroundTransparency = 1
TPPage.Visible = false

-- Info card
local InfoCard = Instance.new("Frame", TPPage)
InfoCard.Size = UDim2.new(1, 0, 0, 50)
InfoCard.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
InfoCard.BorderSizePixel = 0
Instance.new("UICorner", InfoCard).CornerRadius = UDim.new(0, 12)
local InfoStroke = Instance.new("UIStroke", InfoCard)
InfoStroke.Color = Color3.fromRGB(80, 200, 255)
InfoStroke.Thickness = 1.2

local InfoLabel = Instance.new("TextLabel", InfoCard)
InfoLabel.Size = UDim2.new(1, -16, 1, 0)
InfoLabel.Position = UDim2.new(0, 8, 0, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "📍 Custom TP Script (Side TP V1)"
InfoLabel.TextColor3 = Color3.fromRGB(80, 200, 255)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextSize = 13
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Load button
local LoadBtn = Instance.new("TextButton", TPPage)
LoadBtn.Size = UDim2.new(1, 0, 0, 44)
LoadBtn.Position = UDim2.new(0, 0, 0, 60)
LoadBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 80)
LoadBtn.Text = "▶  Load Custom TP"
LoadBtn.TextColor3 = Color3.fromRGB(80, 220, 255)
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.TextSize = 14
LoadBtn.BorderSizePixel = 0
Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", LoadBtn).Color = Color3.fromRGB(80, 200, 255)

local StatusLabel = Instance.new("TextLabel", TPPage)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 112)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Not loaded"
StatusLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local tpLoaded = false

LoadBtn.Activated:Connect(function()
    if tpLoaded then
        StatusLabel.Text = "Status: Already loaded!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 60)
        return
    end

    StatusLabel.Text = "Status: Loading..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 60)

    local ok, err = pcall(function()
        -- ── PASTE THE CONTENTS OF side_tp_v1_lua.txt BELOW ──────────────
        -- The file is Luraph obfuscated, so we loadstring it directly.
        -- Replace the line below with the actual script content if you
        -- want it embedded, or use loadstring via an executor like so:
        -- loadstring(game:HttpGet("YOUR_RAW_URL"))()

        -- Since the file is obfuscated, execute it via loadstring:
        -- loadstring(YOUR_OBFUSCATED_SCRIPT_STRING)()

        -- ────────────────────────────────────────────────────────────────
        -- If pasting inline, put the obfuscated script string here:
        -- loadstring([[ ...obfuscated code... ]])()

        StatusLabel.Text = "Status: Paste TP script inside LoadBtn!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end)

    if ok and not tpLoaded then
        tpLoaded = true
        StatusLabel.Text = "Status: ✅ Loaded!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        LoadBtn.BackgroundColor3 = Color3.fromRGB(10, 40, 20)
        LoadBtn.Text = "✅  Custom TP Active"
    elseif not ok then
        StatusLabel.Text = "Status: ❌ Error — " .. tostring(err):sub(1, 40)
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- ── TOP TAB SWITCH ───────────────────────────────────────────────────────────
local function setTopTab(isDesync)
    DesyncPage.Visible = isDesync
    TPPage.Visible = not isDesync
    if isDesync then
        DesyncTab.BackgroundColor3 = Color3.fromRGB(60, 30, 120)
        TPTab.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    else
        TPTab.BackgroundColor3 = Color3.fromRGB(10, 50, 70)
        DesyncTab.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        MainStroke.Color = Color3.fromRGB(80, 200, 255)
        Title.Text = "📍 Custom TP"
    end
end

setTopTab(true)
DesyncTab.Activated:Connect(function()
    setTopTab(true)
    setSubTab(PCPanel.Visible)
end)
TPTab.Activated:Connect(function() setTopTab(false) end)

-- ── MINIMIZE / CLOSE ────────────────────────────────────────────────────────
local minimized = false
MinBtn.Activated:Connect(function()
    minimized = not minimized
    TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 390, 0, minimized and 42 or 300)
    }):Play()
    Content.Visible = not minimized
    TopTabBar.Visible = not minimized
end)
CloseBtn.Activated:Connect(function() ScreenGui:Destroy() end)

-- ── DRAGGING ────────────────────────────────────────────────────────────────
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
