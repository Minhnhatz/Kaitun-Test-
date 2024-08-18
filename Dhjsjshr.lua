





if not game:IsLoaded() then game.Loaded:Wait() end

repeat task.wait() until game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") or game.Players.LocalPlayer.Team ~= nil;

print("--[[Join Team]]--")

do -- Team Script
	repeat 
		ChooseTeam = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ChooseTeam",true)
		UIController = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UIController",true)
		if UIController and ChooseTeam then
			if ChooseTeam.Visible then
				for i,v in pairs(getgc()) do
					if type(v) == "function" and getfenv(v).script == UIController then
						local constant = getconstants(v)
						pcall(function()
							if constant[1] == "Pirates" and #constant == 1 then
								v(getgenv().Team or "Pirates")
							end
						end)
					end
				end
			end
		end
		wait(1)
	until game.Players.LocalPlayer.Team
	repeat wait() until game.Players.LocalPlayer.Character
end

task.wait()

LoadingScriptSuccess = false
setfpscap(200)

if _G.AutoDeleteWorkSpace then 
	if isfolder("a_temp") then
		delfolder("a_temp")
	end
	if isfile("a_temp/268.txt") then
		delfile("a_temp/268.txt")
	end
	if isfile("BF_Kick_Log.txt") then
		delfile("BF_Kick_Log.txt")
	end
	task.wait(0.1)
end
if not isfolder("a_temp") then
	makefolder("a_temp")
end

if not isfile("a_temp/268.txt") then
	writefile("a_temp/268.txt",tostring(os.time()))
end

local queue_on_teleport = queue_on_teleport
if LPH_OBFUSCATED then
	queue_on_teleport([[
		task.wait(0.5)
		setfpscap(200)
	]])
end

-- loading ui
local DebugModeApi
DebugModeApi = game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Donate-Me/main/Debug.boolean")
local DebugMode
if DebugModeApi:match("debug owo") then
	DebugMode = true
else
	DebugMode = false
end

local isPrivate = false
spawn(function()
	pcall(function()
		local privaterquest,GetJsonReq = pcall(function() return game:HttpGet("https://httpbin.org/get", true) end)
		if privaterquest == true then
			local GetJsonReqR = game:GetService("HttpService"):JSONDecode(GetJsonReq)
			if tostring(GetJsonReqR["headers"]["Roblox-Session-Id"]):find("PrivateGame") then
				isPrivate = true
			else
				isPrivate = false   
			end
		else
			isPrivate = true
		end
	end)
end)

local CodeApi = {}

task.spawn(function()
	local Url = "https://tryhardguides.com/blox-fruits-codes/"
	local Response = game:HttpGet(Url)
	for ul in string.gmatch(Response, "<ul>(.-)</ul>") do
		for li in string.gmatch(ul, "<li>(.-)</li>") do
			for Code in string.gmatch(li, "<strong>([^<]+)</strong>") do
				table.insert(CodeApi, Code)
			end
		end
	end
end)

