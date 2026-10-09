--[[
===============================================================
 FES | ARABIC NEON CONTROL PANEL
 Version: 1.0
 Language: Arabic
 Theme: Black / Neon Green
 Runtime: Roblox Lua UI prototype
===============================================================

IMPORTANT:
- This file creates a user interface prototype.
- It does not bypass Roblox protections or grant admin access.
- Feature buttons display status messages until connected to
  legitimate systems in a game you own or administer.
- Do not paste untrusted code into executors.
===============================================================
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
if not player then
    warn("FES: LocalPlayer is not available.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local CONFIG = {
    Name = "FES",
    Version = "1.0",
    Width = 350,
    Height = 470,
    CornerRadius = 12,
    AnimationTime = 0.18,
    ButtonHeight = 42,
    ButtonGap = 8,
}

local COLORS = {
    Background = Color3.fromRGB(5, 10, 8),
    Panel = Color3.fromRGB(10, 20, 15),
    PanelHover = Color3.fromRGB(18, 38, 25),
    Green = Color3.fromRGB(0, 255, 100),
    GreenDim = Color3.fromRGB(0, 125, 60),
    White = Color3.fromRGB(235, 255, 240),
    Muted = Color3.fromRGB(130, 165, 140),
    Red = Color3.fromRGB(210, 55, 65),
    Amber = Color3.fromRGB(255, 190, 60),
}

local PALETTES = {
    {
        Name = "نيون أخضر",
        Accent = Color3.fromRGB(0, 255, 100),
        Panel = Color3.fromRGB(10, 20, 15),
        Background = Color3.fromRGB(5, 10, 8),
    },
    {
        Name = "أزرق إلكتروني",
        Accent = Color3.fromRGB(0, 190, 255),
        Panel = Color3.fromRGB(8, 18, 30),
        Background = Color3.fromRGB(4, 8, 15),
    },
    {
        Name = "بنفسجي",
        Accent = Color3.fromRGB(200, 80, 255),
        Panel = Color3.fromRGB(24, 12, 30),
        Background = Color3.fromRGB(9, 5, 13),
    },
    {
        Name = "أحمر",
        Accent = Color3.fromRGB(255, 65, 75),
        Panel = Color3.fromRGB(30, 10, 12),
        Background = Color3.fromRGB(12, 5, 6),
    },
}

local currentPaletteIndex = 1
local currentPalette = PALETTES[currentPaletteIndex]
local statusText = "جاهز"
local selectedCategory = "الرئيسية"
local destroyed = false
local dragging = false
local dragInput = nil
local dragStart = nil
local startPosition = nil

local function safeDestroy(instance)
    if instance and instance.Parent then
        instance:Destroy()
    end
end

local oldGui = playerGui:FindFirstChild(CONFIG.Name)
if oldGui then
    oldGui:Destroy()
end

local function create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function round(object, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius or CONFIG.CornerRadius),
    }, object)
end

local function outline(object, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or currentPalette.Accent,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, object)
end

local function tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(duration or CONFIG.AnimationTime,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out),
        properties
    )
    animation:Play()
    return animation
end

local gui = create("ScreenGui", {
    Name = CONFIG.Name,
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 30,
}, playerGui)

local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(CONFIG.Width, CONFIG.Height),
    Position = UDim2.new(0.5, -CONFIG.Width / 2, 0.5, -CONFIG.Height / 2),
    BackgroundColor3 = currentPalette.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)
round(main, CONFIG.CornerRadius)
local mainStroke = outline(main, currentPalette.Accent, 2, 0.05)

local header = create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = currentPalette.Panel,
    BorderSizePixel = 0,
}, main)
round(header, CONFIG.CornerRadius)

local headerCover = create("Frame", {
    Size = UDim2.new(1, 0, 0, 15),
    Position = UDim2.new(0, 0, 1, -15),
    BackgroundColor3 = currentPalette.Panel,
    BorderSizePixel = 0,
}, header)

