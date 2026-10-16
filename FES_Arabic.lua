--================================================================================--
--      FRS SCRIPT | ULTIMATE PERFECT VERSION v13.0 (تشغيل مباشر بدون نسخ)   --
--================================================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

local OWNER_NAME = "Feras1406"

local admins = {
    ["Feras1406"] = true
}

local authorizedPublishers = {
    ["Feras1406"] = true
}

local bannedPlayers = {}

local function isAdminOrOwner()
    return admins[player.Name] or player.Name == OWNER_NAME
end

local function isUserAuthorized()
    return authorizedPublishers[player.Name] or player.Name == OWNER_NAME
end

if playerGui:FindFirstChild("FRS_Rectangular_Beta") then
    playerGui:FindFirstChild("FRS_Rectangular_Beta"):Destroy()
end

task.spawn(function()
    task.wait(1)
    StarterGui:SetCore("SendNotification", {
        Title = "🏠 FRS SCRIPT",
        Text = "أهلاً بك يا فراس، تم تفعيل مشغل الصوت المباشر للقرآن والأغاني!",
        Duration = 5
    })
end)

-- مكتبة الصوتيات مع تشغيل مباشر داخل السكربت
local audioPlaylists = {
    {name = "📖 سورة التوبة", id = "rbxassetid://4711690175"},
    {name = "📖 سورة قريش", id = "rbxassetid://133272041755020"},
    {name = "📖 سورة الكوثر", id = "rbxassetid://98410970412214"},
    {name = "📖 سورة الناس", id = "rbxassetid://77405600154092"},
    {name = "📖 سورة الفلق", id = "rbxassetid://86911769585232"},
    {name = "📖 سورة الغاشية", id = "rbxassetid://6268665586"},
    {name = "📖 سورة البينة", id = "rbxassetid://1944304521"},
    {name = "🎧 قرآن كريم (1)", id = "rbxassetid://4761318538"},
    {name = "🎧 قرآن كريم (2)", id = "rbxassetid://4947900689"},
    {name = "🎶 Crab Rave", id = "rbxassetid://5410086218"},
    {name = "🎶 Gangsta's Paradise", id = "rbxassetid://6070263388"},
    {name = "🎶 Tokyo Drift", id = "rbxassetid://1837015626"},
    {name = "🎶 Believer", id = "rbxassetid://1845016505"},
    {name = "🎶 Raining Tacos", id = "rbxassetid://142376088"}
}

-- محرك الصوت الداخلي (يشتغل دايركت)
local internalSound = Instance.new("Sound")
internalSound.Name = "FRS_DirectAudioPlayer"
internalSound.Volume = 3
internalSound.Looped = true
internalSound.Parent = Workspace

local function playAudioDirect(soundAssetId, soundName)
    internalSound:Stop()
    internalSound.SoundId = soundAssetId
    internalSound:Play()
    StarterGui:SetCore("SendNotification", {
        Title = "🎵 جاري التشغيل الآن",
        Text = soundName,
        Duration = 3
    })
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FRS_Rectangular_Beta"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 340)
mainFrame.Position = UDim2.new(0.5, -280, 0.4, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local activeThemeColor = Color3.fromRGB(255, 215, 0)

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = activeThemeColor
mainStroke.Transparency = 0.2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 38)
topBar.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
topBar.BackgroundTransparency = 0.1
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

-- تحريك السكربت باللمس والماوس
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = (player.Name == OWNER_NAME) and "FRS SCRIPT | المطور: Feras1406 👑" or "FRS SCRIPT | ماب البيوت 🏠"
title.TextColor3 = activeThemeColor
title.TextSize = 12
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -60, 0, 7)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 16
minimizeBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

local closeTopBtn = Instance.new("TextButton")
closeTopBtn.Size = UDim2.new(0, 24, 0, 24)
closeTopBtn.Position = UDim2.new(1, -30, 0, 7)
closeTopBtn.BackgroundColor3 = Color3.fromRGB(210, 45, 45)
closeTopBtn.Text = "✕"
closeTopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeTopBtn.TextSize = 12
closeTopBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeTopBtn

-- مربع التصغير القابل للتحريك
local miniBox = Instance.new("ImageButton")
miniBox.Size = UDim2.new(0, 60, 0, 60)
miniBox.Position = UDim2.new(0.1, 0, 0.2, 0)
miniBox.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
miniBox.BackgroundTransparency = 0.1
miniBox.Image = "rbxassetid://109062168444973"
miniBox.Visible = false
miniBox.Active = true
miniBox.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 14)
miniCorner.Parent = miniBox

local miniStroke = Instance.new("UIStroke")
miniStroke.Thickness = 2
miniStroke.Color = activeThemeColor
miniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
miniStroke.Parent = miniBox

local miniDragging, miniDragStart, miniStartPos
miniBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        miniDragging = true
        miniDragStart = input.Position
        miniStartPos = miniBox.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                miniDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and miniDragging then
        local delta = input.Position - miniDragStart
        miniBox.Position = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y)
    end
end)

minimizeBtn.Activated:Connect(function() mainFrame.Visible = false; miniBox.Visible = true end)
miniBox.Activated:Connect(function() miniBox.Visible = false; mainFrame.Visible = true end)

