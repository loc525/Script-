-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "No Stun Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Loc",
    ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Main", 4483362458)

local noStun = false
local antiKB = false
local speedEnabled = false
local speedValue = 16

-- Loop mạnh hơn
game:GetService("RunService").RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then

            -- SPEED (ưu tiên cao nhất)
            if speedEnabled then
                hum.WalkSpeed = speedValue
            end

            -- NO STUN
            if noStun then
                hum.PlatformStand = false
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end

        end
    end
end)

-- Anti Knockback
game:GetService("RunService").Heartbeat:Connect(function()
    if antiKB then
        local char = game.Players.LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.zero
            end
        end
    end
end)

-- UI
Tab:CreateToggle({
    Name = "No Stun",
    CurrentValue = false,
    Callback = function(v)
        noStun = v
    end,
})

Tab:CreateToggle({
    Name = "Anti Knockback",
    CurrentValue = false,
    Callback = function(v)
        antiKB = v
    end,
})

Tab:CreateToggle({
    Name = "Custom Speed",
    CurrentValue = false,
    Callback = function(v)
        speedEnabled = v
    end,
})

Tab:CreateSlider({
    Name = "Speed Value",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(v)
        speedValue = v
    end,
})

Tab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})
