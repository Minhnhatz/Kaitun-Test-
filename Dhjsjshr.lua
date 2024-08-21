skid cái lồn t phá code r
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
