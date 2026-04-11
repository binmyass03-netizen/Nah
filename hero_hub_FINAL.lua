-- HERO HUB FULLY MODIFIED WITH PC + MOBILE DESYNC

-- =========================
-- PC DESYNC (ROYALS)
-- =========================
local function runPCDesync()
    loadstring(game:HttpGet("https://pastefy.app/YOUR_ROYALS_RAW"))()
end

-- =========================
-- MOBILE DESYNC (FACTION)
-- =========================
local function runMobileDesync()
    loadstring(game:HttpGet("https://pastefy.app/YOUR_FACTION_RAW"))()
end


-- =========================
-- DESYNC PANEL BUTTON
-- =========================

createMobBtn("Des", Theme.Accent1, 4, function(self)
    ShowNotification("DESYNC", "Opening panel...")

    local gui = Instance.new("ScreenGui")
    gui.Name = "HeroDesyncSelector"
    gui.Parent = PlayerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 180, 0, 110)
    frame.Position = UDim2.new(0.5, -90, 0.5, -55)
    frame.BackgroundColor3 = Color3.fromRGB(20,15,35)
    Instance.new("UICorner", frame)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(186,120,255)

    local pc = Instance.new("TextButton", frame)
    pc.Size = UDim2.new(1, -20, 0, 40)
    pc.Position = UDim2.new(0, 10, 0, 10)
    pc.Text = "💻 pc desync"
    pc.BackgroundColor3 = Color3.fromRGB(120,60,255)
    pc.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", pc)

    local mobile = Instance.new("TextButton", frame)
    mobile.Size = UDim2.new(1, -20, 0, 40)
    mobile.Position = UDim2.new(0, 10, 0, 55)
    mobile.Text = "📱 mobile desync"
    mobile.BackgroundColor3 = Color3.fromRGB(200,40,40)
    mobile.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", mobile)

    pc.MouseButton1Click:Connect(function()
        runPCDesync()
    end)

    mobile.MouseButton1Click:Connect(function()
        runMobileDesync()
    end)
end)
