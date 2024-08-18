local plrs = game.Players
local lp = plrs.LocalPlayer

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = lp.PlayerGui
local function MakeDraggable(topbarobject, object)
	local function CustomPos(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function UpdatePos(input)
			local Delta = input.Position - DragStart
			local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end

		topbarobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		topbarobject.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				UpdatePos(input)
			end
		end)
	end
	local function CustomSize(object)
		local Dragging = false
		local DragInput = nil
		local DragStart = nil
		local StartSize = nil
		local maxSizeX = object.Size.X.Offset
		local maxSizeY = object.Size.Y.Offset
		object.Size = UDim2.new(0, maxSizeX, 0, maxSizeY)
		local changesizeobject = Instance.new("Frame");

		changesizeobject.AnchorPoint = Vector2.new(1, 1)
		changesizeobject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		changesizeobject.BackgroundTransparency = 0.9990000128746033
		changesizeobject.BorderColor3 = Color3.fromRGB(0, 0, 0)
		changesizeobject.BorderSizePixel = 0
		changesizeobject.Position = UDim2.new (0.0199410655, 0, 0.0274442546, 0)
		changesizeobject.Size = UDim2.new(0, 40, 0, 40)
		changesizeobject.Name = "changesizeobject"
		changesizeobject.Parent = object

		local function UpdateSize(input)
			local Delta = input.Position - DragStart
			local newWidth = StartSize.X.Offset + Delta.X
			local newHeight = StartSize.Y.Offset + Delta.Y
			newWidth = math.max(newWidth, maxSizeX)
			newHeight = math.max(newHeight, maxSizeY)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Size = UDim2.new(0, newWidth, 0, newHeight)})
			Tween:Play()
		end

		changesizeobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartSize = object.Size
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		changesizeobject.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				UpdateSize(input)
			end
		end)
	end
	CustomSize(object)
	CustomPos(topbarobject, object)
end
local ClickGui = Instance.new("ScreenGui");
local ClickFrame = Instance.new("Frame");

ClickGui.DisplayOrder = 10
ClickGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ClickGui.Name = "ClickGui"
ClickGui.Parent = CoreGui

ClickFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickFrame.BackgroundTransparency = 0.9990000128746033
ClickFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ClickFrame.BorderSizePixel = 0
ClickFrame.Size = UDim2.new(0, 30, 0, 30)
ClickFrame.ZIndex = 0
ClickFrame.Name = "ClickFrame"
ClickFrame.Parent = ClickGui

function CircleClick(ClickFrame, X, Y)
	spawn(function()
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://18996826249"
		Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Circle.ImageTransparency = 0.8
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = ClickFrame

		ClickFrame.Position = UDim2.new (0.120833337, 0, 0.0952890813, 0)

		local NewX = X - Circle.AbsolutePosition.X
		local NewY = Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)
		local Size = 0
		if ClickFrame.AbsoluteSize.X > ClickFrame.AbsoluteSize.Y then
			Size = ClickFrame.AbsoluteSize.X*1.5
		elseif ClickFrame.AbsoluteSize.X < ClickFrame.AbsoluteSize.Y then
			Size = ClickFrame.AbsoluteSize.Y*1.5
		elseif ClickFrame.AbsoluteSize.X == ClickFrame.AbsoluteSize.Y then
			Size = ClickFrame.AbsoluteSize.X*1.5
		end

		local Time = 0.2
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
		for i=1,10 do
			Circle.ImageTransparency = Circle.ImageTransparency + 0.02
			task.wait(Time/10)
		end
		Circle:Destroy()
	end)
end
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Mouse = game.Players.LocalPlayer:GetMouse()
		CircleClick(ClickFrame, Mouse.X, Mouse.Y)
	end
end)
local function UpSize(Scroll)
	local OffsetY = 0
	for _, child in Scroll:GetChildren() do
		if child.Name ~= "UIListLayout" then
			OffsetY = OffsetY + Scroll.UIListLayout.Padding.Offset + child.Size.Y.Offset
		end
	end
	Scroll.CanvasSize = UDim2.new(0, 0, 0, OffsetY)
end
local function AutoUp(Scroll)
	Scroll.ChildAdded:Connect(function()
		UpSize(Scroll)
	end)
	Scroll.ChildRemoved:Connect(function()
		UpSize(Scroll)
	end)
