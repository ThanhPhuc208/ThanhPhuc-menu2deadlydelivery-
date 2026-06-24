local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ThanhPhuc Deadly Pro - Mobile OK", "DarkTheme")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Text = "P"
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BackgroundTransparency = 0.3

local Corner = Instance.new("UICorner", ToggleButton)
Corner.CornerRadius = UDim.new(1, 0)

local MenuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    local coreGui = game.CoreGui:FindFirstChild("ThanhPhuc Deadly Pro - Mobile OK") or game.CoreGui:FindFirstChild("DarkTheme")
    if coreGui then
        coreGui.Enabled = MenuVisible
    end
end)

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

Section:NewToggle("Auto Bring & Pick Items", "Gom đồ về thang máy tốc độ cân bằng", function(state)
    _G.BringItems = state
    task.spawn(function()
        while _G.BringItems do
            pcall(function()
                local elevator = workspace:FindFirstChild("Elevator") or workspace:FindFirstChild("Lift") or workspace:FindFirstChild("MainElevator") or workspace:FindFirstChild("Vehicle")
                
                if elevator then
                    local elevatorTarget = elevator:GetPivot()
                    for _, folder in pairs(workspace:GetChildren()) do
                        if folder:IsA("Folder") or folder:IsA("Model") then
                            for _, obj in pairs(folder:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") and obj.Parent then
                                    local item = obj.Parent
                                    if item:IsA("BasePart") then
                                        item.CFrame = elevatorTarget + Vector3.new(0, 2, 0)
                                    elseif item:IsA("Model") then
                                        item:PivotTo(elevatorTarget + Vector3.new(0, 2, 0))
                                    end
                                    task.wait(0.1)
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(1.5)
        end
    end)
end)

Section:NewToggle("Kill All Monsters", "Hạ gục toàn bộ quái vật trên bản đồ", function(state)
    _G.KillMonsters = state
    task.spawn(function()
        while _G.KillMonsters do
            pcall(function()
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
                        obj.Humanoid.Health = 0
                    end
                end
                for _, folder in pairs(workspace:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, obj in pairs(folder:GetChildren()) do
                            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
                                obj.Humanoid.Health = 0
                            end
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

local function CreateESP(object, color, text)
    if not object:FindFirstChild("ESP_Highlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_Highlight"
        hl.FillColor = color
        hl.FillTransparency = 0.4
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.Parent = object
    end
    if not object:FindFirstChild("ESP_Billboard") then
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_Billboard"
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0, 100, 0, 25)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = color
        lbl.TextScaled = true
        lbl.Font = Enum.Font.SourceSansBold
        lbl.Parent = bb
        bb.Parent = object
    end
end

Section:NewToggle("Bật ESP Nhìn Xuyên Tường", "Hiển thị Quái vật và Vật phẩm", function(state)
    _G.ESP = state
    task.spawn(function()
        while _G.ESP do
            pcall(function()
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
                        CreateESP(obj, Color3.fromRGB(255, 0, 0), "MONSTER [QUÁI]")
                    end
                end
                for _, folder in pairs(workspace:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, obj in pairs(folder:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") and obj.Parent then
                                CreateESP(obj.Parent, Color3.fromRGB(0, 255, 0), obj.Parent.Name)
                            end
                        end
                    end
                end
            end)
            task.wait(2)
        end
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:FindFirstChild("ESP_Highlight") then obj.ESP_Highlight:Destroy() end
                if obj:FindFirstChild("ESP_Billboard") then obj.ESP_Billboard:Destroy() end
            end
        end)
    end)
end)

Section:NewSlider("Tốc độ chạy", "Chỉnh tốc độ nhân vật tùy chọn", 150, 16, function(s)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = s
        end
    end)
end)
