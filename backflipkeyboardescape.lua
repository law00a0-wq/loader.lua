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

-- إنشاء النافذة الرئيسية للوحة
local Window = Rayfield:CreateWindow({
   Name = "LAW | Backflip Keyboard Escape",
   LoadingTitle = "جاري تحميل السكربت...",
   LoadingSubtitle = "by LAW",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "BackflipKeyboardHub",
      FileName = "Config"
   },
   KeySystem = false,
})

-- ==================== تبويب العالم الأول ====================
local World1Tab = Window:CreateTab("العالم الأول (World 1)", 4483362458)
local FarmSection = World1Tab:CreateSection("قسم التفريم (Farming)")

-- متغير لتشغيل التفريم التلقائي للستيج 21 أو إيقافه
local autoFarmStage21 = false

-- زر تفعيل التفريم التلقائي للستيج 21 (Toggle)
World1Tab:CreateToggle({
   Name = "تفريم تلقائي - ستيج 21 (Auto Farm Stage 21)",
   CurrentValue = false,
   Flag = "AutoFarmStage21Toggle",
   Callback = function(Value)
      autoFarmStage21 = Value
      if autoFarmStage21 then
         Rayfield:Notify({
            Title = "التفريم التلقائي",
            Content = "تم تشغيل التفريم التلقائي للستيج 21 بنجاح!",
            Duration = 2,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "التفريم التلقائي",
            Content = "تم إيقاف التفريم التلقائي.",
            Duration = 2,
            Image = 4483362458,
         })
      end
   end,
})

-- حلقة تكرار مسؤولة عن الانتقال تلقائياً للإحداثيات طالما الزر شغال
task.spawn(function()
    while true do
        if autoFarmStage21 then
            pcall(function()
                TeleportTo(-6510.65185546875, 273.4842834472656, -15757.0849609375)
            end)
        end
        task.wait(1) -- ينقلك كل ثانية تلقائياً
    end
end)

-- ==================== تبويب معلومات المطور ====================
local InfoTab = Window:CreateTab("معلومات المطور (Info)", 4483362458)

InfoTab:CreateParagraph({
   Title = "معلومات المطور والقناة", 
   Content = "Developer: LAW\nTelegram Channel: https://t.me/Lrzz0"
})
