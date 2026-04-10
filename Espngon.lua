--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// Toggle
local ESPEnabled = false

--// UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Button = Instance.new("TextButton", ScreenGui)

Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "ESP: OFF"
Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
Button.TextColor3 = Color3.new(1,1,1)
Button.TextScaled = true
Button.Draggable = true

Button.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    Button.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"
end)

--// ESP Function
local function createESP(player)
    if player == LocalPlayer then return end
    
    local function onCharacter(char)
        local head = char:WaitForChild("Head", 5)
        local humanoid = char:WaitForChild("Humanoid", 5)
        if not head or not humanoid then return end

        -- Billboard
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP"
        bill.Size = UDim2.new(0, 180, 0, 40)
        bill.Adornee = head
        bill.AlwaysOnTop = true
        bill.StudsOffset = Vector3.new(0, 2, 0)
        bill.Parent = head

        -- Tên (nhỏ)
        local nameText = Instance.new("TextLabel", bill)
        nameText.Size = UDim2.new(1, 0, 0.5, 0)
        nameText.Position = UDim2.new(0, 0, 0, 0)
        nameText.BackgroundTransparency = 1
        nameText.TextColor3 = Color3.new(1, 1, 1)
        nameText.TextStrokeTransparency = 0
        nameText.TextScaled = false
        nameText.TextSize = 14
        nameText.Font = Enum.Font.SourceSansBold

        -- Máu (nhỏ)
        local hpText = Instance.new("TextLabel", bill)
        hpText.Size = UDim2.new(1, 0, 0.5, 0)
        hpText.Position = UDim2.new(0, 0, 0.5, 0)
        hpText.BackgroundTransparency = 1
        hpText.TextColor3 = Color3.new(1, 0, 0)
        hpText.TextStrokeTransparency = 0
        hpText.TextScaled = false
        hpText.TextSize = 13
        hpText.Font = Enum.Font.SourceSans

        -- Update
        RunService.RenderStepped:Connect(function()
            if ESPEnabled and humanoid.Health > 0 then
                bill.Enabled = true
                nameText.Text = player.Name
                hpText.Text = "HP: " .. math.floor(humanoid.Health)
            else
                bill.Enabled = false
            end
        end)
    end

    if player.Character then
        onCharacter(player.Character)
    end

    player.CharacterAdded:Connect(onCharacter)
end

--// Load ESP
for _, plr in pairs(Players:GetPlayers()) do
    createESP(plr)
end

Players.PlayerAdded:Connect(createESP)