if type(getgenv().Configs) ~= "table" then
	getgenv().Configs = {
		Main = {
			SkipFarm = true,
			HopIfCantKill = true,
			BlockAllHop = false,

			FastAttack = true,

			Start = true
		},

		FirstSea = {
			-- World 1
			AutoPole = true, -- จะตีเเค่ถ้ามันเกิดไม่ได้ตีจนกว่าจะได้
			AutoSaber = true,
			AutoSecondSea = true,
		},

		SecondSea = {
			-- World 2
			AutoRengoku = true,

			AutoSecondSea = true,
			AutoQuestFlower = true,
			AutoRaceV3 = true,
			AutoBartiloQuest = true,
			AutoCursedCaptain = true,
			AutoDarkbeard = true,
			AutoFactory = true,
			AutoThirdSea = true,

			AlliesFruit = {"Dragon-Dragon","Spirit-Spirit","Venom-Venom","Dough-Dough"}, -- จะไม่ใช้ผลพวกนี้ในการเปิดประตูไปโลก3
		},

		ThirdSea = {
			-- World 3
			AutoHallowScythe = true,
			AutoBuddySword = true,
			AutoDoughKing = true,
			AutoSpikeyTrident = true,
			AutoTushita = true,
			AutoEliteHunter = true,
			AutoDarkDagger = true,
			AutoYama = true,
			AutoCanvander = true,
			SkipGetItemGuitar = true, -- จะไม่ หาของทำ soul guiter ในโลก 2 เบบ หาจนกว่าจะได้ will not find item until get all item for do soul guiter ( open recommend เเนะนำให้เปิด )
			AutoSoulGuitar = true, 
			AutoRainbowHaki = true,
			AutoCursedDualKatana = true,
		},

		FightingStyle = {
			-- Fighting Style 
			AutoGodHuman = true,
			AutoSuperhuman = true,
			AutoDeathStep = true,
			AutoSharkmanKarate = true,
			AutoElectricClaw = true,
			AutoDargonTalon = true,
		},

		Mastery = {
			-- Auto Farm Mastery
			AutoDFMastery = true,
			SettingsSkill = { -- ถ้าไม่ใส่จะใช้ mode auto
				-- ["Z"] = 0.1,
				-- ["X"] = 0.1,
				-- ["C"] = 0.1,
				-- ["V"] = 0.1, -- อันไหนไม่เอาลบออกไปเลย
			},
			AutoSwordMastery = true,
			SelectRaritySword = {"Mythical","Legendary"}, -- Common , Uncommon,Rare,Legendary,Mythical

		},

		Settings = {
			-- code

			SelectRedeemCodeLevel = 1,

			-- Raids

			SelectRateFruitRaid = 1000000, -- if fruit price less u rate then we use it to auto raids
			LimitFragmentsRaids = 100000,
		},

		FruitsSettings = {
			-- Devil Fruit

			SelectMainDF = {"Dragon-Dragon","Spirit-Spirit","Venom-Venom","Dough-Dough"}, -- ผลหลักที่จะกินเเทนผลรอง
			SelectSubDF = {"Ice-Ice","Sand-Sand","Dark-Dark","Quake-Quake","Light-Light"}, -- ผลรองจะกินไว้ก่อนเเล้วพอผลหลักมีก้จะเปลียนไปกินผิดหลัก
			AllowEatDFInventory = true,
			StartSniper = true,
		},

		Webhook = {
			-- Webhook

			StartWebhook = false,
			WebhookURL = "",
			WebhookMode = "Send On Level Max And Every 10 min", -- "Send Every 10 min","Send On Level Max And Every 10 min"
		},

		Fps = {
			-- CPU

			FpsBoost = true,
			LockFPS = 120,
			LockFPSNow = true,
			WhiteScreen = false
		}
	}
end

-- RAM

-- RAMPort = 7963,
-- RAMPassword = "",
-- AutoDescription = false,

local NoLoopDuplicate1 = false
local NoLoopDuplicate2 = false
local NoLoopDuplicate3 = false
local NoLoopDuplicate4 = false
local NoLoopDuplicate5 = false
local NoLoopDuplicate6 = false

local TableSwapMob = {}
local AllMobCFrame = {}
local SwapMobNoLoop = false
local ErrorCount = 0
local NearPlayer = false

local BlackLegDone = false
local FishmanKarateDone = false
local ElectroDone = false
local DragonDone = false

local DeathStepDone = false
local SharkmanKarateDone = false
local SuperhumanDone = false
local ElectricClawDone = false
local DargonTalonDone = false

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService('VirtualUser')
local GetCollectionService = game:GetService("CollectionService");

local GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
local GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
local MyLevel = game.Players.LocalPlayer.Data.Level.Value

local countre = 0
local AreBuyKabcha = false
local AreRedeem = false
local TypeWeapon = "Melee"
local JustHave = {}

local MaxLevel = 2550
local SubQuest = false
local DeSubQuest = false
local countskiperror = 0
local HelpCup = false

if not LPH_OBFUSCATED then
	LPH_JIT = (function(...) return ... end)
	LPH_JIT_MAX = (function(...) return ... end)
	LPH_NO_VIRTUALIZE = (function(...) return ... end)
	LPH_NO_UPVALUES = (function(...) return ... end)
end
task.spawn(function()
	while task.wait() do
		pcall(function()
			for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
				if v:IsA("Model") then  
					if v:FindFirstChild("Humanoid") and v.Name ~= v:FindFirstChild("Humanoid").DisplayName then
						v.Name = v:FindFirstChild("Humanoid").DisplayName
					end
				end
			end
			for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
				if v:IsA("Model") then  
					if v:FindFirstChild("Humanoid") and v.Name ~= v:FindFirstChild("Humanoid").DisplayName then
						v.Name = v:FindFirstChild("Humanoid").DisplayName
					end
				end
			end
		end)
	end
end)

local http_request = http_request;
http_request = request


local MouseCheckReq = game.Players.LocalPlayer:GetMouse()
local Particle = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"):WaitForChild("Particle"))

LPH_NO_VIRTUALIZE(function()
	local old = Particle.play
	Particle.play = function(...) end
	spawn(function()
		for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Death:GetChildren()) do 
			if v:IsA("ParticleEmitter") then
				v.Texture = 0
			end
		end
		for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Death.eff:GetChildren()) do 
			v:Destroy()
		end
	end)
end)()

local placeId = game.PlaceId
local OldWorld,NewWorld,ThreeWorld
if placeId == 2753915549 then
	OldWorld = true
elseif placeId == 4442272183 then
	NewWorld = true
elseif placeId == 7449423635 then
	ThreeWorld = true                                                                                           
