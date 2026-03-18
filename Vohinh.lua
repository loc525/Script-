repeat task.wait() until game.Players.LocalPlayer.Character

local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local char = player.Character
local enabled = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0,120,0,40)
button.Position = UDim2.new(0,20,0,200)
button.Text = "INVIS OFF"
button.BackgroundColor3 = Color3.fromRGB(170,0,0)

-- kéo được (fix cho mọi executor)
button.Active = true
button.Draggable = true

-- hàm bật/tắt
local function toggle()

	enabled = not enabled

	if enabled then
		button.Text = "INVIS ON"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)

		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 1
			end
		end

	else
		button.Text = "INVIS OFF"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)

		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
			end
		end

	end

end

-- bấm nút
button.MouseButton1Click:Connect(toggle)

-- bấm G trên PC
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.G then
		toggle()
	end
end)
