local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkeetInternal_Secure"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -150, 0.4, -125)
Main.Size = UDim2.new(0, 300, 0, 250)
Main.Active = true
Main.Draggable = true

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
TopLine.BorderSizePixel = 0
TopLine.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 12)
Title.Size = UDim2.new(0, 200, 0, 15)
Title.Font = Enum.Font.Code
Title.Text = "SKEET.CC // INTERNAL PRIVATE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

local ScanPanel = Instance.new("Frame")
ScanPanel.Parent = Main
ScanPanel.Position = UDim2.new(0.05, 0, 0.2, 0)
ScanPanel.Size = UDim2.new(0.9, 0, 0.32, 0)
ScanPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ScanPanel.BorderSizePixel = 0

local Avatar = Instance.new("ImageLabel")
Avatar.Parent = ScanPanel
Avatar.Size = UDim2.new(0, 65, 0, 65)
Avatar.Position = UDim2.new(0.05, 0, 0.1, 0)
Avatar.BackgroundTransparency = 1
Avatar.Image = "rbxassetid://0"

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ScanPanel
StatusLabel.Position = UDim2.new(0.35, 0, 0.1, 0)
StatusLabel.Size = UDim2.new(0.6, 0, 0.8, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Code
StatusLabel.Text = "IDLE\nAWAITING..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local Console = Instance.new("ScrollingFrame")
Console.Parent = Main
Console.Position = UDim2.new(0.05, 0, 0.55, 0)
Console.Size = UDim2.new(0.9, 0, 0.28, 0)
Console.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Console.BorderSizePixel = 0
Console.CanvasSize = UDim2.new(0, 0, 8, 0)
Console.ScrollBarThickness = 0

local Log = Instance.new("TextLabel")
Log.Parent = Console
Log.Size = UDim2.new(1, -5, 1, 0)
Log.BackgroundTransparency = 1
Log.TextColor3 = Color3.fromRGB(0, 255, 120)
Log.Font = Enum.Font.Code
Log.TextSize = 9
Log.TextXAlignment = Enum.TextXAlignment.Left
Log.TextYAlignment = Enum.TextYAlignment.Top
Log.Text = "> System authorized. Node ID: 0x882"

local ProgressBack = Instance.new("Frame")
ProgressBack.Size = UDim2.new(0.9, 0, 0, 3)
ProgressBack.Position = UDim2.new(0.05, 0, 0.92, 0)
ProgressBack.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ProgressBack.BorderSizePixel = 0
ProgressBack.Parent = Main

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBack

local Action = Instance.new("TextButton")
Action.Parent = Main
Action.Position = UDim2.new(0.05, 0, 0.85, 0)
Action.Size = UDim2.new(0.9, 0, 0, 25)
Action.BackgroundTransparency = 1
Action.Text = "[ EXECUTE KERNEL INJECTION ]"
Action.Font = Enum.Font.Code
Action.TextColor3 = Color3.fromRGB(255, 255, 255)
Action.TextSize = 12

local function AddLog(msg)
    Log.Text = Log.Text .. "\n" .. msg
    Console.CanvasPosition = Vector2.new(0, Log.TextBounds.Y)
end

Action.MouseButton1Click:Connect(function()
    Action.Visible = false
    AddLog("> Initializing security protocol...")
    
    local plist = Players:GetPlayers()
    for i, p in ipairs(plist) do
        local content, ready = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        Avatar.Image = content
        StatusLabel.Text = "SCANNING:\n" .. p.Name:upper() .. "\nUID: " .. p.UserId .. "\nRESULT: [CLEAN]"
        AddLog("> Inspecting entity: " .. p.Name)
        
        local ratio = (i / #plist) * 0.45
        TweenService:Create(ProgressFill, TweenInfo.new(0.4), {Size = UDim2.new(ratio, 0, 1, 0)}):Play()
        task.wait(0.4)
    end
    
    StatusLabel.Text = "SCAN COMPLETE\nENVIRONMENT: SECURE\nRANK: INTERNAL"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
    task.wait(1)
    
    local steps = {
        "Requesting memory segments...",
        "Hooking global metatable...",
        "Patching Luau VM registers...",
        "Synchronizing cloud database...",
        "Applying security bypass [v4.2]..."
    }
    
    for i, s in ipairs(steps) do
        AddLog("> " .. s)
        local base = 0.45 + (i / #steps) * 0.54
        TweenService:Create(ProgressFill, TweenInfo.new(1.5), {Size = UDim2.new(base, 0, 1, 0)}):Play()
        task.wait(1.5)
    end
    
    AddLog("> FATAL EXCEPTION: DATA_MISMATCH")
    task.wait(1.2)
    
    player:Kick("\n\n[SKEET INTERNAL - SECURITY BREACH]\n\nUnauthorized memory access at 0x004F2.\n\nYour hardware failed the final integrity check. This may happen if your Windows version is outdated or if a debugger is detected.\n\nPlease contact the administrator for a license reset.\n\nError: 0xINTERNAL_SIG_INVALID")
end)
local randomKey = RandomString(30) .. "0"

    local args1 = {tick(), randomKey, tool, "FDS9I83", shootPosition, {hitDirection}, false}
    local args2 = {"1", tool, randomKey, 1, head, hitPosition, hitDirection}
    
    -- Script generated by TurtleSpy, made by Intrer#0421

game:GetService("ReplicatedStorage")["181d1934093e"]:FireServer({["Received"] = 5,["Loader"] = [''] --[[ PARENTED TO NIL OR DESTROYED ]].ClientMover,["Mode"] = "Fire",["Sent"] = 8,["Module"] = .Client --[[ PARENTED TO NIL OR DESTROYED ]]},"u&NW.( '",{["Received"] = 5,["Sent"] = 7},"6b206a5620157d5b3c")

game:GetService("ReplicatedStorage").Events.REPMVMNTSND:FireServer("Jumping")

-- Script generated by TurtleSpy, made by Intrer#0421

game:GetService("ReplicatedStorage").Events.ZFKLF__H:FireServer("🧈",game:GetService("Players").LocalPlayer.Backpack.Beretta,"Lapdi[^aKTOHggLxNvp]x`hPPsjljb0",1,workspace.Characters.Israe124522.Torso,,,{"Back",UDim2.new({0.156005859, -3}, {0.0854988098, -3}),Vector2.new(20, 20)})

-- Script generated by TurtleSpy, made by Intrer#0421

game:GetService("ReplicatedStorage").Events.MSNYCHE:FireServer(-3135850347.3720465)

-- Script generated by TurtleSpy, made by Intrer#0421

game:GetService("ReplicatedStorage").Events.GNX_S:FireServer(1762925952.7947776,"YAWruzphCKjyOtufpynKlAh_DB[r]`0",workspace.Characters.ChasePhoenixStarry61.Beretta,"FDS9I83",,{},false)
end)