local tabBar = Instance.new("ScrollingFrame")
tabBar.Size = UDim2.new(0, 130, 1, -48)
tabBar.Position = UDim2.new(0, 6, 0, 44)
tabBar.BackgroundTransparency = 1
tabBar.BorderSizePixel = 0
tabBar.ScrollBarThickness = 3
tabBar.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)
tabLayout.Parent = tabBar

local allTabs = {}
local function createTabBtn(text, isVisibleForEveryone)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(25, 30, 42)
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Center
    btn.Parent = tabBar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    if not isVisibleForEveryone then
        btn.Visible = isAdminOrOwner()
    end
    
    table.insert(allTabs, btn)
    return btn
end

local tabAdminPanelBtn = createTabBtn("🛡️ قائمة الأدمن", false)
local tabNewsBtn = createTabBtn("📢 الأخبار", true)
local tabTargetBtn = createTabBtn("👁️ المراقبة", true)
local tabAudioBtn = createTabBtn("🎵 قرآن وأغاني", true)
local tabPlayerBtn = createTabBtn("⚡ اللاعب", true)
local tabFlyBtn = createTabBtn("✈️ الطيران", true)
local tabAiBtn = createTabBtn("🤖 مجتمع AI", true)
local tabRateBtn = createTabBtn("⭐ التقييمات", true)
local tabSettingsBtn = createTabBtn("⚙️ الإعدادات", true)
local tabRightsBtn = createTabBtn("👑 الحقوق", true)

tabBar.CanvasSize = UDim2.new(0, 0, 0, 11 * 30)

local adminContainer = Instance.new("ScrollingFrame")
local newsContainer = Instance.new("ScrollingFrame")
local targetContainer = Instance.new("ScrollingFrame")
local audioContainer = Instance.new("ScrollingFrame")
local playerContainer = Instance.new("ScrollingFrame")
local flyContainer = Instance.new("ScrollingFrame")
local aiContainer = Instance.new("ScrollingFrame")
local rateContainer = Instance.new("ScrollingFrame")
local settingsContainer = Instance.new("ScrollingFrame")
local rightsContainer = Instance.new("ScrollingFrame")

local allContainers = {adminContainer, newsContainer, targetContainer, audioContainer, playerContainer, flyContainer, aiContainer, rateContainer, settingsContainer, rightsContainer}

local function setupContainer(container)
    container.Size = UDim2.new(1, -145, 1, -48)
    container.Position = UDim2.new(0, 140, 0, 44)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 4
    container.Visible = false
    container.Parent = mainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = container
end

for _, c in ipairs(allContainers) do
    setupContainer(c)
end

if isAdminOrOwner() then
    adminContainer.Visible = true
    tabAdminPanelBtn.BackgroundColor3 = activeThemeColor
    tabAdminPanelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
else
    newsContainer.Visible = true
    tabNewsBtn.BackgroundColor3 = activeThemeColor
    tabNewsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local function switchTab(activeBtn, activeContainer)
    for _, btn in ipairs(allTabs) do
        btn.BackgroundColor3 = Color3.fromRGB(25, 30, 42)
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    for _, c in ipairs(allContainers) do
        c.Visible = false
    end
    activeBtn.BackgroundColor3 = activeThemeColor
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activeContainer.Visible = true
end

tabAdminPanelBtn.Activated:Connect(function() switchTab(tabAdminPanelBtn, adminContainer) end)
tabNewsBtn.Activated:Connect(function() switchTab(tabNewsBtn, newsContainer) end)
tabTargetBtn.Activated:Connect(function() switchTab(tabTargetBtn, targetContainer) end)
tabAudioBtn.Activated:Connect(function() switchTab(tabAudioBtn, audioContainer) end)
tabPlayerBtn.Activated:Connect(function() switchTab(tabPlayerBtn, playerContainer) end)
tabFlyBtn.Activated:Connect(function() switchTab(tabFlyBtn, flyContainer) end)
tabAiBtn.Activated:Connect(function() switchTab(tabAiBtn, aiContainer) end)
tabRateBtn.Activated:Connect(function() switchTab(tabRateBtn, rateContainer) end)
tabSettingsBtn.Activated:Connect(function() switchTab(tabSettingsBtn, settingsContainer) end)
tabRightsBtn.Activated:Connect(function() switchTab(tabRightsBtn, rightsContainer) end)

