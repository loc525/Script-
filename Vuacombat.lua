local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LookEnabled = false
local LockedTarget = nil
local MaxAngle = 60

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 90)
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "Aim Lock"
Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
Title.TextColor3 = Color3.new(1,1,1)

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1,-10,0,40)
Button.Position = UDim2.new(0,5,0,40)
Button.Text = "OFF"
Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
Button.TextColor3 = Color3.new(1,1,1)

-- ===== FUNCTION =====
function getTargetInFront()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end

    local myRoot = character.HumanoidRootPart
    local lookVector = myRoot.CFrame.LookVector

    local bestTarget = nil
    local bestAngle = MaxAngle

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = v.Character.HumanoidRootPart
            
            local direction = (targetRoot.Position - myRoot.Position).Unit
            local angle = math.deg(math.acos(lookVector:Dot(direction)))

            if angle < bestAngle then
                bestAngle = angle
                bestTarget = v
            end
        end
    end

    return bestTarget
end

-- ===== TOGGLE =====
function toggle()
    LookEnabled = not LookEnabled
    
    if LookEnabled then
        LockedTarget = getTargetInFront()
    else
        LockedTarget = nil
    end

    Button.Text = LookEnabled and "ON" or "OFF"
    Button.BackgroundColor3 = LookEnabled and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
end

Button.MouseButton1Click:Connect(toggle)

UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.R and not gpe then
        toggle()
    end
end)

-- ===== LOOP =====
RunService.RenderStepped:Connect(function()
    if LookEnabled and LockedTarget then
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end

        -- ❗ check chết → auto OFF
        if not LockedTarget.Character 
        or not LockedTarget.Character:FindFirstChild("Humanoid") 
        or LockedTarget.Character.Humanoid.Health <= 0 then
            
            LookEnabled = false
            LockedTarget = nil

            Button.Text = "OFF"
            Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
            return
        end

        if LockedTarget.Character:FindFirstChild("HumanoidRootPart") then
            local myRoot = character.HumanoidRootPart
            local targetRoot = LockedTarget.Character.HumanoidRootPart

            local myPos = myRoot.Position
            local targetPos = targetRoot.Position

            -- chỉ xoay ngang (fix dash)
            local lookPos = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)

            myRoot.CFrame = CFrame.new(myPos, lookPos)
        end
    end
end)
