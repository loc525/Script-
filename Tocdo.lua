local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Nút On/Off luôn hiển thị
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 50, 0, 20)
toggle.Position = UDim2.new(0, 20, 0, 20)
toggle.Text = "ON"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
toggle.Parent = screenGui

-- Frame chỉnh tốc độ
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 70)
frame.Position = UDim2.new(0, 80, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = screenGui

-- Label hiện tốc độ
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -10, 0, 20)
label.Position = UDim2.new(0, 5, 0, 5)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Text = "Speed: "..humanoid.WalkSpeed
label.Parent = frame

-- TextBox chỉnh tốc độ
local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -10, 0, 20)
box.Position = UDim2.new(0, 5, 0, 35)
box.Text = tostring(humanoid.WalkSpeed)
box.TextColor3 = Color3.new(0,0,0)
box.BackgroundColor3 = Color3.fromRGB(200,200,200)
box.ClearTextOnFocus = false
box.Parent = frame

-- Thay đổi tốc độ khi nhấn Enter
box.FocusLost:Connect(function()
    local value = tonumber(box.Text)
    if value then
        humanoid.WalkSpeed = value
        label.Text = "Speed: "..value
    else
        box.Text = tostring(humanoid.WalkSpeed)
    end
end)

-- On/Off chỉ ẩn frame, nút vẫn hiện
toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggle.Text = frame.Visible and "ON" or "OFF"
end)
