local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LocalPlayer = game.Players.LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "Deadly Delivery PRO V2",
    SubTitle = "Fixed Interaction & Anti-Death",
    Size = UDim2.fromOffset(500, 400),
    Theme = "Dark"
})

local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "home" }) }

Tabs.Main:AddToggle("GodMode", {Title = "Anti-Death (Bất tử)", Default = false}):OnChanged(function(Value)
    _G.GodMode = Value
    if Value then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        end
    else
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end
    end
end)

Tabs.Main:AddToggle("BringItems", {Title = "Auto Magnet Items (Hút đồ về tay)", Default = false}):OnChanged(function(Value)
    _G.Magnet = Value
    task.spawn(function()
        while _G.Magnet do
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("ProximityPrompt") and item.Parent then
                    local parent = item.Parent
                    if parent:IsA("BasePart") or parent:IsA("Model") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            parent:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2))
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

Tabs.Main:AddButton({
    Title = "Teleport All Items to Elevator",
    Description = "Dịch chuyển toàn bộ đồ nhặt được vào thang máy",
    Callback = function()
        local Elevator = workspace:FindFirstChild("Elevator") or workspace:FindFirstChild("Lift")
        if Elevator then
            for _, obj in pairs(workspace:GetChildren()) do
                if (obj:IsA("Model") or obj:IsA("Tool")) and obj:FindFirstChildWhichIsA("BasePart") then
                    obj:PivotTo(Elevator:GetPivot() + Vector3.new(0, 2, 0))
                end
            end
        else
            Fluent:Notify({Title = "Error", Content = "Không tìm thấy thang máy trong map!"})
        end
    end
})

Tabs.Main:AddToggle("KillMonsters", {Title = "Remove Monsters (Xóa quái)", Default = false}):OnChanged(function(Value)
    _G.DelMonster = Value
    task.spawn(function()
        while _G.DelMonster do
            for _, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v ~= LocalPlayer.Character then
                    v:Destroy()
                end
            end
            task.wait(1)
        end
    end)
end)

