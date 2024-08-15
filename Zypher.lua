local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

function HighlightPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            local highlight = Instance.new("Highlight")
            highlight.Adornee = character.HumanoidRootPart
            highlight.FillColor = Color3.new(1, 1, 0) -- Adjust color as desired
            highlight.Parent = character

            -- Create a text label for player name
            local nameLabel = Instance.new("BillboardGui")
            nameLabel.Adornee = character.HumanoidRootPart
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.StudsOffset = Vector3.new(0, 3, 0)

            local text = Instance.new("TextLabel")
            text.Parent = nameLabel
            text.Text = player.Name
            text.Size = UDim2.new(1, 0, 1, 0)
            text.TextWrapped = true
            text.BackgroundColor = Color3.new(0, 0, 0, 0.5)
            text.TextColor = Color3.new(1, 1, 1)
            text.FontSize = Enum.FontSize.Size18
        end
    end
end

function AimAtNearestPlayer()
    local closestPlayer, closestDistance = nil, math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local distance = (humanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestPlayer = player
                    closestDistance = distance
                end
            end
        end
    end

    if closestPlayer then
        local character = closestPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, character.HumanoidRootPart.Position)
        end
    end
end

HighlightPlayers()
RunService.Heartbeat:Connect(AimAtNearestPlayer)

