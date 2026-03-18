repeat task.wait() until game.Players.LocalPlayer

local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- tạo tool
local tool = Instance.new("Tool")
tool.Name = "Speed Tool"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local enabled = false
local normalSpeed = 16
local fastSpeed = 50

local loop

local function toggleSpeed()

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	enabled = not enabled

	if enabled then
		loop = RunService.Heartbeat:Connect(function()
			if hum then
				hum.WalkSpeed = fastSpeed
			end
		end)
	else
		if loop then
			loop:Disconnect()
			loop = nil
		end
		hum.WalkSpeed = normalSpeed
	end

end

-- 👉 click tool để bật/tắt
tool.Activated:Connect(toggleSpeed)
