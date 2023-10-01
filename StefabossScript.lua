--This Script was Made by Stefaboss you can subscribe to my youtube channel: Stefaboss

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Stefaboss hack", "Sentinel")

-- MAIN
local MAIN = Window:NewTab("MAIN")
local MainSection = MAIN:NewSection("MAIN")




MainSection:NewButton("ESP", "", function()
	 local settings = {
	   defaultcolor = Color3.fromRGB(255,0,0),
	   teamcheck = false,
	   teamcolor = true
	};

-- services
	local runService = game:GetService("RunService");
	local players = game:GetService("Players");

-- variables
	local localPlayer = players.LocalPlayer;
	local camera = workspace.CurrentCamera;

-- functions
	local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
	local tan, rad = math.tan, math.rad;
	local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
	local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;

	local espCache = {};
	local function createEsp(player)
	   local drawings = {};
   
	   drawings.box = newDrawing("Square");
	   drawings.box.Thickness = 1;
 	  drawings.box.Filled = false;
	   drawings.box.Color = settings.defaultcolor;
	   drawings.box.Visible = false;
	   drawings.box.ZIndex = 2;

	   drawings.boxoutline = newDrawing("Square");
	   drawings.boxoutline.Thickness = 3;
	   drawings.boxoutline.Filled = false;
	   drawings.boxoutline.Color = newColor3();
	   drawings.boxoutline.Visible = false;
	   drawings.boxoutline.ZIndex = 1;

	   espCache[player] = drawings;
	end

	local function removeEsp(player)
	   if rawget(espCache, player) then
	       for _, drawing in next, espCache[player] do
	           drawing:Remove();
	       end
	      espCache[player] = nil;
	   end
	end

	local function updateEsp(player, esp)
		 local character = player and player.Character;
		  if character then
	       local cframe = character:GetModelCFrame();
	       local position, visible, depth = wtvp(cframe.Position);
	       esp.box.Visible = visible;
	       esp.boxoutline.Visible = visible;

	       if cframe and visible then
	           local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
	           local width, height = round(4 * scaleFactor, 5 * scaleFactor);
	           local x, y = round(position.X, position.Y);

	           esp.box.Size = newVector2(width, height);
	           esp.box.Position = newVector2(round(x - width / 2, y - height / 2));
	           esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;

	           esp.boxoutline.Size = esp.box.Size;
	           esp.boxoutline.Position = esp.box.Position;
	       end
	   else
	       esp.box.Visible = false;
	       esp.boxoutline.Visible = false;
	   end
	end

-- main
	for _, player in next, players:GetPlayers() do
	   if player ~= localPlayer then
	       createEsp(player);
	   end
	end

	players.PlayerAdded:Connect(function(player)
	  createEsp(player);
	end);

	players.PlayerRemoving:Connect(function(player)
	   removeEsp(player);
	end)

	runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
	   for player, drawings in next, espCache do
	       if settings.teamcheck and player.Team == localPlayer.Team then
	           continue;
	       end

	       if drawings and player ~= localPlayer then
	           updateEsp(player, drawings);
	       end
	   end
	end)
end)

MainSection:NewToggle("superhuman", "boosts you", function(state)
	if state then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
	else
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
	end
end)

