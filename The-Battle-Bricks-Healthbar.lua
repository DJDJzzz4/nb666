local Players = game:GetService("Players")
local tracked = {}

local function makeBar(model)
	if tracked[model] then return end
	
	local root = model:FindFirstChild("HumanoidRootPart")
	local head = model:FindFirstChild("Head")
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not root or not head or not humanoid then return end

	local bb = Instance.new("BillboardGui")
	bb.Adornee = root
	bb.Size = UDim2.fromOffset(130, 14)
	bb.StudsOffset = Vector3.new(0, (head.Position.Y + head.Size.Y/2 + 1) - root.Position.Y, 0)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.MaxDistance = 100
	bb.Parent = root

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	bg.BorderSizePixel = 0
	bg.Parent = bb
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = bg

	local clip = Instance.new("Frame")
	clip.Size = UDim2.fromScale(1, 1)
	clip.BackgroundTransparency = 1
	clip.BorderSizePixel = 0
	clip.ClipsDescendants = true
	clip.Parent = bg
	
	local clipCorner = Instance.new("UICorner")
	clipCorner.CornerRadius = UDim.new(0, 5)
	clipCorner.Parent = clip

	local dmg, hp = Instance.new("Frame"), Instance.new("Frame")
	for _, f in ipairs({dmg, hp}) do
		f.Size = UDim2.fromScale(1, 1)
		f.BorderSizePixel = 0
		f.Parent = clip
	end
	dmg.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
	hp.BackgroundColor3 = Color3.fromRGB(0, 220, 220)

	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.fromScale(1, 1)
	txt.BackgroundTransparency = 1
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true
	txt.TextColor3 = Color3.new(1, 1, 1)
	txt.TextStrokeTransparency = 0
	txt.ZIndex = 5
	txt.Parent = bb

	local lastHealth, damageToken = humanoid.Health, 0

	local function update()
		if not model.Parent then return end
		local ratio = math.max(humanoid.Health, 0) / math.max(humanoid.MaxHealth, 1)
		txt.Text = string.format("%d / %d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
		hp.Size = UDim2.new(ratio, 0, 1, 0)

		if humanoid.Health < lastHealth then
			damageToken += 1
			local token, target = damageToken, ratio
			task.delay(1.2, function()
				if token == damageToken and dmg.Parent then
					dmg:TweenSize(UDim2.new(target, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.9, true)
				end
			end)
		elseif humanoid.Health > lastHealth then
			damageToken += 1
			dmg.Size = UDim2.new(ratio, 0, 1, 0)
		end
		lastHealth = humanoid.Health
	end

	update()
	humanoid.HealthChanged:Connect(update)
	model.AncestryChanged:Connect(function()
		if not model.Parent and tracked[model] then
			tracked[model].gui:Destroy()
			tracked[model] = nil
		end
	end)
	tracked[model] = {gui = bb}
end

local function scan(model)
	if tracked[model] or not model:FindFirstChildOfClass("Humanoid") or not model:FindFirstChild("HumanoidRootPart") then return end
	makeBar(model)
end

for _, p in ipairs(Players:GetPlayers()) do
	if p.Character then task.wait(0.5) scan(p.Character) end
	p.CharacterAdded:Connect(function(c) task.wait(0.5) scan(c) end)
end

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c) task.wait(0.5) scan(c) end)
end)

for _, o in ipairs(workspace:GetDescendants()) do
	if o:IsA("Model") and not Players:GetPlayerFromCharacter(o) then scan(o) end
end

workspace.DescendantAdded:Connect(function(o)
	if o:IsA("Model") and not Players:GetPlayerFromCharacter(o) then task.wait(0.5) scan(o) end
end)