local function createActionButton(text, color, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    return btn
end

-- 🛡️ قائمة الأدمن وإدارة اللاعبين
adminContainer.CanvasSize = UDim2.new(0, 0, 0, 450)
local adminTitle = Instance.new("TextLabel")
adminTitle.Size = UDim2.new(1, 0, 0, 30)
adminTitle.BackgroundTransparency = 1
adminTitle.Text = "🛡️ لوحة تحكم الأدمن وإدارة اللاعبين"
adminTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
adminTitle.Font = Enum.Font.SourceSansBold
adminTitle.TextSize = 13
adminTitle.TextXAlignment = Enum.TextXAlignment.Left
adminTitle.Parent = adminContainer

local playersListLabel = Instance.new("TextLabel")
playersListLabel.Size = UDim2.new(1, 0, 0, 24)
playersListLabel.BackgroundTransparency = 1
playersListLabel.Text = "👥 اللاعبون المتصلون حالياً (اضغط لإعطاء باند):"
playersListLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
playersListLabel.Font = Enum.Font.SourceSansBold
playersListLabel.TextSize = 11
playersListLabel.TextXAlignment = Enum.TextXAlignment.Left
playersListLabel.Parent = adminContainer

local connectedPlayersScroll = Instance.new("ScrollingFrame")
connectedPlayersScroll.Size = UDim2.new(1, 0, 0, 160)
connectedPlayersScroll.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
connectedPlayersScroll.BackgroundTransparency = 0.3
connectedPlayersScroll.BorderSizePixel = 0
connectedPlayersScroll.ScrollBarThickness = 4
connectedPlayersScroll.Parent = adminContainer

local cpLayout = Instance.new("UIListLayout")
cpLayout.SortOrder = Enum.SortOrder.LayoutOrder
cpLayout.Padding = UDim.new(0, 4)
cpLayout.Parent = connectedPlayersScroll

local function updateConnectedPlayersList()
    for _, child in ipairs(connectedPlayersScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    local plist = Players:GetPlayers()
    connectedPlayersScroll.CanvasSize = UDim2.new(0, 0, 0, #plist * 44)
    
    for _, p in ipairs(plist) do
        local pCard = Instance.new("TextButton")
        pCard.Size = UDim2.new(1, 0, 0, 40)
        pCard.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
        pCard.Text = ""
        pCard.Parent = connectedPlayersScroll
        
        local pcCorner = Instance.new("UICorner")
        pcCorner.CornerRadius = UDim.new(0, 6)
        pcCorner.Parent = pCard
        
        local avatarImg = Instance.new("ImageLabel")
        avatarImg.Size = UDim2.new(0, 32, 0, 32)
        avatarImg.Position = UDim2.new(0, 4, 0, 4)
        avatarImg.BackgroundColor3 = Color3.fromRGB(35, 45, 60)
        avatarImg.Image = "rbxassetid://0"
        avatarImg.Parent = pCard
        
        local aiC = Instance.new("UICorner")
        aiC.CornerRadius = UDim.new(0, 6)
        aiC.Parent = avatarImg
        
        task.spawn(function()
            pcall(function()
                local content = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                avatarImg.Image = content
            end)
        end)
        
        local infoLbl = Instance.new("TextLabel")
        infoLbl.Size = UDim2.new(1, -45, 1, 0)
        infoLbl.Position = UDim2.new(0, 42, 0, 0)
        infoLbl.BackgroundTransparency = 1
        infoLbl.Text = "👤 " .. p.Name .. " (" .. p.DisplayName .. ")"
        infoLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        infoLbl.Font = Enum.Font.SourceSansBold
        infoLbl.TextSize = 11
        infoLbl.TextXAlignment = Enum.TextXAlignment.Left
        infoLbl.Parent = pCard
        
        pCard.Activated:Connect(function()
            bannedPlayers[p.Name] = os.time() + 99999999
            StarterGui:SetCore("SendNotification", {Title = "🚫 إدارة الباند", Text = "تم إعطاء باند دائم للاعب: " .. p.Name, Duration = 4})
        end)
    end
end

updateConnectedPlayersList()
Players.PlayerAdded:Connect(updateConnectedPlayersList)
Players.PlayerRemoving:Connect(updateConnectedPlayersList)

local banTargetBox = Instance.new("TextBox")
banTargetBox.Size = UDim2.new(1, 0, 0, 34)
banTargetBox.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
banTargetBox.PlaceholderText = "اكتب اسم اللاعب لإعطائه باند..."
banTargetBox.Text = ""
banTargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
banTargetBox.Parent = adminContainer

createActionButton("باند دائم للاعب المحدد", Color3.fromRGB(200, 40, 40), adminContainer).Activated:Connect(function()
    local targetName = banTargetBox.Text:gsub("%s+", "")
    if targetName ~= "" then
        bannedPlayers[targetName] = os.time() + 99999999
        StarterGui:SetCore("SendNotification", {Title = "🚫 باند", Text = "تم إعطاء باند دائم لـ: " .. targetName, Duration = 4})
    end
end)

-- 📢 الأخبار
newsContainer.CanvasSize = UDim2.new(0, 0, 0, 320)
local serverNewsList = {
    {author = "Feras1406", text = "أهلاً بك يا فراس! تم تفعيل التشغيل المباشر للأصوات.", time = "الآن"}
}

local newsListScroll = Instance.new("ScrollingFrame")
newsListScroll.Size = UDim2.new(1, 0, 0, 140)
newsListScroll.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
newsListScroll.BackgroundTransparency = 0.3
newsListScroll.BorderSizePixel = 0
newsListScroll.ScrollBarThickness = 4
newsListScroll.Parent = newsContainer

local newsLayout = Instance.new("UIListLayout")
newsLayout.SortOrder = Enum.SortOrder.LayoutOrder
newsLayout.Padding = UDim.new(0, 6)
newsLayout.Parent = newsListScroll

local function renderServerNews()
    for _, child in ipairs(newsListScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    newsListScroll.CanvasSize = UDim2.new(0, 0, 0, #serverNewsList * 60)
    for _, news in ipairs(serverNewsList) do
        local newsCard = Instance.new("Frame")
        newsCard.Size = UDim2.new(1, 0, 0, 54)
        newsCard.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
        newsCard.BackgroundTransparency = 0.2
        newsCard.Parent = newsListScroll
        
        local ncCorner = Instance.new("UICorner")
        ncCorner.CornerRadius = UDim.new(0, 6)
        ncCorner.Parent = newsCard
        
        local authorAvatar = Instance.new("ImageLabel")
        authorAvatar.Size = UDim2.new(0, 42, 0, 42)
        authorAvatar.Position = UDim2.new(0, 6, 0, 6)
        authorAvatar.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
        authorAvatar.Image = "rbxassetid://0"
        authorAvatar.Parent = newsCard
        
        local aaCorner = Instance.new("UICorner")
        aaCorner.CornerRadius = UDim.new(0, 6)
        aaCorner.Parent = authorAvatar
        
        task.spawn(function()
            pcall(function()
                local targetPlayer = Players:FindFirstChild(news.author)
                local userId = targetPlayer and targetPlayer.UserId or Players:GetUserIdFromNameAsync(news.author)
                if userId then
                    local content = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                    authorAvatar.Image = content
                end
            end)
        end)
        
        local newsLabel = Instance.new("TextLabel")
        newsLabel.Size = UDim2.new(1, -60, 1, 0)
        newsLabel.Position = UDim2.new(0, 54, 0, 0)
        newsLabel.BackgroundTransparency = 1
        newsLabel.Text = "📢 [" .. news.author .. "]: " .. news.text
        newsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        newsLabel.Font = Enum.Font.SourceSansBold
        newsLabel.TextSize = 11
        newsLabel.TextXAlignment = Enum.TextXAlignment.Left
        newsLabel.TextWrapped = true
        newsLabel.Parent = newsCard
    end
end

if isUserAuthorized() then
    local publishFrame = Instance.new("Frame")
    publishFrame.Size = UDim2.new(1, 0, 0, 36)
    publishFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    publishFrame.BackgroundTransparency = 0.2
    publishFrame.Parent = newsContainer
    
    local newsInputBox = Instance.new("TextBox")
    newsInputBox.Size = UDim2.new(0.7, -10, 0.8, 0)
    newsInputBox.Position = UDim2.new(0.02, 0, 0.1, 0)
    newsInputBox.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
    newsInputBox.PlaceholderText = "اكتب خبر السيرفر هنا..."
    newsInputBox.Text = ""
    newsInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    newsInputBox.Font = Enum.Font.SourceSansBold
    newsInputBox.TextSize = 12
    newsInputBox.Parent = publishFrame
    
    local postNewsBtn = Instance.new("TextButton")
    postNewsBtn.Size = UDim2.new(0.26, 0, 0.8, 0)
    postNewsBtn.Position = UDim2.new(0.73, 0, 0.1, 0)
    postNewsBtn.BackgroundColor3 = Color3.fromRGB(210, 160, 20)
    postNewsBtn.Text = "نشر الخبر"
    postNewsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    postNewsBtn.Font = Enum.Font.SourceSansBold
    postNewsBtn.Parent = publishFrame
    
    postNewsBtn.Activated:Connect(function()
        local txt = newsInputBox.Text
        if txt ~= "" and txt:len() > 2 then
            table.insert(serverNewsList, 1, {author = player.Name, text = txt, time = "الآن"})
            newsInputBox.Text = ""
            renderServerNews()
            StarterGui:SetCore("SendNotification", {Title = "📢 أخبار السيرفر", Text = "تم نشر الخبر مع صورتك بنجاح!", Duration = 3})
        end
    end)
end
renderServerNews()

-- 👁️ المراقبة
targetContainer.CanvasSize = UDim2.new(0, 0, 0, 260)
local targetPanel = Instance.new("Frame")
targetPanel.Size = UDim2.new(1, 0, 0, 130)
targetPanel.BackgroundColor3 = Color3.fromRGB(15, 22, 25)
targetPanel.BackgroundTransparency = 0.3
targetPanel.Parent = targetContainer

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 8)
tpCorner.Parent = targetPanel

local targetImgBox = Instance.new("ImageLabel")
targetImgBox.Size = UDim2.new(0, 110, 0, 110)
targetImgBox.Position = UDim2.new(0, 10, 0, 10)
targetImgBox.BackgroundColor3 = Color3.fromRGB(25, 35, 30)
targetImgBox.Image = "rbxassetid://0"
targetImgBox.Parent = targetPanel

local imgCorner = Instance.new("UICorner")
imgCorner.CornerRadius = UDim.new(0, 6)
imgCorner.Parent = targetImgBox

local targetBox = Instance.new("TextBox")
targetBox.Size = UDim2.new(1, -178, 0, 36)
targetBox.Position = UDim2.new(0, 172, 0, 10)
targetBox.BackgroundColor3 = Color3.fromRGB(30, 65, 50)
targetBox.PlaceholderText = "@target (اسم اللاعب)..."
targetBox.Text = ""
targetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
targetBox.Font = Enum.Font.SourceSansBold
targetBox.TextSize = 13
targetBox.Parent = targetPanel

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = targetBox

local userIdLabel = Instance.new("TextLabel")
userIdLabel.Size = UDim2.new(1, -135, 0, 22)
userIdLabel.Position = UDim2.new(0, 130, 0, 52)
userIdLabel.BackgroundTransparency = 1
userIdLabel.Text = "UserID: "
userIdLabel.TextColor3 = Color3.fromRGB(150, 230, 180)
userIdLabel.Font = Enum.Font.SourceSansBold
userIdLabel.TextSize = 13
userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
userIdLabel.Parent = targetPanel

local displayLabel = Instance.new("TextLabel")
displayLabel.Size = UDim2.new(1, -135, 0, 22)
displayLabel.Position = UDim2.new(0, 130, 0, 74)
displayLabel.BackgroundTransparency = 1
displayLabel.Text = "Display: "
displayLabel.TextColor3 = Color3.fromRGB(150, 230, 180)
displayLabel.Font = Enum.Font.SourceSansBold
displayLabel.TextSize = 13
displayLabel.TextXAlignment = Enum.TextXAlignment.Left
displayLabel.Parent = targetPanel

local function getTargetPlayer()
    local name = targetBox.Text:lower():gsub("@", ""):gsub("^%s+", ""):gsub("%s+$", "")
    if name == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            if p.Name:lower():find(name) or p.DisplayName:lower():find(name) then
                return p
            end
        end
    end
    return nil
end

targetBox:GetPropertyChangedSignal("Text"):Connect(function()
    local target = getTargetPlayer()
    if target then
        userIdLabel.Text = "UserID: " .. target.UserId
        displayLabel.Text = "Display: " .. target.DisplayName
        pcall(function()
            local content = Players:GetUserThumbnailAsync(target.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            targetImgBox.Image = content
        end)
    else
        userIdLabel.Text = "UserID: "
        displayLabel.Text = "Display: "
        targetImgBox.Image = "rbxassetid://0"
    end
end)

local tpToPlayerBtn = createActionButton("📍 الانتقال المباشر للاعب (Teleport)", Color3.fromRGB(40, 100, 200), targetContainer)
tpToPlayerBtn.Activated:Connect(function()
    local target = getTargetPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = player.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

local spectateConn
local spectatePlayerBtn = createActionButton("👁️ مراقبة ومشاهدة اللاعب (Spectate)", Color3.fromRGB(140, 40, 140), targetContainer)
spectatePlayerBtn.Activated:Connect(function()
    local target = getTargetPlayer()
    if target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
        if spectateConn then
            spectateConn:Disconnect()
            spectateConn = nil
            camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            spectatePlayerBtn.Text = "👁️ مراقبة ومشاهدة اللاعب (Spectate)"
            spectatePlayerBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 140)
            StarterGui:SetCore("SendNotification", {Title = "👁️ المراقبة", Text = "تم إيقاف المراقبة وإعادة الكاميرا لك.", Duration = 3})
        else
            camera.CameraSubject = target.Character:FindFirstChildOfClass("Humanoid")
            spectatePlayerBtn.Text = "❌ إيقاف المراقبة"
            spectatePlayerBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            StarterGui:SetCore("SendNotification", {Title = "👁️ المراقبة", Text = "جاري مراقبة اللاعب: " .. target.Name, Duration = 3})
            
            spectateConn = RunService.RenderStepped:Connect(function()
                if not target.Character or not target.Character:FindFirstChildOfClass("Humanoid") then
                    camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    spectatePlayerBtn.Text = "👁️ مراقبة ومشاهدة اللاعب (Spectate)"
                    spectatePlayerBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 140)
                    if spectateConn then spectateConn:Disconnect(); spectateConn = nil end
                end
            end)
        end
    end
end)

-- 🎵 قرآن وأغاني (تشغيل مباشر داخل السكربت)
audioContainer.CanvasSize = UDim2.new(0, 0, 0, (#audioPlaylists * 42) + 60)

local stopAudioBtn = createActionButton("⏹️ إيقاف تشغيل الصوت الحالي", Color3.fromRGB(180, 40, 40), audioContainer)
stopAudioBtn.Activated:Connect(function()
    internalSound:Stop()
    StarterGui:SetCore("SendNotification", {Title = "🎵 مشغل الصوت", Text = "تم إيقاف الصوت بنجاح.", Duration = 2})
end)

for _, audio in ipairs(audioPlaylists) do
    local aBtn = createActionButton("▶️ تشغيل: " .. audio.name, Color3.fromRGB(30, 35, 50), audioContainer)
    aBtn.Activated:Connect(function()
        playAudioDirect(audio.id, audio.name)
    end)
end

-- ⚡ اللاعب
playerContainer.CanvasSize = UDim2.new(0, 0, 0, 160)
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, 0, 0, 36)
speedFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
speedFrame.Parent = playerContainer

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.42, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 8, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ السرعة (1-1000):"
speedLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = speedFrame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.3, 0, 0.8, 0)
speedBox.Position = UDim2.new(0.44, 0, 0.1, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
speedBox.PlaceholderText = "16"
speedBox.Text = ""
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Parent = speedFrame

local applySpeedBtn = Instance.new("TextButton")
applySpeedBtn.Size = UDim2.new(0.22, 0, 0.8, 0)
applySpeedBtn.Position = UDim2.new(0.76, 0, 0.1, 0)
applySpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
applySpeedBtn.Text = "تطبيق"
applySpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applySpeedBtn.Parent = speedFrame

applySpeedBtn.Activated:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        val = math.clamp(val, 1, 1000)
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
end)

local jumpFrame = Instance.new("Frame")
jumpFrame.Size = UDim2.new(1, 0, 0, 36)
jumpFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
jumpFrame.Parent = playerContainer

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0.42, 0, 1, 0)
jumpLabel.Position = UDim2.new(0, 8, 0, 0)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "🦘 القفز (1-1000):"
jumpLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
jumpLabel.Font = Enum.Font.SourceSansBold
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpLabel.Parent = jumpFrame

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0.3, 0, 0.8, 0)
jumpBox.Position = UDim2.new(0.44, 0, 0.1, 0)
jumpBox.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
jumpBox.PlaceholderText = "50"
jumpBox.Text = ""
jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBox.Parent = jumpFrame

local applyJumpBtn = Instance.new("TextButton")
applyJumpBtn.Size = UDim2.new(0.22, 0, 0.8, 0)
applyJumpBtn.Position = UDim2.new(0.76, 0, 0.1, 0)
applyJumpBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 40)
applyJumpBtn.Text = "تطبيق"
applyJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyJumpBtn.Parent = jumpFrame

applyJumpBtn.Activated:Connect(function()
    local val = tonumber(jumpBox.Text)
    if val then
        val = math.clamp(val, 1, 1000)
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = val
        end
    end
end)

-- ✈️ الطيران
flyContainer.CanvasSize = UDim2.new(0, 0, 0, 120)
local openFlyWindowBtn = createActionButton("✈️ طيران اللاعب (Pro Fly)", Color3.fromRGB(40, 140, 80), flyContainer)
local openCarFlyBtn = createActionButton("🏎️ طيران السيارة (Car Fly)", Color3.fromRGB(200, 100, 40), flyContainer)

local flyFrame = Instance.new("Frame")
flyFrame.Size = UDim2.new(0, 250, 0, 180)
flyFrame.Position = UDim2.new(0.5, 230, 0.35, -90)
flyFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
flyFrame.Visible = false
flyFrame.Parent = screenGui

local ffCorner = Instance.new("UICorner")
ffCorner.CornerRadius = UDim.new(0, 10)
ffCorner.Parent = flyFrame

local flyTopBar = Instance.new("Frame")
flyTopBar.Size = UDim2.new(1, 0, 0, 32)
flyTopBar.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
flyTopBar.Parent = flyFrame

local flyTitleLabel = Instance.new("TextLabel")
flyTitleLabel.Size = UDim2.new(1, -40, 1, 0)
flyTitleLabel.Position = UDim2.new(0, 10, 0, 0)
flyTitleLabel.BackgroundTransparency = 1
flyTitleLabel.Text = "✈️ لوحة طيران اللاعب"
flyTitleLabel.TextColor3 = Color3.fromRGB(150, 255, 180)
flyTitleLabel.Font = Enum.Font.SourceSansBold
flyTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
flyTitleLabel.Parent = flyTopBar

local closeFlyBtn = Instance.new("TextButton")
closeFlyBtn.Size = UDim2.new(0, 26, 0, 26)
closeFlyBtn.Position = UDim2.new(1, -30, 0, 3)
closeFlyBtn.BackgroundColor3 = Color3.fromRGB(210, 45, 45)
closeFlyBtn.Text = "✕"
closeFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeFlyBtn.Parent = flyTopBar

openFlyWindowBtn.Activated:Connect(function() flyFrame.Visible = not flyFrame.Visible end)
closeFlyBtn.Activated:Connect(function() flyFrame.Visible = false end)

local flyOnOffBtn = Instance.new("TextButton")
flyOnOffBtn.Size = UDim2.new(0.9, 0, 0, 36)
flyOnOffBtn.Position = UDim2.new(0.05, 0, 0, 42)
flyOnOffBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
flyOnOffBtn.Text = "تشغيل الطيران (OFF)"
flyOnOffBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
flyOnOffBtn.Font = Enum.Font.SourceSansBold
flyOnOffBtn.Parent = flyFrame

local isFlying = false
local flyConn, bVel
local flySpeed = 5

flyOnOffBtn.Activated:Connect(function()
    isFlying = not isFlying
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    
    if not isFlying then
        if flyConn then flyConn:Disconnect() end
        if bVel then bVel:Destroy() end
        if hum then hum.PlatformStand = false end
        flyOnOffBtn.Text = "تشغيل الطيران (OFF)"
    else
        if hum and root then
            hum.PlatformStand = true
            bVel = Instance.new("BodyVelocity")
            bVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bVel.Velocity = Vector3.new(0, 0.1, 0)
            bVel.Parent = root
            
            flyConn = RunService.RenderStepped:Connect(function()
                if isFlying and root and camera then
                    bVel.Velocity = camera.CFrame.LookVector * (flySpeed * 35)
                end
            end)
            flyOnOffBtn.Text = "إيقاف الطيران (ON)"
        end
    end
end)

local isCarFlying = false
local carFlyConn, carVel
openCarFlyBtn.Activated:Connect(function()
    isCarFlying = not isCarFlying
    local char = player.Character
    local seat = char and char.Sit and char.SeatPart
    if not seat or not seat:IsA("VehicleSeat") then
        StarterGui:SetCore("SendNotification", {Title = "🏎️ طيران السيارة", Text = "يرجى الجلوس في مقعد السائق بالسيارة أولاً!", Duration = 4})
        isCarFlying = false
        return
    end
    
    local vehicle = seat.Parent
    local primaryPart = vehicle.PrimaryPart or seat
    
    if not isCarFlying then
        if carFlyConn then carFlyConn:Disconnect() end
        if carVel then carVel:Destroy() end
        openCarFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 40)
        openCarFlyBtn.Text = "🏎️ طيران السيارة (Car Fly)"
    else
        carVel = Instance.new("BodyVelocity")
        carVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        carVel.Velocity = Vector3.new(0, 0.1, 0)
        carVel.Parent = primaryPart
        
        carFlyConn = RunService.RenderStepped:Connect(function()
            if isCarFlying and primaryPart and camera then
                carVel.Velocity = camera.CFrame.LookVector * 70
            end
        end)
        openCarFlyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
        openCarFlyBtn.Text = "🏎️ إيقاف طيران السيارة (ON)"
    end
end)