MainSection:NewButton("Infinite Yield", "admin command", function(state)
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- LOCAL PLAYER
local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player")

PlayerSection:NewSlider("Walkspeed", "how fast you want to go", 500, 16, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("JumpPower", "jump", 500, 50, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("Reset WP and JP", "resets to defaults", function()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
	end)

--Other
local Other = Window:NewTab("Other")
local OtherSection = Other:NewSection("Other")

OtherSection:NewButton("click to tp", "This gives you AN item that makes you teleport wherever you press", function()
    mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "Click Teleport" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
end)

OtherSection:NewButton("Chat spoofer", "Lets you chat for other people", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/djBfk8Li'),true))()
end)

OtherSection:NewButton("Bypassed fly", "fly", function()
	 loadstring(game:HttpGet(('https://pastebin.com/raw/WxmvCLLH'),true))()
end)

--For Combat Warriors

local CW = Window:NewTab("Combat Warriors")
local CWSection = CW:NewSection("Combat warriors")

CWSection:NewButton("Project hook", "Only works in combat warriors", function()
	loadstring(game:HttpGet("https://projecthook.xyz/scripts/free.lua"))()
end)

CWSection:NewButton("Nova.xyz", "Only works in combat warriors", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/master/novahub"))()
end)

CWSection:NewButton("Bypassed fly", "same as in Other Section", function()
	 loadstring(game:HttpGet(('https://pastebin.com/raw/WxmvCLLH'),true))()
end)

-- For arsenal 

local FPS = Window:NewTab("FPS GAMES")
local FPSSection = FPS:NewSection("Hacks")

FPSSection:NewButton("Aimbot", "Hold right click when u see an enemy", function()
	_G.AimbotInput = "RightClick" -- // RightClick, LeftClick, Q, etc...
	_G.AimbotEasing = 0.2 -- // Stage of Linear Easing to target when enabled
	_G.TeamCheck = true -- // Checks the team of the target to make sure they're not on your team

	loadstring(game:HttpGet("https://raw.githubusercontent.com/zeroisswag/universal-aimbot/main/script.lua"))()
end)


--for SPTS

local Spts = Window:NewTab("Spts")
local SptsSection = Spts:NewSection("Vapour X scripts")
local GMSection = Spts:NewSection("GODMODE")
local autoSection = Spts:NewSection("Built in")

SptsSection:NewButton("VapourX", "Spts multi tool script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/oepcatoffical/Spts/main/VapourX", true))()
end)

GMSection:NewButton("GodMode", "forcefield", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/1ArcX/Scripts/main/God%20Mode", true))()
end)

SptsSection:NewButton("other script", "Spts multi tool script", function()
	loadstring(game:HttpGet('https://pastebin.com/raw/D9btNZUr', true))()
end)

autoSection:NewToggle("0 strength", "s2", function(state)
	if state then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(409,270,978)

		_G.autoS2 = true;
		while _G.autoS2 == true do
			local args = {
				[1] = {
					[1] = "+FS2"
				}
			}

			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

			wait()
		end

	else
		_G.autoS2 = false;
		
	end
end)

autoSection:NewToggle("0 strength pt2", "s3", function(state)
	if state then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2279,1943,1051)

		_G.autoS3 = true;
		while _G.autoS3 == true do
			local args = {
				[1] = {
					[1] = "+FS3"
				}
			}

			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

			wait()
		end

	else
		_G.autoS3 = false;
		
	end
end)

autoSection:NewToggle("1b strength", "s4", function(state)
	if state then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1176,4789,-2293)

		_G.autoS4 = true;
		while _G.autoS4 == true do
			local args = {
				[1] = {
					[1] = "+FS4"
				}
			}

			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

			wait()
		end

	else
		_G.autoS4 = false;
		
	end
end)

autoSection:NewToggle("10t strength", "s", function(state)
	if state then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-369, 15735, -9)

		_G.autoTap = true;
		while _G.autoTap == true do
			local args = {
				[1] = {
					[1] = "+FS6"
				}
			}

			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

			wait()
		end

	else
		_G.autoTap = false;
		
	end
end)

autoSection:NewToggle("psych", "s", function(state)
	if state then

		_G.autoP2 = true;
		while _G.autoP2 == true do
			local args = {
				[1] = {
					[1] = "+PP2"
				}
			}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait()
		end
	else
		_G.autoP2 = false;
		
	end
end)

autoSection:NewToggle("1qa psych", "s", function(state)
	if state then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2544, 5412, -495)

		_G.autoP = true;
		while _G.autoP == true do
			local args = {
				[1] = {
					[1] = "+PP6"
				}
			}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait()
		end
	else
		_G.autoP = false;
		
	end
end)

--for bladeball

local bladeball = Window:NewTab("Blade Ball")
local BBSection = bladeball:NewSection("Scripts")

BBSection:NewButton("Auto Parry pt1", "🔥Inferno Hub V2 pick ping based", function()
    getgenv().visualizer = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/RedCircleBlock"))()
    loadstring(game:HttpGet("https://github.com/SadlekAski/Scripts/raw/main/Blade%20Ball/Equip%20any%20ability.lua"))()
end)

BBSection:NewButton("Auto Parry pt2", "use for lms parry", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8555f27454c952fb960ba00a4cd3f8f6.lua"))()
end)

local Bloxfruits = Window:NewTab("Bloxfruits")
local bfSection = Bloxfruits:NewSection("Scripts")

bfSection:NewButton("Thunder Keyless ", "script", function()
    getgenv().visualizer = true
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ThunderZ-HUB/HUB/main/RemakeMobileTest', true))()
end)

