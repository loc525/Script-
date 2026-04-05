local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LookEnabled = false
local LockedTarget = nil
local MaxAngle = 60
local NoStun = true

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 170, 0, 120)
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "Aim + NoStun"
Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
Title.TextColor3 = Color3.new(1,1,1)

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1,-10,0,35)
Button.Position = UDim2.new(0,5,0,35)
Button.Text = "Aim: OFF"
Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
Button.TextColor3 = Color3.new(1,1,1)

local StunBtn = Instance.new("TextButton", Frame)
StunBtn.Size = UDim2.new(1,-10,0,35)
StunBtn.Position = UDim2.new(0,5,0,75)
StunBtn.Text = "NoStun: ON"
StunBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
StunBtn.TextColor3 = Color3.new(1,1,1)

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

-- ===== TOGGLE AIM =====
function toggleAim()
    LookEnabled = not LookEnabled
    
    if LookEnabled then
        LockedTarget = getTargetInFront()
    else
        LockedTarget = nil
    end

    Button.Text = LookEnabled and "Aim: ON" or "Aim: OFF"
    Button.BackgroundColor3 = LookEnabled and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
end

-- ===== TOGGLE STUN =====
function toggleStun()
    NoStun = not NoStun
    
    if NoStun then
        StunBtn.Text = "NoStun: ON"
        StunBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
    else
        StunBtn.Text = "NoStun: OFF"
        StunBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    end
end

Button.MouseButton1Click:Connect(toggleAim)
StunBtn.MouseButton1Click:Connect(toggleStun)

-- ===== PHÍM =====
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.R then
        toggleAim()
    end

    if input.KeyCode == Enum.KeyCode.T then
        toggleStun()
    end
end)

-- ===== AIM LOOP =====
RunService.RenderStepped:Connect(function()
    if not LookEnabled or not LockedTarget then return end

    local character = LocalPlayer.Character
    if not character then return end

    local myRoot = character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    if not LockedTarget.Character 
    or not LockedTarget.Character:FindFirstChild("Humanoid") 
    or LockedTarget.Character.Humanoid.Health <= 0 then
        
        LookEnabled = false
        LockedTarget = nil

        Button.Text = "Aim: OFF"
        Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
        return
    end

    local targetRoot = LockedTarget.Character:FindFirstChild("HumanoidRootPart")
    if targetRoot then
        local myPos = myRoot.Position
        local targetPos = targetRoot.Position

        local lookPos = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
        myRoot.CFrame = CFrame.new(myPos, lookPos)
    end
end)

-- ===== NO STUN LOOP =====
RunService.RenderStepped:Connect(function()
    if not NoStun then return end

    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if humanoid.PlatformStand then
        humanoid.PlatformStand = false
    end

    humanoid:ChangeState(Enum.HumanoidStateType.Running)

    if humanoid.WalkSpeed < 20 then
        humanoid.WalkSpeed = 20
    end

    if humanoid.UseJumpPower then
        if humanoid.JumpPower < 50 then
            humanoid.JumpPower = 50
        end
    else
        if humanoid.JumpHeight < 7 then
            humanoid.JumpHeight = 7
        end
    end

    for _, v in pairs(character:GetChildren()) do
        local name = v.Name:lower()
        if name:find("stun") or name:find("disable") or name:find("freeze") then
            v:Destroy()
        end
    end
end)