-- 🤖 مجتمع AI
aiContainer.CanvasSize = UDim2.new(0, 0, 0, 350)
local ideaInputFrame = Instance.new("Frame")
ideaInputFrame.Size = UDim2.new(1, 0, 0, 36)
ideaInputFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
ideaInputFrame.Parent = aiContainer

local ideaBox = Instance.new("TextBox")
ideaBox.Size = UDim2.new(0.7, -10, 0.8, 0)
ideaBox.Position = UDim2.new(0.02, 0, 0.1, 0)
ideaBox.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
ideaBox.PlaceholderText = "اكتب فكرتك للسكربت هنا..."
ideaBox.Text = ""
ideaBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ideaBox.Parent = ideaInputFrame

local sendIdeaBtn = Instance.new("TextButton")
sendIdeaBtn.Size = UDim2.new(0.26, 0, 0.8, 0)
sendIdeaBtn.Position = UDim2.new(0.73, 0, 0.1, 0)
sendIdeaBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
sendIdeaBtn.Text = "إرسال الفكرة"
sendIdeaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendIdeaBtn.Parent = ideaInputFrame

sendIdeaBtn.Activated:Connect(function()
    local text = ideaBox.Text
    if text ~= "" and text:len() >= 3 then
        ideaBox.Text = ""
        StarterGui:SetCore("SendNotification", {Title = "🤖 مجتمع الأفكار", Text = "تم إرسال فكرتك بنجاح!", Duration = 3})
    end
end)