end

local AllEntrance
if OldWorld then
	AllEntrance = {
		Vector3.new(61163.8515625, 11.6796875, 1819.7841796875), -- under water
		Vector3.new(3864.8515625, 6.6796875, -1926.7841796875), -- hole up water
		Vector3.new(-4607.8227539063, 872.54248046875, -1667.5568847656), -- sky 2
		Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047), -- sky 3
	}
elseif NewWorld then
	AllEntrance = {
		Vector3.new(923.21252441406, 126.9760055542, 32852.83203125), -- in ship
		Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422), -- out ship
		Vector3.new(2284,15,905), -- in don 
		Vector3.new(-286.98907470703125, 306.1379089355469, 597.8827514648438), -- out don
	}
elseif ThreeWorld then
	AllEntrance = {
		Vector3.new(-12548, 337, -7481), -- Mansion
		Vector3.new(-5096.44482421875, 315.44134521484375, -3105.741943359375), -- cc o c
		Vector3.new(5746.46044921875, 610.4500122070312, -244.6104278564453), -- hydra
		Vector3.new(5314.58203125, 22.562240600585938, -125.94227600097656), -- btf p in
		Vector3.new(-11993.580078125, 331.8335876464844, -8844.1826171875), -- btf p out
		Vector3.new(28288.15234375, 14896.5341796875, 100.4998779296875), -- temp
	}
end

-- Function

function EquipWeapon(...)
	local Get = {...}
	if Get[1] then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1])) then
			local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1]))
			task.wait()
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	else
		spawn(function()
			ToolSe = ""
			if TypeWeapon == "Blox Fruit" then TypeWeaponReal = "Melee" else TypeWeaponReal = TypeWeapon end
			for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == TypeWeaponReal then
						ToolSe = v.Name
					end
				end
			end
			for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == TypeWeaponReal then
						ToolSe = v.Name
					end
				end
			end
			if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
				task.wait()
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			end
		end)
	end	
end

function CheckIsland()
	GoIsland = 0
	ToIslandCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local ToIslandCFrame2 = {
		1,
		2,
		3,
		4,
		5
	}
	local MaxDisLand = {
		[1] = math.huge,
		[2] = math.huge,
		[3] = math.huge,
		[4] = math.huge,
		[5] = math.huge
	}
	for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do 
		local ThisDis = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

		if v.Name == "Island 5" then
			if ThisDis < MaxDisLand[5] and ThisDis < 5000 then
				MaxDisLand[5] = ThisDis
				GoIsland = 5
				ToIslandCFrame2[5] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 4" then
			if ThisDis < MaxDisLand[4] and ThisDis < 5000 then
				MaxDisLand[4] = ThisDis
				GoIsland = 4
				ToIslandCFrame2[4] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 3" then
			if ThisDis < MaxDisLand[3] and ThisDis < 5000 then
				MaxDisLand[3] = ThisDis
				GoIsland = 3
				ToIslandCFrame2[3] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name ==  "Island 2" then
			if ThisDis < MaxDisLand[2] and ThisDis < 5000 then
				MaxDisLand[2] = ThisDis
				GoIsland = 2
				ToIslandCFrame2[2] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 1" then
			if ThisDis < MaxDisLand[1] and ThisDis < 5000 then
				MaxDisLand[1] = ThisDis
				GoIsland = 1
				ToIslandCFrame2[1] = v.CFrame * CFrame.new(0,80,1)
			end
		end
	end
	if GoIsland > 0 then
		return true
	else
		return false
	end
end


function NextIsland()
	GoIsland = 0
	ToIslandCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local ToIslandCFrame2 = {
		1,
		2,
		3,
		4,
		5
	}
	local MaxDisLand = {
		[1] = math.huge,
		[2] = math.huge,
		[3] = math.huge,
		[4] = math.huge,
		[5] = math.huge
	}
	local AddCFrame
	pcall(function()
		if string.find(game.Players.LocalPlayer.Data:WaitForChild("DevilFruit").Value,"Phoenix") then
			AddCFrame = CFrame.new(math.random(20,80),80,math.random(20,80))
		else
			AddCFrame = CFrame.new(0,80,1)
		end
	end)
	for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do 
		local ThisDis = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

		if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
		elseif v.Name == "Island 5" then
			if ThisDis < MaxDisLand[5] and ThisDis < 4000 then
				MaxDisLand[5] = ThisDis
				GoIsland = 5
				ToIslandCFrame2[5] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 4" then
			if ThisDis < MaxDisLand[4] and ThisDis < 4000 and GoIsland < 4 then
				MaxDisLand[4] = ThisDis
				GoIsland = 4
				ToIslandCFrame2[4] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 3" then
			if ThisDis < MaxDisLand[3] and ThisDis < 4000 and GoIsland < 3 then
				MaxDisLand[3] = ThisDis
				GoIsland = 3
				ToIslandCFrame2[3] = v.CFrame * AddCFrame
			end
		elseif v.Name ==  "Island 2" then
			if ThisDis < MaxDisLand[2] and ThisDis < 4000 and GoIsland < 2 then
				MaxDisLand[2] = ThisDis
				GoIsland = 2
				ToIslandCFrame2[2] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 1" then
			if ThisDis < MaxDisLand[1] and ThisDis < 4000 and GoIsland < 1 then
				MaxDisLand[1] = ThisDis
				GoIsland = 1
				ToIslandCFrame2[1] = v.CFrame * AddCFrame
			end
		end
	end
	ToIslandCFrame = ToIslandCFrame2[GoIsland]
