local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib("ThanhPhuc Deadly Pro - Mobile OK", "DarkTheme")

local Tab = Window:NewTab("Tính Năng")
local Section = Tab:NewSection("Deadly Delivery Fix")

local LocalPlayer = game.Players.LocalPlayer

Section:NewToggle("God Mode (Bất Tử)", "Chống quái vật gây sát thương", function(state)
    _G.GodMode = state
    task.spawn(function()
        while _G.GodMode do
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                        end
                    end
                end
            end)
            task.wait(0.3)
        end
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = true
                    end
                end
            end
        end)
    end)
end)

Section:NewToggle("Auto Bring & Pick Items", "Hút đồ về chân và tự nhặt", function(state)
    _G.BringItems = state
    task.spawn(function()
        while _G.BringItems do
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local elevator = workspace:FindFirstChild("Elevator") or workspace:FindFirstChild("Lift") or workspace:FindFirstChild("MainElevator")
                
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Parent then
                        local item = obj.Parent
                        
                        if elevator then
                            if item:IsA("BasePart") then item.CFrame = elevator:GetPivot() + Vector3.new(0,2,0)
                            elseif item:IsA("Model") then item:PivotTo(elevator:GetPivot() + Vector3.new(0,2,0)) end
                        elseif hrp then
                            if item:IsA("BasePart") then item.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)
                            elseif item:IsA("Model") then item:PivotTo(hrp.CFrame * CFrame.new(0, 0, -2)) end
                        end
                        
                        task.spawn(function()
                            fireproximityprompt(obj)
                        end)
                    end
                end
            end)
            task.wait(0.8)
        end
    end)
end)

Section:NewToggle("Auto Delete Monsters", "Xóa sạch quái vật trên map", function(state)
    _G.DeleteMonsters = state
    task.spawn(function()
        while _G.DeleteMonsters do
            pcall(function()
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
                        obj:Destroy()
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

local function CreateESP(object, color)
    if not object:FindFirstChild("ESP_Highlight") then
        local hl = Instance.new("Highlight", object)
        hl.Name = "ESP_Highlight"
        hl.FillColor = color
        hl.FillTransparency = 0.5
        hl.OutlineColor = Color3.fromRGB(255,255,255)
    end
end

Section:NewToggle("Bật ESP Nhìn Xuyên Tường", "Hiển thị Quái và Vật phẩm", function(state)
    _G.ESP = state
    task.spawn(function()
        while _G.ESP do
            pcall(function()
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
                        CreateESP(obj, Color3.fromRGB(255, 0, 0))
                    end
                end
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Parent then
                        CreateESP(obj.Parent, Color3.fromRGB(0, 255, 0))
                    end
                end
            end)
            task.wait(1.5)
        end
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:FindFirstChild("ESP_Highlight") then obj.ESP_Highlight:Destroy() end
            end
        end)
    end)
end)

Section:NewSlider("Tốc độ chạy", "Chỉnh tốc độ nhân vật", 150, 16, function(s)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = s
        end
    end)
end)