-- ⭐ التقييمات وعدد المستخدمين الحقيقي
rateContainer.CanvasSize = UDim2.new(0, 0, 0, 200)
local rateCard = Instance.new("Frame")
rateCard.Size = UDim2.new(1, 0, 0, 80)
rateCard.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
rateCard.Parent = rateContainer

local rateTitleLabel = Instance.new("TextLabel")
rateTitleLabel.Size = UDim2.new(1, -16, 1, 0)
rateTitleLabel.Position = UDim2.new(0, 8, 0, 0)
rateTitleLabel.BackgroundTransparency = 1
rateTitleLabel.Font = Enum.Font.SourceSansBold
rateTitleLabel.TextSize = 12
rateTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
rateTitleLabel.Parent = rateCard

local function updateRealUsersCount()
    local realCount = #Players:GetPlayers()
    rateTitleLabel.Text = "📊 التقييم العام للتحديث (v13.0): ⭐ 5.0 / 5.0\n• عدد المستخدمين الحقيقيين الآن: " .. realCount .. " لاعب\n• المطور: Feras1406"
    rateTitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
end

updateRealUsersCount()
Players.PlayerAdded:Connect(updateRealUsersCount)
Players.PlayerRemoving:Connect(updateRealUsersCount)

-- ⚙️ الإعدادات (الأشكال، الشفافية، والألوان)
settingsContainer.CanvasSize = UDim2.new(0, 0, 0, 320)