end

function GetFightingStyle(Style)
	ReturnText = ""
	for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	if ReturnText ~= "" then
		return ReturnText
	else
		return "Not Have"
	end
end

inmyself = LPH_JIT_MAX(function(name)
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(name) then
		return game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(name)
	end
	local OutValue
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
		if v:IsA("Tool") then
			if v.Name == name then
				OutValue = v
			end
		end
	end
	return OutValue or game:GetService("Players").LocalPlayer.Character:FindFirstChild(name)
end)

function RemoveTextFruit(str)
	return str:gsub(" Fruit", "")
end

function RemoveSomeThing(str)
	return tostring(str:gsub("RoyXHub_BF\\", ""))
end

function TableInsertNoDuplicates(tables,value)
	if table.find(tables,value) then else 
		table.insert(tables,value)
	end
end

local ServerFunc = {}

function ServerFunc:TeleportFast() 
	if isPrivate == false and not BlockAllHop then 
		if os.time() > tonumber(readfile("a_temp/268.txt")) then
            StatusFarm:Set({
                ["Title"] = "Status Farm",
                ["Content"] = "Server Hop"
            })
			pcall(function()
				writefile("a_temp/268.txt",tostring(os.time() + 60))
			end)
			local PlaceID = game.PlaceId
			local AllIDs = {}
			local foundAnything = ""
			local actualHour = os.date("!*t").hour
			local Deleted = false
			local File =
				pcall(
					function()
						AllIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
					end
				)
			if not File then
				table.insert(AllIDs, actualHour)
				writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
			end
			function TPReturner()
				local Site
				if foundAnything == "" then
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
							)
						)
				else
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" ..
								PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything
							)
						)
				end
				local ID = ""
				if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
					foundAnything = Site.nextPageCursor
				end
				local num = 0
				for i, v in pairs(Site.data) do
					local Possible = true
					ID = tostring(v.id)
					if tonumber(v.maxPlayers) > tonumber(v.playing) then
						for _, Existing in pairs(AllIDs) do
							if num ~= 0 then
								if ID == tostring(Existing) then
									Possible = false
								end
							else
								if tonumber(actualHour) ~= tonumber(Existing) then
									local delFile =
										pcall(
											function()
												delfile("NotSameServers.json")
												AllIDs = {}
												table.insert(AllIDs, actualHour)
											end
										)
								end
							end
							num = num + 1
						end
						if Possible == true then
							table.insert(AllIDs, ID)
							task.wait()
							pcall(
								function()
									writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
									task.wait()
									local args = {
										[1] = "teleport",
										[2] = ID
									}

									game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(unpack(args))
								end
							)
							task.wait(0.5)
						end
					end
				end
			end

			function Teleport()
				while task.wait() do
					pcall(
						function()
							TPReturner()
							if foundAnything ~= "" then
								TPReturner()
							end
						end
					)
				end
			end

			Teleport()
		else
          StatusFarm:Set({
                ["Title"] = "Status Farm",
                ["Content"] = "Wait Hop ( Anti 268 )"
            })  
		end
	end
end

function ServerFunc:NormalTeleport() 
	if isPrivate == false and not BlockAllHop then 
		if os.time() > tonumber(readfile("a_temp/268.txt")) then 
            StatusFarm:Set({
                ["Title"] = "Status Farm",
                ["Content"] = "Server Hop"
            })  
			local PlaceID = game.PlaceId
			local AllIDs = {}
			local foundAnything = ""
			local actualHour = os.date("!*t").hour
			local Deleted = false
			local File =
				pcall(
					function()
						AllIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
					end
				)
			if not File then
				table.insert(AllIDs, actualHour)
				writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
			end
			function TPReturner()
				local Site
				if foundAnything == "" then
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
							)
						)
				else
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" ..
								PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything
							)
						)
				end
				local ID = ""
				if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
					foundAnything = Site.nextPageCursor
				end
				local num = 0
				for i, v in pairs(Site.data) do
					local Possible = true
					ID = tostring(v.id)
					if tonumber(v.maxPlayers) > tonumber(v.playing) then
						for _, Existin
