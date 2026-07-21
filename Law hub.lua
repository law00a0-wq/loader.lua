
-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- الحصول على اللاعب المحلي وحركته
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function TeleportTo(x, y, z)
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end

-- دالة لجلب الكؤوس من الـ Leaderstats
local function GetTrophies()
    if player:FindFirstChild("leaderstats") then
        for _, stat in ipairs(player.leaderstats:GetChildren()) do
            local name = string.lower(stat.Name)
            if name:find("troph") or name:find("cup") or name:find("win") or name:find("score") or name:find("point") then
                return stat.Value
            end
        end
    end
    return 0
end

-- دالة لجلب قيمة السرعة المكتسبة (من الـ Leaderstats أو الـ PlayerGui) مثل الكؤوس تماماً
local function GetGameSpeed()
    if player:FindFirstChild("leaderstats") then
        for _, stat in ipairs(player.leaderstats:GetChildren()) do
            local name = string.lower(stat.Name)
            if name:find("speed") or name:find("fast") or name:find("walk") then
                return stat.Value
            end
        end
    end
    -- إذا لم تكن موجودة في الleaderstats، نفحص الـ Character كبديل
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        return char:FindFirstChildOfClass("Humanoid").WalkSpeed
    end
    return 0
end

-- إنشاء النافذة الرئيسية للوحة
local Window = Rayfield:CreateWindow({
   Name = "LAW | Script Hub",
   LoadingTitle = "جاري تحميل السكربت...",
   LoadingSubtitle = "by LAW",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "LawHub",
      FileName = "Config"
   },
   KeySystem = false,
})

-- ==================== تبويب العالم الأول ====================
local World1Tab = Window:CreateTab("العالم الأول (World 1)", 4483362458)
local StagesSection = World1Tab:CreateSection("قائمة المراحل والتفريم (Stages)")

local Stages = {
   {-328.11, 6.45, -8.19},
   {-602.11, 12.33, -14.31},
   {-1031.62, 8.80, -19.90},
   {-1154.96, -6.27, -604.14},
   {-1156.76, -52.69, -1322.17},
   {-1156.51, -50.71, -1322.92},
   {-1142.10, 200.47, -1456.37},
   {-1140.27, 200.20, -2201.27},
   {-1159.70, 116.08, -3071.55}
}

for i, pos in ipairs(Stages) do
   World1Tab:CreateButton({
      Name = "الستيج " .. i .. " (Stage " .. i .. ")",
      Callback = function()
         TeleportTo(unpack(pos))
         Rayfield:Notify({
            Title = "تم الانتقال",
            Content = "تم نقلك إلى أحداثيات الستيج " .. i,
            Duration = 2,
            Image = 4483362458,
         })
      end,
   })
end

-- ==================== تبويب معلومات المطور ====================
local InfoTab = Window:CreateTab("معلومات المطور (Info)", 4483362458)

InfoTab:CreateParagraph({
   Title = "معلومات المطور والقناة", 
   Content = "Developer: LAW\nTelegram Channel: https://t.me/Lrzz0"
})

-- خانة الحالة (تتحدث تلقائياً للكؤوس والسرعة الخاصة بالماب)
local StatusParagraph = InfoTab:CreateParagraph({
   Title = "حالة اللاعب (Status)", 
   Content = "السرعة: " .. tostring(GetGameSpeed()) .. "\nالكؤوس (Trophies): " .. tostring(GetTrophies())
})

-- حلقة تكرار لتحديث السرعة والكؤوس تلقائياً في الخلفية
task.spawn(function()
    while true do
        pcall(function()
            local currentSpeed = GetGameSpeed()
            local currentTrophies = GetTrophies()
            
            StatusParagraph:Set({
                Title = "حالة اللاعب (Status)",
                Content = "السرعة: " .. tostring(currentSpeed) .. "\nالكؤوس (Trophies): " .. tostring(currentTrophies)
            })
        end)
        task.wait(0.5)
    end
end)