local title = create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -100, 0, 31),
    Position = UDim2.fromOffset(12, 4),
    BackgroundTransparency = 1,
    Text = "☠  FES  |  لوحة التحكم",
    TextColor3 = currentPalette.Accent,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local subtitle = create("TextLabel", {
    Name = "Subtitle",
    Size = UDim2.new(1, -24, 0, 16),
    Position = UDim2.fromOffset(13, 35),
    BackgroundTransparency = 1,
    Text = "ARABIC NEON INTERFACE  •  v" .. CONFIG.Version,
    TextColor3 = COLORS.Muted,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local closeButton = create("TextButton", {
    Name = "Close",
    Size = UDim2.fromOffset(34, 34),
    Position = UDim2.new(1, -42, 0, 10),
    BackgroundColor3 = Color3.fromRGB(45, 12, 15),
    Text = "✕",
    TextColor3 = COLORS.Red,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
}, header)
round(closeButton, 8)
outline(closeButton, COLORS.Red, 1, 0.15)

local minimizeButton = create("TextButton", {
    Name = "Minimize",
    Size = UDim2.fromOffset(28, 28),
    Position = UDim2.new(1, -76, 0, 13),
    BackgroundColor3 = currentPalette.Background,
    Text = "—",
    TextColor3 = currentPalette.Accent,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
}, header)
round(minimizeButton, 7)

local sidebar = create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(10, 68),
    Size = UDim2.new(0, 104, 1, -112),
    BackgroundColor3 = currentPalette.Panel,
    BorderSizePixel = 0,
}, main)
round(sidebar, 9)
outline(sidebar, currentPalette.Accent, 1, 0.65)

local sidebarLayout = create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
}, sidebar)

create("UIPadding", {
    PaddingTop = UDim.new(0, 8),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 8),
}, sidebar)

local content = create("Frame", {
    Name = "Content",
    Position = UDim2.new(0, 123, 0, 68),
    Size = UDim2.new(1, -133, 1, -112),
    BackgroundTransparency = 1,
}, main)

local categoryTitle = create("TextLabel", {
    Name = "CategoryTitle",
    Size = UDim2.new(1, 0, 0, 28),
    BackgroundTransparency = 1,
    Text = "الرئيسية",
    TextColor3 = currentPalette.Accent,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Right,
}, content)