local shapeTitle = Instance.new("TextLabel")
shapeTitle.Size = UDim2.new(1, 0, 0, 28)
shapeTitle.BackgroundTransparency = 1
shapeTitle.Text = "🎨 تخصيص شكل القائمة:"
shapeTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
shapeTitle.Font = Enum.Font.SourceSansBold
shapeTitle.TextSize = 13
shapeTitle.TextXAlignment = Enum.TextXAlignment.Left
shapeTitle.Parent = settingsContainer

local shapeFrame = Instance.new("Frame")
shapeFrame.Size = UDim2.new(1, 0, 0, 36)
shapeFrame.BackgroundTransparency = 1
shapeFrame.Parent = settingsContainer

local function createShapeBtn(text, xPos, callback)
    local sBtn = Instance.new("TextButton")
    sBtn.Size = UDim2.new(0.32, -4, 1, 0)
    sBtn.Position = UDim2.new(xPos, 0, 0, 0)
    sBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
    sBtn.Text = text
    sBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sBtn.Font = Enum.Font.SourceSansBold
    sBtn.TextSize = 11
    sBtn.Parent = shapeFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = sBtn
    
    sBtn.Activated:Connect(callback)
end

createShapeBtn("مستطيل ▭", 0, function()
    mainCorner.CornerRadius = UDim.new(0, 10)
    StarterGui:SetCore("SendNotification", {Title = "⚙️ الشكل", Text = "تم التغيير إلى مستطيل.", Duration = 2})
end)

