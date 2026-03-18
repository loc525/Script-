repeat task.wait() until game.Players.LocalPlayer

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local tool = Instance.new("Tool")
tool.Name = "Look Tele"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local distance = 30

tool.Activated:Connect(function()

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	-- lấy hướng nhìn
	local look = camera.CFrame.LookVector
	
	-- ❗ bỏ trục Y để không chui xuống đất
	local flatLook = Vector3.new(look.X, 0, look.Z)

	if flatLook.Magnitude == 0 then return end

	flatLook = flatLook.Unit

	local newPos = root.Position + (flatLook * distance)

	-- giữ nguyên độ cao
	root.CFrame = CFrame.new(newPos.X, root.Position.Y, newPos.Z)

end)