local pageScroll = create("ScrollingFrame", {
    Name = "PageScroll",
    Position = UDim2.fromOffset(0, 34),
    Size = UDim2.new(1, 0, 1, -34),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = currentPalette.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

local pageLayout = create("UIListLayout", {
    Padding = UDim.new(0, CONFIG.ButtonGap),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, pageScroll)

local statusBar = create("Frame", {
    Name = "StatusBar",
    Position = UDim2.new(0, 10, 1, -35),
    Size = UDim2.new(1, -20, 0, 25),
    BackgroundColor3 = currentPalette.Panel,
    BorderSizePixel = 0,
}, main)
round(statusBar, 7)

local statusDot = create("Frame", {
    Size = UDim2.fromOffset(8, 8),
    Position = UDim2.new(0, 9, 0.5, -4),
    BackgroundColor3 = currentPalette.Accent,
    BorderSizePixel = 0,
}, statusBar)
round(statusDot, 4)

local statusLabel = create("TextLabel", {
    Size = UDim2.new(1, -27, 1, 0),
    Position = UDim2.fromOffset(22, 0),
    BackgroundTransparency = 1,
    Text = "الحالة: " .. statusText,
    TextColor3 = COLORS.Muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
}, statusBar)

local function setStatus(message, color)
    statusText = tostring(message)
    statusLabel.Text = "الحالة: " .. statusText
    statusLabel.TextColor3 = color or COLORS.Muted
    tween(statusDot, 0.12, {
        BackgroundColor3 = color or currentPalette.Accent,
    })
end

local function clearPage()
    for _, child in ipairs(pageScroll:GetChildren()) do
        if child ~= pageLayout then
            child:Destroy()
        end
    end
end

local function makeActionButton(text, callback, icon)
    local button = create("TextButton", {
        Name = "ActionButton",
        Size = UDim2.new(1, -4, 0, CONFIG.ButtonHeight),
        BackgroundColor3 = currentPalette.Panel,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    }, pageScroll)
    round(button, 8)
    local border = outline(button, currentPalette.Accent, 1, 0.68)

    local label = create("TextLabel", {
        Size = UDim2.new(1, -14, 1, 0),
        Position = UDim2.fromOffset(7, 0),
        BackgroundTransparency = 1,
        Text = (icon and (icon .. "  ") or "") .. text,
        TextColor3 = COLORS.White,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, button)

    button.MouseEnter:Connect(function()
        tween(button, 0.12, {BackgroundColor3 = currentPalette.PanelHover})
        tween(border, 0.12, {Transparency = 0.15})
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.12, {BackgroundColor3 = currentPalette.Panel})
        tween(border, 0.12, {Transparency = 0.68})
    end)

    button.Activated:Connect(function()
        tween(button, 0.07, {BackgroundColor3 = currentPalette.PanelHover})
        task.delay(0.08, function()
            if button.Parent then
                tween(button, 0.12, {BackgroundColor3 = currentPalette.Panel})
            end
        end)
        local ok, err = pcall(callback)
        if not ok then
            warn("FES button error:", err)
            setStatus("حدث خطأ في الزر", COLORS.Red)
        end
    end)

    return button
end

local function makeInfo(text)
    local box = create("TextLabel", {
        Size = UDim2.new(1, -4, 0, 58),
        BackgroundColor3 = currentPalette.Panel,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = COLORS.Muted,
        TextWrapped = true,
        TextSize = 12,
        Font = Enum.Font.Gotham,
    }, pageScroll)
    round(box, 8)
    outline(box, currentPalette.Accent, 1, 0.8)
    return box
end

local function makeSection(text)
    local label = create("TextLabel", {
        Size = UDim2.new(1, -4, 0, 24),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = currentPalette.Accent,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, pageScroll)
    return label
end

local function showHomePage()
    selectedCategory = "الرئيسية"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("مرحبًا بك في FES. اختر قسمًا من القائمة الجانبية.")
    makeSection("معلومات الواجهة")
    makeActionButton("عرض الإصدار", function()
        setStatus("FES إصدار " .. CONFIG.Version)
    end, "ℹ")
    makeActionButton("حالة الواجهة", function()
        setStatus("الواجهة تعمل", currentPalette.Accent)
    end, "✓")
    makeActionButton("إرشادات الاستخدام", function()
        setStatus("الأزرار التجريبية لا تغيّر اللعبة")
    end, "؟")
end

local function showHomesPage()
    selectedCategory = "البيوت"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("هذه عناصر واجهة تجريبية. اربطها بنظام الأبواب في لعبتك الخاصة.")
    makeActionButton("التفاعل مع الباب", function()
        setStatus("يلزم إعداد نظام أبواب داخل اللعبة")
    end, "🚪")
    makeActionButton("البيت المفضل", function()
        setStatus("لم يتم إعداد بيت مفضل")
    end, "🏠")
    makeActionButton("إعدادات البيت", function()
        setStatus("إعدادات البيت تجريبية")
    end, "⚙")
end

local function showFlightPage()
    selectedCategory = "الطيران"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("واجهة إعدادات فقط. لا يتم تشغيل طيران فعلي في ألعاب الآخرين.")
    makeActionButton("حالة الطيران", function()
        setStatus("الطيران غير مربوط بنظام لعبتك")
    end, "🪽")
    makeActionButton("سرعة الطيران", function()
        setStatus("أضف إعداد حركة في لعبتك الخاصة")
    end, "➤")
    makeActionButton("إعدادات التحكم", function()
        setStatus("يمكن إضافة أزرار لمس لمشروعك")
    end, "🎮")
end

local function showSpeedPage()
    selectedCategory = "السرعة"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("تغيير السرعة يحتاج نظام حركة مسموحًا به في لعبتك.")
    makeActionButton("السرعة العادية", function()
        setStatus("تم اختيار الوضع العادي")
    end, "↔")
    makeActionButton("إعداد السرعة", function()
        setStatus("إعداد تجريبي؛ غير مربوط باللعبة")
    end, "⚡")
end

local function showCharacterPage()
    selectedCategory = "الشخصية"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("خصص شكل الشخصية عبر خيارات اللعبة المتاحة.")
    makeActionButton("المظهر", function()
        setStatus("افتح إعدادات المظهر في لعبتك")
    end, "🎭")
    makeActionButton("إعدادات الشخصية", function()
        setStatus("خيارات الشخصية تجريبية")
    end, "👤")
    makeActionButton("استعادة الإعدادات", function()
        setStatus("لا توجد تغييرات محفوظة")
    end, "↺")
end

local function showVehiclesPage()
    selectedCategory = "السيارات"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("اربط هذه الأزرار بنظام المركبات المصرح به في لعبتك.")
    makeActionButton("السيارات المتاحة", function()
        setStatus("قائمة المركبات غير مهيأة")
    end, "🚗")
    makeActionButton("استدعاء مركبة", function()
        setStatus("يلزم إعداد نظام مركبات داخل لعبتك")
    end, "＋")
    makeActionButton("إعدادات المركبة", function()
        setStatus("إعدادات المركبة تجريبية")
    end, "⚙")
end

local function applyPalette(index)
    currentPaletteIndex = index
    currentPalette = PALETTES[index]
    main.BackgroundColor3 = currentPalette.Background
    header.BackgroundColor3 = currentPalette.Panel
    headerCover.BackgroundColor3 = currentPalette.Panel
    sidebar.BackgroundColor3 = currentPalette.Panel
    statusBar.BackgroundColor3 = currentPalette.Panel
    mainStroke.Color = currentPalette.Accent
    title.TextColor3 = currentPalette.Accent
    categoryTitle.TextColor3 = currentPalette.Accent
    subtitle.TextColor3 = COLORS.Muted
    statusDot.BackgroundColor3 = currentPalette.Accent
    pageScroll.ScrollBarImageColor3 = currentPalette.Accent
    setStatus("الثيم: " .. currentPalette.Name, currentPalette.Accent)
end

local function showColorsPage()
    selectedCategory = "الألوان"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("اختر لونًا لتغيير شكل واجهة FES.")
    for index, palette in ipairs(PALETTES) do
        makeActionButton(palette.Name, function()
            applyPalette(index)
            showColorsPage()
        end, "🎨")
    end
end

local function showSettingsPage()
    selectedCategory = "الإعدادات"
    categoryTitle.Text = selectedCategory
    clearPage()
    makeInfo("إعدادات عامة للواجهة.")
    makeActionButton("إعادة الصفحة الرئيسية", function()
        showHomePage()
        setStatus("تم فتح الرئيسية")
    end, "⌂")
    makeActionButton("إظهار معلومات النسخة", function()
        setStatus("FES v" .. CONFIG.Version)
    end, "ℹ")
    makeActionButton("إعادة الثيم الأخضر", function()
        applyPalette(1)
        showSettingsPage()
    end, "↺")
end

local categories = {
    {Text = "الرئيسية", Icon = "⌂", Callback = showHomePage},
    {Text = "البيوت", Icon = "⌂", Callback = showHomesPage},
    {Text = "الطيران", Icon = "↟", Callback = showFlightPage},
    {Text = "السرعة", Icon = "⚡", Callback = showSpeedPage},
    {Text = "الشخصية", Icon = "♙", Callback = showCharacterPage},
    {Text = "السيارات", Icon = "▣", Callback = showVehiclesPage},
    {Text = "الألوان", Icon = "◈", Callback = showColorsPage},
    {Text = "الإعدادات", Icon = "⚙", Callback = showSettingsPage},
}

for index, category in ipairs(categories) do
    local button = create("TextButton", {
        Name = "Category_" .. index,
        Size = UDim2.new(1, -2, 0, 36),
        BackgroundColor3 = currentPalette.Background,
        BorderSizePixel = 0,
        Text = category.Icon .. " " .. category.Text,
        TextColor3 = currentPalette.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = true,
        LayoutOrder = index,
    }, sidebar)
    round(button, 7)
    button.Activated:Connect(function()
        category.Callback()
    end)
end

local reopen = create("TextButton", {
    Name = "Reopen",
    Size = UDim2.fromOffset(135, 42),
    Position = UDim2.new(0, 14, 0.5, -21),
    BackgroundColor3 = currentPalette.Background,
    Text = "☰  فتح FES",
    TextColor3 = currentPalette.Accent,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    Visible = false,
}, gui)
round(reopen, 9)
local reopenStroke = outline(reopen, currentPalette.Accent, 2)

local function hidePanel()
    if destroyed then return end
    main.Visible = false
    reopen.Visible = true
    setStatus("تم إخفاء القائمة")
end

local function showPanel()
    if destroyed then return end
    main.Visible = true
    reopen.Visible = false
    setStatus("القائمة مفتوحة")
end

closeButton.Activated:Connect(hidePanel)
reopen.Activated:Connect(showPanel)

local minimized = false
local savedHeight = main.Size

minimizeButton.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        savedHeight = main.Size
        main.Size = UDim2.new(0, CONFIG.Width, 0, 58)
        sidebar.Visible = false
        content.Visible = false
        statusBar.Visible = false
        minimizeButton.Text = "+"
    else
        main.Size = savedHeight
        sidebar.Visible = true
        content.Visible = true
        statusBar.Visible = true
        minimizeButton.Text = "—"
    end
end)

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
        dragInput = input
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and dragInput and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        dragInput = nil
    end
end)

gui.Destroying:Connect(function()
    destroyed = true
end)

showHomePage()
setStatus("جاهز", currentPalette.Accent)

print("FES Arabic UI v" .. CONFIG.Version .. " loaded")