createShapeBtn("دائرة ⚪", 0.34, function()
    mainCorner.CornerRadius = UDim.new(0, 40)
    StarterGui:SetCore("SendNotification", {Title = "⚙️ الشكل", Text = "تم التغيير إلى دائرة.", Duration = 2})
end)

createShapeBtn("مربع 🔲", 0.68, function()
    mainCorner.CornerRadius = UDim.new(0, 0)
    StarterGui:SetCore("SendNotification", {Title = "⚙️ الشكل", Text = "تم التغيير إلى مربع.", Duration = 2})
end)

local transparencyTitle = Instance.new("TextLabel")
transparencyTitle.Size = UDim2.new(1, 0, 0, 28)
transparencyTitle.BackgroundTransparency = 1
transparencyTitle.Text = "🌫️ مستوى الشفافية:"
transparencyTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
transparencyTitle.Font = Enum.Font.SourceSansBold
transparencyTitle.TextSize = 13
transparencyTitle.TextXAlignment = Enum.TextXAlignment.Left
transparencyTitle.Parent = settingsContainer

local transFrame = Instance.new("Frame")
transFrame.Size = UDim2.new(1, 0, 0, 36)
transFrame.BackgroundTransparency = 1
transFrame.Parent = settingsContainer

local function createTransBtn(text, xPos, alpha)
    local tBtn = Instance.new("TextButton")
    tBtn.Size = UDim2.new(0.32, -4, 1, 0)
    tBtn.Position = UDim2.new(xPos, 0, 0, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 70)
    tBtn.Text = text
    tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tBtn.Font = Enum.Font.SourceSansBold
    tBtn.TextSize = 11
    tBtn.Parent = transFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = tBtn
    
    tBtn.Activated:Connect(function()
        mainFrame.BackgroundTransparency = alpha
        StarterGui:SetCore("SendNotification", {Title = "⚙️ الشفافية", Text = "تم تعديل مستوى الشفافية.", Duration = 2})
    end)