end
local function EnterMouse(frameenter)
	local old = frameenter.BackgroundColor3
	local oldfunc = {}
	if old == Color3.fromRGB(255, 255, 255) then
		local oldtrans = frameenter.BackgroundTransparency
		frameenter.MouseEnter:Connect(function()
			TweenService:Create(
				frameenter,
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = frameenter.BackgroundTransparency - 0.035}
			):Play()
		end)
		frameenter.MouseLeave:Connect(function()
			TweenService:Create(
				frameenter,
				TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = oldtrans}
			):Play()
		end)
	else
		frameenter.MouseEnter:Connect(function()
			TweenService:Create(
				frameenter,
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB((old.R * 255) + 8, (old.G * 255) + 8, (old.B * 255) + 8)}
			):Play()
		end)
		frameenter.MouseLeave:Connect(function()
			TweenService:Create(
				frameenter,
				TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = old}
			):Play()
		end)
	end
end
local sitinklib = {}
function sitinklib:Notify(NotifyConfig)
	local NotifyConfig = NotifyConfig or {}
	NotifyConfig.Title = NotifyConfig.Title or "sitink Hub"
	NotifyConfig.Description = NotifyConfig.Description or ""
	NotifyConfig.Content = NotifyConfig.Content or ""
	NotifyConfig["Color"] = NotifyConfig["Color"] or Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038)
	NotifyConfig.Time = NotifyConfig.Time or 0.5
	NotifyConfig.Delay = NotifyConfig.Delay or 5
	local NotifyFunc = {}
	spawn(function()
		if not CoreGui:FindFirstChild("NotifyGui") then
			local NotifyGui = Instance.new("ScreenGui");
			NotifyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			NotifyGui.Name = "NotifyGui"
			NotifyGui.Parent = CoreGui
		end
		if not CoreGui.NotifyGui:FindFirstChild("NotifyLayout") then
			local NotifyLayout = Instance.new("Frame");

			NotifyLayout.AnchorPoint = Vector2.new(1, 1)
			NotifyLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NotifyLayout.BackgroundTransparency = 0.9990000128746033
			NotifyLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyLayout.BorderSizePixel = 0
			NotifyLayout.Position = UDim2.new(1, -30, 1, -30)
			NotifyLayout.Size = UDim2.new(0, 300, 1, -30)
			NotifyLayout.Name = "NotifyLayout"
			NotifyLayout.Parent = CoreGui.NotifyGui

			local Count = 0
			CoreGui.NotifyGui.NotifyLayout.ChildRemoved:Connect(function()
				Count = 0
				for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
					TweenService:Create(
						v,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
						{Position = UDim2.new(0, 0, 1, -((v.Size.Y.Offset + 12)*Count))}
					):Play()
					Count = Count + 1
				end
			end)
		end
		local NotifyPosHeigh = 0
		for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
			NotifyPosHeigh = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
		end
		local NotifyFrame = Instance.new("Frame");
		local NotifyFrameReal = Instance.new("Frame");
		local UICorner = Instance.new("UICorner");
		local DropShadowHolder = Instance.new("Frame");
		local DropShadow = Instance.new("ImageLabel");
		local NotifyContent = Instance.new("TextLabel");
		local Top = Instance.new("Frame");
		local NotifyTitle = Instance.new("TextLabel");
		local NotifyDescription = Instance.new("TextLabel");
		local NotifyClose = Instance.new("TextButton");
		local NotifyCloseImage = Instance.new("ImageLabel");

		NotifyFrame.AnchorPoint = Vector2.new(0, 1)
		NotifyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrame.BackgroundTransparency = 1
		NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrame.BorderSizePixel = 0
		NotifyFrame.Position = UDim2.new(0, 0, 1, -(NotifyPosHeigh))
		NotifyFrame.Size = UDim2.new(1, 0, 0, 65)
		NotifyFrame.Name = "NotifyFrame"
		NotifyFrame.Parent = CoreGui.NotifyGui.NotifyLayout

		NotifyFrameReal.BackgroundColor3 = Color3.fromRGB(45.00000111758709, 45.00000111758709, 45.00000111758709)
		NotifyFrameReal.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrameReal.BorderSizePixel = 0
		NotifyFrameReal.Position = UDim2.new(0, 330, 0, 0)
		NotifyFrameReal.Size = UDim2.new(1, 0, 1, 0)
		NotifyFrameReal.Name = "NotifyFrameReal"
		NotifyFrameReal.Parent = NotifyFrame

		UICorner.Parent = NotifyFrameReal
		UICorner.CornerRadius = UDim.new(0, 5)

		DropShadowHolder.BackgroundTransparency = 1
		DropShadowHolder.BorderSizePixel = 0
		DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
		DropShadowHolder.ZIndex = 0
		DropShadowHolder.Name = "DropShadowHolder"
		DropShadowHolder.Parent = NotifyFrameReal

		DropShadow.Image = "rbxassetid://18996826249"
		DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropShadow.ImageTransparency = 0.5
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 47, 1, 47)
		DropShadow.ZIndex = 0
		DropShadow.Name = "DropShadow"
		DropShadow.Parent = DropShadowHolder

		NotifyContent.Font = Enum.Font.GothamBold
		NotifyContent.Text = NotifyConfig.Content
		NotifyContent.TextColor3 = Color3.fromRGB(140.00000685453415, 140.00000685453415, 140.00000685453415)
		NotifyContent.TextSize = 13
		NotifyContent.TextXAlignment = Enum.TextXAlignment.Left
		NotifyContent.TextYAlignment = Enum.TextYAlignment.Top
		NotifyContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.BackgroundTransparency = 0.9990000128746033
		NotifyContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyContent.BorderSizePixel = 0
		NotifyContent.Position = UDim2.new(0, 12, 0, 27)
		NotifyContent.Size = UDim2.new(1, -24, 0, 13)
		NotifyContent.Name = "NotifyContent"
		NotifyContent.Parent = NotifyFrameReal

		Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Top.BackgroundTransparency = 0.9990000128746033
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 0
		Top.Size = UDim2.new(1, 0, 0, 34)
		Top.Name = "Top"
		Top.Parent = NotifyFrameReal

		NotifyTitle.Font = Enum.Font.GothamBold
		NotifyTitle.Text = NotifyConfig.Title
		NotifyTitle.TextColor3 = NotifyConfig.Color
		NotifyTitle.TextSize = 14
		NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left
		NotifyTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyTitle.BackgroundTransparency = 0.9990000128746033
		NotifyTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyTitle.BorderSizePixel = 0
		NotifyTitle.Position = UDim2.new(0, 12, 0, 10)
		NotifyTitle.Size = UDim2.new(0, 0, 0, 14)
		NotifyTitle.Name = "NotifyTitle"
		NotifyTitle.Parent = Top

		NotifyDescription.Font = Enum.Font.GothamBold
		NotifyDescription.Text = NotifyConfig.Description
		NotifyDescription.TextColor3 = Color3.fromRGB(230.00000149011612, 230.00000149011612, 230.00000149011612)
		NotifyDescription.TextSize = 14
		NotifyDescription.TextXAlignment = Enum.TextXAlignment.Left
		NotifyDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyDescription.BackgroundTransparency = 0.9990000128746033
		NotifyDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyDescription.BorderSizePixel = 0
		NotifyDescription.Position = UDim2.new(0, 16 + NotifyTitle.TextBounds.X, 0, 10)
		NotifyDescription.Size = UDim2.new(0, 0, 0, 14)
		NotifyDescription.Name = "NotifyDescription"
		NotifyDescription.Parent = Top

		NotifyClose.Font = Enum.Font.SourceSans
		NotifyClose.Text = ""
		NotifyClose.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotifyClose.TextSize = 14
		NotifyClose.AnchorPoint = Vector2.new(1, 0)
		NotifyClose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyClose.BackgroundTransparency = 0.9990000128746033
		NotifyClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyClose.BorderSizePixel = 0
		NotifyClose.Position = UDim2.new(1, 0, 0, 0)
		NotifyClose.Size = UDim2.new(0, 34, 0, 34)
		NotifyClose.Name = "NotifyClose"
		NotifyClose.Parent = Top

		NotifyCloseImage.Image = "rbxassetid://18328658828"
		NotifyCloseImage.AnchorPoint = Vector2.new(0.5, 0.5)
		NotifyCloseImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyCloseImage.BackgroundTransparency = 0.9990000128746033
		NotifyCloseImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyCloseImage.BorderSizePixel = 0
		NotifyCloseImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		NotifyCloseImage.Size = UDim2.new(1, -15, 1, -15)
		NotifyCloseImage.Name = "NotifyCloseImage"
		NotifyCloseImage.Parent = NotifyClose

		NotifyContent.Size = UDim2.new(1, -24, 0, 13 + (13 * (NotifyContent.TextBounds.X // NotifyContent.AbsoluteSize.X)))
		NotifyContent.TextWrapped = true

		if NotifyContent.AbsoluteSize.Y < 27 then
			NotifyFrame.Size = UDim2.new(1, 0, 0, 65)
		else
			NotifyFrame.Size = UDim2.new(1, 0, 0, NotifyContent.AbsoluteSize.Y + 40)
		end
		if NotifyContent.Text == "" then
			DropShadow.Size = UDim2.new(1, 30, 1, 30)
			NotifyFrame.Size = UDim2.new(1, 0, 0, 35)
		end
		local waitbruh = false
		function NotifyFunc:Close()
			if waitbruh then
				return false
			end
			waitbruh = true
			TweenService:Create(
				NotifyFrameReal,
				TweenInfo.new(tonumber(NotifyConfig.Time), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0, 330, 0, 0)}
			):Play()
			task.wait(tonumber(NotifyConfig.Time) / 1.2)
			NotifyFrame:Destroy()
		end
		NotifyClose.Activated:Connect(function()
			NotifyFunc:Close()
		end)
		TweenService:Create(
			NotifyFrameReal,
			TweenInfo.new(tonumber(NotifyConfig.Time), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Position = UDim2.new(0, 0, 0, 0)}
		):Play()
		task.wait(tonumber(NotifyConfig.Delay))
		NotifyFunc:Close()
	end)
end
function sitinklib:Start(GuiConfig)
	local GuiConfig = GuiConfig or {}
	GuiConfig.Name = GuiConfig.Name or "sitink Hub"
	GuiConfig.Description = GuiConfig.Description or ""
	GuiConfig["Info Color"] = GuiConfig["Info Color"] or Color3.fromRGB(5.000000176951289, 59.00000028312206, 113.00000086426735)
	GuiConfig["Logo Info"] = GuiConfig["Logo Info"] or "rbxassetid://18996826249"
	GuiConfig["Logo Player"] = GuiConfig["Logo Player"] or "https://www.roblox.com/headshot-thumbnail/image?userId="..game:GetService("Players").LocalPlayer.UserId .."&width=420&height=420&format=png"
	GuiConfig["Name Info"] = GuiConfig["Name Info"] or "sitink Hub Info"
	GuiConfig["Name Player"] = GuiConfig["Name Player"] or tostring(game:GetService("Players").LocalPlayer.Name)
	GuiConfig["Info Description"] = GuiConfig["Info Description"] or "discord.gg/3Aatp4Nhjp"
	GuiConfig["Tab Width"] = GuiConfig["Tab Width"] or 135
	GuiConfig["Color"] = GuiConfig["Color"] or Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038)
	GuiConfig["CloseCallBack"] = GuiConfig["CloseCallBack"] or function() end
	--// Gui
	local SitinkGui = Instance.new("ScreenGui");
	local Main = Instance.new("Frame");
	local UICorner = Instance.new("UICorner");
	local Top = Instance.new("Frame");
	local TopTitle = Instance.new("TextLabel");
	local TopDescription = Instance.new("TextLabel");
	local CloseButton = Instance.new("TextButton");
	local CloseImage = Instance.new("ImageLabel");
	local DropShadowHolder = Instance.new("Frame");
	local DropShadow = Instance.new("ImageLabel");

	SitinkGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SitinkGui.Name = "SitinkGui"
	SitinkGui.Parent = CoreGui

	Main.AnchorPoint = Vector2.new(0, 0)
	Main.BackgroundColor3 = Color3.fromRGB(45.00000111758709, 45.00000111758709, 45.00000111758709)
	Main.BackgroundTransparency = 0
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Size = UDim2.new(0, 500, 0, 300)
	Main.Name = "Main"
	Main.Parent = SitinkGui
	Main.Position = UDim2.new (0.120833337, 0, 0.0952890813, 0)

	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Main

	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 0.9990000128746033
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 34)
	Top.Name = "Top"
	Top.Parent = Main

	TopTitle.Font = Enum.Font.GothamBold
	TopTitle.Text = GuiConfig.Name
	TopTitle.TextColor3 = GuiConfig.Color
	TopTitle.TextSize = 14
	TopTitle.TextXAlignment = Enum.TextXAlignment.Left
	TopTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopTitle.BackgroundTransparency = 0.9990000128746033
	TopTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopTitle.BorderSizePixel = 0
	TopTitle.Position = UDim2.new(0, 12, 0, 10)
	TopTitle.Size = UDim2.new(0, 0, 0, 14)
	TopTitle.Name = "TopTitle"
	TopTitle.Parent = Top

	TopDescription.Font = Enum.Font.GothamBold
	TopDescription.Text = GuiConfig.Description
	TopDescription.TextColor3 = Color3.fromRGB(230.00000149011612, 230.00000149011612, 230.00000149011612)
	TopDescription.TextSize = 14
	TopDescription.TextXAlignment = Enum.TextXAlignment.Left
	TopDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopDescription.BackgroundTransparency = 0.9990000128746033
	TopDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopDescription.BorderSizePixel = 0
	TopDescription.Position = UDim2.new(0, 16 + TopTitle.TextBounds.X, 0, 10)
	TopDescription.Size = UDim2.new(0, 0, 0, 14)
	TopDescription.Name = "TopDescription"
	TopDescription.Parent = Top

	CloseButton.Font = Enum.Font.SourceSans
	CloseButton.Text = ""
	CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.TextSize = 14
	CloseButton.AnchorPoint = Vector2.new(1, 0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 0.9990000128746033
	CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Position = UDim2.new(1, 0, 0, 0)
	CloseButton.Size = UDim2.new(0, 34, 0, 34)
	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Top

	CloseIma