end

createTransBtn("شفاف تماماً", 0, 0.6)
createTransBtn("متوسط", 0.34, 0.2)
createTransBtn("غير شفاف", 0.68, 0.0)

local colorTitle = Instance.new("TextLabel")
colorTitle.Size = UDim2.new(1, 0, 0, 28)
colorTitle.BackgroundTransparency = 1
colorTitle.Text = "🎨 اختر لون الثيم والمظهر:"
colorTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
colorTitle.Font = Enum.Font.SourceSansBold
colorTitle.TextSize = 13
colorTitle.TextXAlignment = Enum.TextXAlignment.Left
colorTitle.Parent = settingsContainer

local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, 0, 0, 36)
colorFrame.BackgroundTransparency = 1
colorFrame.Parent = settingsContainer

local function applyThemeColor(newColor, colorName)
    activeThemeColor = newColor
    mainStroke.Color = newColor
    miniStroke.Color = newColor
    title.TextColor3 = newColor
    StarterGui:SetCore("SendNotification", {Title = "🎨 الألوان", Text = "تم تغيير لون الثيم إلى: " .. colorName, Duration = 2})
end

local function createColorBtn(text, xPos, col, name)
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0.18, -4, 1, 0)
    cBtn.Position = UDim2.new(xPos, 0, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = text
    cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Font = Enum.Font.SourceSansBold
    cBtn.TextSize = 10
    cBtn.Parent = colorFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = cBtn
    
    cBtn.Activated:Connect(function()
        applyThemeColor(col, name)
    end)
end

createColorBtn("ذهبي", 0, Color3.fromRGB(255, 215, 0), "ذهبي ✨")
createColorBtn("أزرق", 0.2, Color3.fromRGB(0, 150, 255), "أزرق 🌐")
createColorBtn("أحمر", 0.4, Color3.fromRGB(220, 50, 50), "أحمر 🔥")
createColorBtn("أخضر", 0.6, Color3.fromRGB(50, 200, 100), "أخضر 💚")
createColorBtn("بنفسجي", 0.8, Color3.fromRGB(150, 50, 220), "بنفسجي 🔮")

-- 👑 الحقوق
rightsContainer.CanvasSize = UDim2.new(0, 0, 0, 150)
local rightsCard = Instance.new("Frame")
rightsCard.Size = UDim2.new(1, 0, 0, 100)
rightsCard.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
rightsCard.Parent = rightsContainer

local rightsInfoLabel = Instance.new("TextLabel")
rightsInfoLabel.Size = UDim2.new(1, -16, 1, 0)
rightsInfoLabel.Position = UDim2.new(0, 8, 0, 0)
rightsInfoLabel.BackgroundTransparency = 1
rightsInfoLabel.Text = "✨ FRS SCRIPT | ULTIMATE\n👑 المطور الأساسي: Feras1406\n🏠 سكربت ماب البيوت الرسمي\n📌 جميع الحقوق محفوظة © 2026"
rightsInfoLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
rightsInfoLabel.Font = Enum.Font.SourceSansBold
rightsInfoLabel.TextSize = 12
rightsInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
rightsInfoLabel.Parent = rightsCard

closeTopBtn.Activated:Connect(function()
    if flyConn then flyConn:Disconnect() end
    if bVel then bVel:Destroy() end
    if carFlyConn then carFlyConn:Disconnect() end
    if carVel then carVel:Destroy() end
    if spectateConn then spectateConn:Disconnect() end
    internalSound:Stop()
    internalSound:Destroy()
    screenGui:Destroy()
end)

print("✨ FRS SCRIPT | Perfect Version v13.0 Loaded Successfully!")
