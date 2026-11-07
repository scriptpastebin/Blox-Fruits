loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/Blox-Fruits/refs/heads/main/core.luau"))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloxfruitsnokey/Arcylic/refs/heads/main/ARC/ui.luau"))()
local Window = Library.new("ARC Hub : discord.gg/pKS6qzcaqB", "by @ARC")
Window:SetToggleKey(Enum.KeyCode.RightControl)

local MainSection = Window:CreateSection("Main")
local Tabs = {
    Info = MainSection:CreateTab("Info And Status", "rbxassetid://10723415903"),
    Main = MainSection:CreateTab("Farming", "rbxassetid://7733960981"),
    Settings = MainSection:CreateTab("Setting", "rbxassetid://7734053495"),
    Fish = MainSection:CreateTab("Fishing", "rbxassetid://127664059821666"),
    Quests = MainSection:CreateTab("Quest And Item", "rbxassetid://13075622619"),
    SeaEvent = MainSection:CreateTab("Sea Event", "rbxassetid://10747376931"),
    Prehistoric = MainSection:CreateTab("Volcano Event", "rbxassetid://10734981750"),
    Race = MainSection:CreateTab("Mirage And Race", "rbxassetid://11162889532"),
    Esp = MainSection:CreateTab("Stats And Esp", "rbxassetid://7040410130"),
    Raids = MainSection:CreateTab("Fruit And Raid", "rbxassetid://11155986081"),
    Combat = MainSection:CreateTab("Local Player", "rbxassetid://13075651575"),
    Travel = MainSection:CreateTab("Teleport", "rbxassetid://10723434557"),
    Shop = MainSection:CreateTab("Shopping", "rbxassetid://6031265976"),
    Misc = MainSection:CreateTab("Miscellaneous", "rbxassetid://10709783577")
}

local SettingsSection = Window:CreateSection("Settings")
local ConfigTab = SettingsSection:CreateTab("Config", "rbxassetid://10734898355")
ConfigTab:CreateConfigSection()

-- ====================================================================
-- TAB: INFO AND STATUS
-- ====================================================================
Tabs.Info:CreateSection("Status Server")
local GameTime = Tabs.Info:CreateParagraph({Title = "Game Time", Content = ""})
-- Game Time
function UpdateGameTime()
    local GameTimeValue = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTimeValue / (60^2)) % 24
    local Minute = math.floor(GameTimeValue / (60^1)) % 60
    local Second = math.floor(GameTimeValue / (60^0)) % 60
    GameTime:SetContent(Hour.." Hour (h) "..Minute.." Minute (m) "..Second.." Second (s)")
end

spawn(function()
    while true do
        UpdateGameTime()
        wait(1)
    end
end)

-- Mirage Island
local MirageCheck = Tabs.Info:CreateParagraph({Title = "Mirage Island", Content = "Status: "})
local previousMirageStatus = ""
spawn(function()
    pcall(function()
        while true do
            wait(1)            
            local mirageIslandExists = game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') ~= nil
            local currentStatus = mirageIslandExists and '✅' or '❌'
            if currentStatus ~= previousMirageStatus then
                MirageCheck:SetContent('Status: ' .. currentStatus)
                previousMirageStatus = currentStatus
            end
        end
    end)
end)

-- Kitsune Island
local KitsuneCheck = Tabs.Info:CreateParagraph({Title = "Kitsune Island", Content = "Status: "})
local previousKitsuneStatus = ""
spawn(function()
    while task.wait(1) do
        pcall(function()
        local currentStatus = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and '✅' or '❌'
        if currentStatus ~= previousKitsuneStatus then
            KitsuneCheck:SetContent('Status: ' .. currentStatus)
            previousKitsuneStatus = currentStatus
        end
        end)
    end
end)

-- Prehistoric Island
local PrehistoricCheck = Tabs.Info:CreateParagraph({Title = "Prehistoric Island", Content = "Status: "})
local previousPrehistoricStatus = ""
task.spawn(function()
    while task.wait(1) do
        pcall(function()
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and '✅' or '❌'
        if currentStatus ~= previousPrehistoricStatus then
            PrehistoricCheck:SetContent("Status: " .. currentStatus)
            previousPrehistoricStatus = currentStatus
        end
        end)
    end
end)

-- Frozen Dimension
local FrozenCheck = Tabs.Info:CreateParagraph({Title = "Frozen Dimension", Content = "Status: "})
local previousFrozenStatus = ""
spawn(function()
    while wait(1) do
        pcall(function()
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and '✅' or '❌'
        if currentStatus ~= previousFrozenStatus then
            FrozenCheck:SetContent('Status: ' .. currentStatus)
            previousFrozenStatus = currentStatus
        end
        end)
    end
end)

-- Rip Indra
local RipIndraCheck = Tabs.Info:CreateParagraph({Title = "Rip Indra", Content = "Status: "})
local previousRipStatus = ""
spawn(function()
    while wait(1) do
        pcall(function()
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and '✅' or '❌'
        if currentStatus ~= previousRipStatus then
            RipIndraCheck:SetContent("Status: " .. currentStatus)
            previousRipStatus = currentStatus
        end
        end)
    end
end)

-- Dough King
local DoughKingCheck = Tabs.Info:CreateParagraph({Title = "Dough King", Content = "Status: "})
local previousDoughStatus = ""
spawn(function()
    while wait(1) do
        pcall(function()
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and '✅' or '❌'
        if currentStatus ~= previousDoughStatus then
            DoughKingCheck:SetContent("Status: " .. currentStatus)
            previousDoughStatus = currentStatus
        end
        end)
    end
end)

-- Full Moon
local FullMoonCheck = Tabs.Info:CreateParagraph({Title = "Full Moon", Content = ""})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
        local moonTextureId = game:GetService("Lighting").Sky.MoonTextureId
        local moonStatus = "Moon: 0/5"
        
        if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
            moonStatus = "Moon: 5/5 (Full Moon) ✅"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
            moonStatus = "Moon: 4/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
            moonStatus = "Moon: 3/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
            moonStatus = "Moon: 2/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
            moonStatus = "Moon: 1/5"
        end
        
        FullMoonCheck:SetContent(moonStatus)
        end)
    end
end)

-- Legendary Sword
local LegendarySwordCheck = Tabs.Info:CreateParagraph({Title = "Legendary Sword", Content = "Status: "})
spawn(function()
    while wait(5) do
        pcall(function()
            local owned = {}
            for _, name in ipairs({"Shizu", "Saishi", "Oroshi"}) do
                if GetWP(name) then table.insert(owned, name .. " ✅") end
            end
            LegendarySwordCheck:SetContent(#owned > 0 and table.concat(owned, ", ") or "Not Found")
        end)
    end
end)

-- Cake Prince
local CakePrinceStatus = Tabs.Info:CreateParagraph({Title = "Cake Prince", Content = ""})
spawn(function()
    while wait(1) do
        local okCP, cakePrince = pcall(function() return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner") end)
        local killStatus = "Cake Prince: ✅"
        if okCP and type(cakePrince) == "string" and string.len(cakePrince) >= 86 then
            local killCount = string.sub(cakePrince, 39, 41)
            killStatus = "Killed: " .. killCount
        end
        CakePrinceStatus:SetContent(killStatus)
    end
end)

-- Bone
local BoneCount = Tabs.Info:CreateParagraph({Title = "Bone", Content = ""})
spawn(function()
    while wait(1) do
        pcall(function()
        local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
        BoneCount:SetContent("You Have: " .. tostring(bones) .. " Bones")
        end)
    end
end)




-- ====================================================================
-- TAB: FARMING
-- ====================================================================
-- Select Weapon
local RFSubmarineWorkerSpeak = replicated.Modules.Net["RF/SubmarineWorkerSpeak"]
WeaponDropdown = Tabs.Main:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "Melee",
    Callback = function(Value)
    _G.ChooseWP = Value
end})


-- =================
-- Farming (Level, Nearest, Factory Raid, Pirate Raid, Ectoplasm)
-- =================
Tabs.Main:CreateSection("Farming")
FarmLevel = Tabs.Main:CreateToggle({
    Name = "Auto Farm Level",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Level = Value
        if not Value then
            alreadyTeleported = false
            teleporting = false
        end
    end
})
local alreadyTeleported = false
local teleporting = false

ClosetMons = Tabs.Main:CreateToggle({
Name = "Auto Farm Nearest",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoFarmNear = Value
end})

FactoryRaids = Tabs.Main:CreateToggle({
Name = "Auto Factory Raid",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoFactory = Value
end})

CastleRaids = Tabs.Main:CreateToggle({
Name = "Auto Pirate Raid",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoRaidCastle = Value
end})

Ecto = Tabs.Main:CreateToggle({
Name = "Auto Farm Ectoplasm",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoEctoplasm = Value
end})

-- =================
-- Chest
-- =================
Tabs.Main:CreateSection("Chest")
ChestTW = Tabs.Main:CreateToggle({
Name = "Auto Farm Chest",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoFarmChest = Value
end})

ChestBP = Tabs.Main:CreateToggle({
    Name = "Auto Chest Bypass",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoChestBP = Value

        if Value then
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local IsFarming = false
            local UncheckedChests = {}
            local FirstRun = true

            local function getCharacter()
                if not LocalPlayer.Character then
                    LocalPlayer.CharacterAdded:Wait()
                end
                LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                return LocalPlayer.Character
            end

            local function getChestsSorted()
                if FirstRun then
                    FirstRun = false
                    for _, Object in pairs(game:GetDescendants()) do
                        if Object.Name:find("Chest") and Object.ClassName == "Part" then
                            table.insert(UncheckedChests, Object)
                        end
                    end
                end

                local Chests = {}
                for _, Chest in pairs(UncheckedChests) do
                    if Chest:FindFirstChild("TouchInterest") then
                        table.insert(Chests, Chest)
                    end
                end

                local RootPart = getCharacter().LowerTorso
                table.sort(Chests, function(a, b)
                    return (RootPart.Position - a.Position).Magnitude < (RootPart.Position - b.Position).Magnitude
                end)
                return Chests
            end

            local function runChestLoop()
                if IsFarming then return end
                IsFarming = true

                task.spawn(function()
                    while _G.AutoChestBP and LocalPlayer.Character and LocalPlayer.Character.Parent do
                        local Chests = getChestsSorted()
                        if #Chests > 0 then
                            local RootPart = getCharacter().HumanoidRootPart
                            RootPart.CFrame = Chests[1].CFrame
                        end
                        task.wait(0.1)
                    end
                    IsFarming = false
                end)
            end

            LocalPlayer.CharacterAdded:Connect(function()
                getCharacter()
                task.wait(0.5)
                if _G.AutoChestBP then
                    runChestLoop()
                end
            end)

            runChestLoop()
        end
    end
})

StopI = Tabs.Main:CreateToggle({
Name = "Stop Farm for FOD & Chalice",
Description = "",
Default = true,
Callback = function(Value)
    _G.StopWhenChalice = Value
end})

-- =================
-- Berry
-- =================
Tabs.Main:CreateSection("Berry")
Berry = Tabs.Main:CreateToggle({
Name = "Auto Farm Berry",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoBerry = Value
end})

BerryH = Tabs.Main:CreateToggle({
Name = "Auto Farm Berry + Hop",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoBerryH = Value
end})

-- =================
-- Farm Mob
-- =================
Tabs.Main:CreateSection("Farm Mob")
if World1 then
    Tabs.Main:CreateDropdown({
        Name = "Select Mob",
        Default = Bandit,
        Options = {
            "Bandit", "Monkey", "Gorilla", "Pirate", "Brute",
            "Desert Bandit", "Desert Officer", "Snow Bandit", "Snowman",
            "Chief Petty Officer", "Sky Bandit", "Dark Master", "Toga Warrior",
            "Gladiator", "Military Soldier", "Military Spy",
            "Fishman Warrior", "Fishman Commando",
            "God's Guard", "Shanda", "Royal Squad", "Royal Soldier",
            "Galley Pirate", "Galley Captain",
        },
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end
if World2 then
    Tabs.Main:CreateDropdown({
        Name = "Select Mob",
        Default = Raider,
        Options = {
            "Raider", "Mercenary", "Swan Pirate", "Factory Staff",
            "Marine Lieutenant", "Marine Captain", "Zombie", "Vampire",
            "Snow Trooper", "Winter Warrior", "Lab Subordinate",
            "Horned Warrior", "Magma Ninja", "Lava Pirate",
            "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer",
            "ARCtic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter",
        },
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end
if World3 then
    Tabs.Main:CreateDropdown({
        Name = "Select Mob",
        Options = {
            "Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew ARCher",
            "Female Islander", "Giant Islander", "Marine Commodore",
            "Marine Rear Admiral", "Fishman Raider", "Fishman Captain",
            "Forest Pirate", "Mythological Pirate", "Jungle Pirate",
            "Musketeer Pirate", "Reborn Skeleton", "Living Zombie",
            "Demonic Soul", "Posessed Mummy", "Peanut Scout",
            "Peanut President", "Ice Cream Chef", "Ice Cream Commander",
            "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker",
            "Cocoa Warrior", "Chocolate Bar Battler", "Sweet Thief",
            "Candy Rebel", "Candy Pirate", "Snow Demon", "Isle Outlaw",
            "Island Boy", "Sun-kissed Warrior", "Isle Champion",
        },
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end

Tabs.Main:CreateToggle({
    Name = "Auto Farm Mob",
    Default = false,
    Callback = function(Value)
        _G.AutoKillMob = Value
    end
})

-- =================
-- All Island
-- =================
Tabs.Main:CreateSection("Farm Island")
Tabs.Main:CreateDropdown({
    Name = "Select Island",
    Options = (function()
        local list = {}
        for k in pairs(Core.Island or {}) do table.insert(list, k) end
        table.sort(list)
        return list
    end)(),
    Callback = function(Value)
        _G.SelectIsland = Value
    end
})
local IslandData = Core.Island

Tabs.Main:CreateToggle({
    Name = "Auto Farm Island",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmIsland = Value
    end
})

-- =================
-- Elit Hunter
-- =================
Tabs.Main:CreateSection("Elite Hunter")

local EliteHunter = Tabs.Main:CreateParagraph({Title = "Elite Spawn", Content = "Status: "})
spawn(function()
    local previousStatus = ""
    while wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or 
                               game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or 
                               game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '✅' or '❌'
        local ok, progress = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
        end)
        local progressStr = tostring((ok and progress) or 0)
        if currentStatus ~= previousStatus then
            EliteHunter:SetContent("Status: " .. currentStatus .. " | Killed: " .. progressStr)
            previousStatus = currentStatus
        end
    end
end)

EliteQ = Tabs.Main:CreateToggle({
    Name = "Auto Farm Elite Hunter",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.FarmEliteHunt = Value
end})

EliteH = Tabs.Main:CreateToggle({
	Name = "Auto Farm Elite Hunter + Hop",
	Description = "",
	Default = false,
	Callback = function(Value)
	_G.FarmEliteH = Value
end})

-- =================
-- Rip Indra (Rip Indra, Unlock Haki)
-- =================
Tabs.Main:CreateSection("Rip Indra")
Tabs.Main:CreateToggle({
Name = "Auto Farm Rip Indra",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoRipIngay = Value
end})

Tabs.Main:CreateToggle({
Name = "Auto Unlocked Haki",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoUnHaki = Value
end})

Tabs.Main:CreateSection("Cake Prince")
local MobKilled = Tabs.Main:CreateParagraph({Title = "Cake Princes", Content = ""})
spawn(function()
    while wait(0.2) do
        pcall(function()
            local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
            if Killed then
                MobKilled:SetContent("Killed : " .. (500 - tonumber(Killed) or 0))
            end
        end)
    end
end)

-- =================
-- Cake Prince (Cake Prince, Dough King)
-- =================
Cake = Tabs.Main:CreateToggle({
    Name = "Auto Farm Cake Prince",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.Auto_Cake_Prince = Value
end
})

CakeQ = Tabs.Main:CreateToggle({
Name = "Accept Quests",
Description = "",
Default = false,
Callback = function(Value)
  _G.AcceptQuestC = Value
end
})

CakeSM = Tabs.Main:CreateToggle({
    Name = "Auto Summon Cake Prince",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoSpawnCP = Value
end})

Tabs.Main:CreateToggle({
    Name = "Auto Farm Dough King",
    Default = false,
    Callback = function(Value)
        _G.AutoAttackDoughKing = Value
    end
})

Tabs.Main:CreateToggle({
    Name = "Auto Dough King Fully",
    Default = false,
    Callback = function(Value)
        _G.AutoDoughKing = Value
    end
})

Tabs.Main:CreateToggle({
    Name = "Auto Farm Dough King + Hop",
    Default = false,
    Callback = function(Value)
        _G.AutoHop_Dough = Value
    end
})

-- =================
-- Bone
-- =================
Tabs.Main:CreateSection("Bone")
local CheckingBone = Tabs.Main:CreateParagraph({Title = "Bones", Content = ""})
spawn(function()
    while wait(1) do
        pcall(function()
            local bonesCount = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            CheckingBone:SetContent("Bones : " .. tostring(bonesCount))
        end)
    end
end)

Tabs.Main:CreateToggle({
    Name = "Auto Farm Bone",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

BoneQ = Tabs.Main:CreateToggle({
Name = "Accept Quests",
Description = "",
Default = false,
Callback = function(Value)
  _G.AcceptQuestB = Value
end
})

Tabs.Main:CreateToggle({
Name = "Auto Soul Reaper",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoHytHallow = Value
end})

RanBone = Tabs.Main:CreateToggle({
Name = "Auto Random Bones",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Random_Bone = Value
end})

Lucky = Tabs.Main:CreateToggle({
Name = "Auto Try Luck Gravestone",
Description = "",
Default = false,
Callback = function(Value)
  _G.TryLucky = Value
end})

Pray = Tabs.Main:CreateToggle({
Name = "Auto Pray Gravestone",
Description = "",
Default = false,
Callback = function(Value)
  _G.Praying = Value
end})

-- =================
-- Tyrant of the Skies
-- =================
Tabs.Main:CreateSection("Tyrant of the Skies")
local TyrantStatus = Tabs.Main:CreateParagraph({Title = "Boss Spawn", Content = ""})
spawn(function()
    pcall(function()
        while wait(1) do
            if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetContent("✅")
            else
                TyrantStatus:SetContent("❌")
            end
        end
    end)
end)

local EyeStatus = Tabs.Main:CreateParagraph({Title = "Check Status Eyes", Content = ""})
task.spawn(function()
    local alerted = false
    while task.wait(1) do
        local okEye, current, full = pcall(Check_Eye)
        if okEye then
            EyeStatus:SetContent("Eyes: " .. current .. "/4")

            if full and not alerted then
                alerted = true
            elseif not full then
                alerted = false
            end
        end
    end
end)

FarmTyrant = Tabs.Main:CreateToggle({
Name = "Auto Farm Tyrant of the Skies",
Description = "",
Default = false,
Callback = function(Value) 
    _G.FarmTyrant = Value 
end})

FarmPhaBinh = Tabs.Main:CreateToggle({
Name = "Auto Summon Tyrant of the Skies",
Description = "",
Default = false,
Callback = function(Value)
    _G.FarmPhaBinh = Value
end})

-- =================
-- Materia
-- =================
Tabs.Main:CreateSection("Material")
Test = Tabs.Main:CreateDropdown({
Name = "Choose Material",
		Description = "",
		Options = MaterialList,
		Callback = function(Value)
			getgenv().SelectMaterial = Value
		end
		})

Toggle = Tabs.Main:CreateToggle({
Name = "Auto Farm Material",
Description = "",
Default = false,
Callback = function(Value)
    getgenv().AutoMaterial = Value
end})

-- =================
-- Boss
-- =================
Tabs.Main:CreateSection("Boss")
		BossDropdown = Tabs.Main:CreateDropdown({
		Name = "Select Boss",
		Description = "",
		Options = BossList,
		Callback = function(value)
			_G.FindBoss = value
		end
		})

FarmBoss = Tabs.Main:CreateToggle({
    Name = "Auto Farm Boss",
    Description = "",
    Default = false,
    Callback = function(value)
        _G.FarmBoss = value
    end
})

BossQ = Tabs.Main:CreateToggle({
    Name = "Accept Quests",
    Description = "",
    Default = true,
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

FarmAllBoss = Tabs.Main:CreateToggle({
   Name = "Auto Farm All Boss",
    Default = false,
Callback = function(Value)
    _G.AutoFarmAllBoss = Value
end})

-- =================
-- Mastery
-- =================
Tabs.Main:CreateSection("Mastery")
local posMastery = {"Cake","Bone"}
local Mastery_Config = Tabs.Main:CreateDropdown({
Name = "Choose Island",
		Description = "",
		Options = posMastery,
		Default = Bone,
		Callback = function(Value)
  SelectIsland = Value
end})

Tabs.Main:CreateSlider({
	Title = "NPC Health % Switch to Weapon",
	Description = "Switches to mastery weapon moves when NPC HP drops below this percent",
	Min = 10,
	Max = 95,
	Default = 70,
	Callback = function(Y)
		_G.MasteryHealthPct = Y;
	end,
});

Tabs.Main:CreateDropdown({
    Name = "Select Skills",
    Description = "Select which skills to spam (locked skills are auto-skipped)",
    Options = {"Z", "X", "C", "V", "F", "Y"},
    Default = {"Z", "X", "C", "V", "F"},
    MultiSelect = true,
    Callback = function(Value)
        _G.SelectedMasterySkills = Value
    end
})

local MasteryFruits = Tabs.Main:CreateToggle({
Name = "Auto Mastery Fruits",
Description = "",
Default = false,
Callback = function(Value)
  _G.FarmMastery_Dev = Value
end})

local MasteryGun = Tabs.Main:CreateToggle({
Name = "Auto Mastery Gun",
Description = "",
Default = false,
Callback = function(Value)
  _G.FarmMastery_G = Value
end})

local MasterySword = Tabs.Main:CreateToggle({
Name = "Auto Mastery All Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.FarmMastery_S = Value
end})




-- ====================================================================
-- TAB: SETTING
-- ====================================================================
Tabs.Settings:CreateSection("Setting")
Initialize = Tabs.Settings:CreateToggle({
Name = "Fast Attack",
Description = "",
Default = true,
Callback = function(Value)
  _G.Seriality = Value
end})

Bringmob = Tabs.Settings:CreateToggle({
Name = "Bring Mobs",
Description = "",
Default = true,
Callback = function(Value)
  _B = Value
end})

Tabs.Settings:CreateToggle({
    Name = "Auto Hop Server with time",
    Default = false,
    Callback = function(Value)
        _G.AutoHopServer = Value
        if not Value then
            _G.HopTimer = nil
        end
    end
})

Tabs.Settings:CreateSlider({
    Name = "Hop Delay (Minutes)",
    Min = 5,
    Max = 120,
    Default = 30,
    Increment = 1,
    Callback = function(Value)
        _G.HopDelay = Value * 60
    end
})

Tabs.Settings:CreateToggle({
    Name = "Auto Set Spawn Point",
    Default = false,
    Callback = function(Value)
        getgenv().Set = Value
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
})

BusuAura = Tabs.Settings:CreateToggle({
Name = "Auto Turn on Buso",
Description = "",
Default = true,
Callback = function(Value)
  Boud = Value
end})

Tabs.Settings:CreateToggle({
    Name = "Auto Haki Observation",
    Default = false,
    Callback = function(Value)
        getgenv().Observation = Value
    end
})

RaceV3Aura = Tabs.Settings:CreateToggle({
Name = "Auto Turn on Race V3",
Description = "",
Default = false,
Flag = "AutoTurnonRaceV3",
Callback = function(Value)
  _G.RaceClickAutov3 = Value
end})

RaceV4Aura = Tabs.Settings:CreateToggle({
Name = "Auto Turn on Race V4",
Description = "",
Default = false,
Callback = function(Value)
  _G.RaceClickAutov4 = Value
end})

RandomAround = Tabs.Settings:CreateToggle({
Name = "Auto Turn on Spin  xyz",
Description = "",
Default = false,
Callback = function(Value)
  RandomCFrame = Value
end})

SafeModes = Tabs.Settings:CreateToggle({
Name = "Safe Mode",
Description = "",
Default = false,
Callback = function(Value)
  _G.Safemode = Value
end})

DisableHitVFX = Tabs.Settings:CreateToggle({
    Name = "Remove Hit VFX",
    Description = "Removes slash and sword visual effects for better visibility",
    Default = false,
    Callback = function(Value)
        _G.DestroyHit = Value
    end
})
local HitEffects = {"SlashHit", "CurvedRing", "SwordSlash", "SlashTail"}

RmvVFX = Tabs.Settings:CreateToggle({
Name = "Remove Death & Respawned VFX",
Description = "",
Default = false,
Callback = function(Value)
  RDeath = Value
end})

DisblesNotify = Tabs.Settings:CreateToggle({
Name = "Disable Notify",
Description = "",
Default = false,
Callback = function(Value)
  RemoveDamage = Value
end})

Tabs.Settings:CreateToggle({
    Name = "Anti AFK",
    Default = true,
    Callback = function(Value)
        if Value then
            local vu = game:GetService("VirtualUser")
            repeat wait() until game:IsLoaded()
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

Tabs.Settings:CreateToggle({
    Name = "Auto Anti - Admin Join Server",
    Description = "",
    Default = true,
    Callback = function(Value)
        getgenv().HopServerAdmin = Value
    end
})

Tabs.Settings:CreateToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})

-- ====================================================================
-- TAB: STATS UPGRADE (ESP TAB)
-- ====================================================================

Tabs.Esp:CreateSection("Stats")
StatusSelect = Tabs.Esp:CreateSlider({
Name = "Stats Value",
Description = "",
Default = 10,
Min = 0,
Max = 1000,
Rounding = 1,
Callback = function(Value)
  pSats = Value
end})

StatsUpg = Tabs.Esp:CreateToggle({
Name = "Auto Melee",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Melee = Value
end})

StatsUpg = Tabs.Esp:CreateToggle({
Name = "Auto Swords",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Sword = Value
end})

StatsUpg = Tabs.Esp:CreateToggle({
Name = "Auto Gun",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Gun = Value
end})

StatsUpg = Tabs.Esp:CreateToggle({
Name = "Auto Blox Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_DevilFruit = Value
end})

StatsUpg = Tabs.Esp:CreateToggle({
Name = "Auto Defense",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Defense = Value
end})

-- ====================================================================
-- TAB: FISHING
-- ====================================================================

Tabs.Fish:CreateSection("Fishing")
Tabs.Fish:CreateDropdown({
    Name = "Select Fishing Rod",
    Description = "",
    Options = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"},
    Default = "Fishing Rod",
    Callback = function(Value)
        _G.SelectedRod = Value
    end
})

BaitDropdown = Tabs.Fish:CreateDropdown({
    Name = "Select Bait",
    Description = "",
    Options = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Default = "Basic Bait",
    Callback = function(Value)
        _G.SelectedBait = Value
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

BuyBaitToggle = Tabs.Fish:CreateToggle({
    Name = "Auto Buy Bait",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoBuyBait = Value
        if Value then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

FishingToggle = Tabs.Fish:CreateToggle({
    Name = "Auto Fishing",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFishing = Value
    end
})

FishingQ = Tabs.Fish:CreateToggle({
Name = "Auto Quest Fishing",
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoFishingQuest = Value
end})

QuestToggle = Tabs.Fish:CreateToggle({
    Name = "Auto Complete Quest",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoQuestComplete = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})

SellFishToggle = Tabs.Fish:CreateToggle({
    Name = "Auto Sell Fish",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoSellFish = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
})

SpamSkillZ = Tabs.Fish:CreateToggle({
Name = "Auto Spam Skill Z",
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoSkillZ = Value
end})

-- ====================================================================
-- TAB: QUEST AND ITEM
-- ====================================================================

TravelDress = Tabs.Quests:CreateToggle({
Name = "Auto Quest Sea 2",
Description = "",
Default = false,
Callback = function(Value)
  _G.TravelDres = Value
end})

Zou = Tabs.Quests:CreateToggle({
Name = "Auto Quest Sea 3",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoZou = Value
end})

Tabs.Quests:CreateSection("Tushita + Yama")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Tushita Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Tushita = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Yama Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Yama = Value
end})

Tabs.Quests:CreateSection("Skull Guitar")
local CheckSoul = Tabs.Quests:CreateParagraph({Title = "Skull Guitar Quests", Content = ""})
spawn(function()
    while wait(0.2) do
        pcall(function()
            if Quest1 == true then 
                CheckSoul:SetContent("Quest Number : Quest1")
            elseif Quest2 == true then 
                CheckSoul:SetContent("Quest Number : Quest2")
            elseif Quest3 == true then 
                CheckSoul:SetContent("Quest Number : Quest3")
            elseif Quest4 == true then 
                CheckSoul:SetContent("Quest Number : Quest4")
            elseif GetWP("Skull Guitar") then 
                CheckSoul:SetContent("Quest Number : Collect!!")
            else 
                CheckSoul:SetContent("Quest Number : No Quest!!")
            end
        end)
    end
end)

Tabs.Quests:CreateToggle({
Name = "Auto Skull Guitar",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Soul_Guitar = Value
end})

Tabs.Quests:CreateToggle({
Name = "Auto Farm Material Skull Guitar",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoMatSoul = Value
end})

Tabs.Quests:CreateSection("Cursed Dual Katana")
local CheckCDK = Tabs.Quests:CreateParagraph({Title = "Number Cursed dual katana quests", Content = "Quest Numbers :"})
spawn(function()  
    while wait(0.2) do 
        if QuestYama_1 == true then 
            CheckCDK:SetContent("Quest Numbers : yama quest 1") 
        elseif QuestYama_2 == true then
            CheckCDK:SetContent("Quest Numbers : yama quest 2") 
        elseif QuestYama_3 == true then
            CheckCDK:SetContent("Quest Numbers : yama quest 3") 
        elseif QuestTushita_1 == true then
            CheckCDK:SetContent("Quest Numbers : tushita quest 1") 
        elseif QuestTushita_2 == true then
            CheckCDK:SetContent("Quest Numbers : tushita quest 2") 
        elseif GetWP("Cursed Dual Katana") then
            CheckCDK:SetContent("Quest Numbers : CDK done!!")
        end 
    end
end)

Q = Tabs.Quests:CreateToggle({
Name = "Auto Get CDK Last Quest",
Description = "",
Default = false,
Callback = function(Value)
  _G.CDK = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Yama CDK",
Description = "",
Default = false,
Callback = function(Value)
  _G.CDK_YM = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Tushita CDK",
Description = "",
Default = false,
Callback = function(Value)
  _G.CDK_TS = Value
end})

Tabs.Quests:CreateSection("True Triple Katana")
Tabs.Quests:CreateButton({
Name = "Buy Legendary Sword",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
end})

Tabs.Quests:CreateButton({
Name = "Buy True Triple Katana Sword",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("MysteriousMan","2")
end})

Q = Tabs.Quests:CreateToggle({
Name = "Tween to Legendary Sword Dealer",
Description = "",
Default = false,
Callback = function(Value)
  _G.Tp_LgS = Value
end})

Tabs.Quests:CreateSection("Pole / God Enal's")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Pole V1",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoPole = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Pole V2 [Beta]",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoPoleV2 = Value
end})

Tabs.Quests:CreateToggle({
Name = "Auto Saw Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoSaw = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Saber Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoSaber = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Cybrog",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoColShad = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Usoap's Hat",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoGetUsoap = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Bisento V2",
Description = "",
Default = false,
Callback = function(Value)
  _G.Greybeard = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Warden Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.WardenBoss = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Marine Coat",
Description = "",
Default = false,
Callback = function(Value)
  _G.MarinesCoat = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Swan Coat",
Description = "",
Default = false,
Callback = function(Value)
  _G.SwanCoat = Value
end})

Tabs.Quests:CreateSection("Rengoku")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Rengoku Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.IceBossRen = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Key Rengoku",
Description = "",
Default = false,
Callback = function(Value)
  _G.KeysRen = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Dragon Trident",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoTridentW2 = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Long Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.LongsWord = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Black Spikey",
Description = "",
Default = false,
Callback = function(Value)
  _G.BlackSpikey = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Dark Blade V3",
Description = "",
Default = false,
Callback = function(Value)
  _G.DarkBladev3 = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Midnight Blade",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoEcBoss = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Darkbeard",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Def_DarkCoat = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Unlocked DonSwan",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_DonAcces = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Swan Glasses",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_SwanGG = Value
end})

Tabs.Quests:CreateSection("Sword")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Bigmom",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoBigmom = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Canvendish Sword",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Cavender = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Twin Hooks",
Description = "",
Default = false,
Callback = function(Value)
  _G.TwinHook = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Serpent Bow",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoSerpentBow = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Lei Accessory",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoKilo = Value
end})

Tabs.Quests:CreateSection("Haki Color")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Teleport Barista Cousin",
Description = "",
Default = false,
Callback = function(Value)
  _G.Tp_MasterA = Value
end})

Tabs.Quests:CreateButton({
Name = "Buy Buso Colors",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Rainbow Haki",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Rainbow_Haki = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Accept Rainbow Haki Quest",
Description = "",
Default = false,
Callback = function(Value)
  _G.GetQFast = Value
end})

Tabs.Quests:CreateSection("Observation")
Q = Tabs.Quests:CreateToggle({
Name = "Auto Farm Observation",
Description = "",
Default = false,
Callback = function(Value)
  _G.obsFarm = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Observation V2",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoKenVTWO = Value
end})

Bartilo = Tabs.Quests:CreateToggle({
Name = "Auto Done Bartilo Quest",
Description = "",
Default = false,
Callback = function(Value)
  _G.Bartilo_Quest = Value
end})

CitizenQ = Tabs.Quests:CreateToggle({
Name = "Auto Done Citizen Quest",
Description = "",
Default = false,
Callback = function(Value)
  _G.CitizenQuest = Value
end})

Q = Tabs.Quests:CreateToggle({
Name = "Auto Training Dummy",
Description = "",
Default = false,
Callback = function(Value)
  _G.DummyMan = Value
end})

Tabs.Quests:CreateSection("Fighting Style")
SuperHuman = Tabs.Quests:CreateToggle({
Name = "Auto Superhuman",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_SuperHuman = Value
end})

DeathStep = Tabs.Quests:CreateToggle({
Name = "Auto DeathStep",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoDeathStep = Value
end})

SharkManV2 = Tabs.Quests:CreateToggle({
Name = "Auto Sharkman Karate",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_SharkMan_Karate = Value
end})

ElectricClaw = Tabs.Quests:CreateToggle({
Name = "Auto ElectricClaw",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Electric_Claw = Value
end})

DragonTalon = Tabs.Quests:CreateToggle({
Name = "Auto DragonTalon",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoDragonTalon = Value
end})

Godhuman = Tabs.Quests:CreateToggle({
Name = "Auto Godhuman",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_God_Human = Value
end})

SanguineArt = Tabs.Quests:CreateToggle({
Name = "Auto SanguineArt",
Description = "",
Default = false,
Callback = function(Value)
  _G.Snaguine = Value
end})

-- ====================================================================
-- TAB: MIRAGE AND RACE
-- ====================================================================

Tabs.Race:CreateSection("Mirage Island")
local FullMOOn = Tabs.Race:CreateParagraph({Title = "FullMoon Status", Content = ""})
local Ismirage = Tabs.Race:CreateParagraph({Title = "Mirage Island Status", Content = ""})
spawn(function()
    while wait(0.2) do
        if workspace.Map:FindFirstChild("MysticIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
            Ismirage:SetContent("Mirage Island : True")
        else
            Ismirage:SetContent("Mirage Island : False")
        end
    end
end)

spawn(function()
    while wait(0.2) do
        pcall(function()
            local moon8 = "http://www.roblox.com/asset/?id=9709150401"
            local moon7 = "http://www.roblox.com/asset/?id=9709150086"
            local moon6 = "http://www.roblox.com/asset/?id=9709149680"
            local moon5 = "http://www.roblox.com/asset/?id=9709149431"
            local moon4 = "http://www.roblox.com/asset/?id=9709149052"
            local moon3 = "http://www.roblox.com/asset/?id=9709143733"
            local moon2 = "http://www.roblox.com/asset/?id=9709139597"
            local moon1 = "http://www.roblox.com/asset/?id=9709135895"
            local moon = Getmoon()
            
            if moon == moon1 then
                FullMOOn:SetContent("Moon : 0 / 8")
            elseif moon == moon2 then
                FullMOOn:SetContent("Moon : 1 / 8")
            elseif moon == moon3 then
                FullMOOn:SetContent("Moon : 2 / 8")
            elseif moon == moon4 then
                FullMOOn:SetContent("Moon : 3 / 8 [ Next Night ]")
            elseif moon == moon5 then
                FullMOOn:SetContent("Moon : 4 / 8 [ Full Moon ]")
            elseif moon == moon6 then
                FullMOOn:SetContent("Moon : 5 / 8 [ Last Night ]")
            elseif moon == moon7 then
                FullMOOn:SetContent("Moon : 6 / 8")
            elseif moon == moon8 then
                FullMOOn:SetContent("Moon : 7 / 8")
            end
        end)
    end
end)

Tabs.Race:CreateToggle({
Name = "Auto Find Mirage Island",
Description = "",
Default = false,
Callback = function(Value)
  _G.FindMirage = Value
end})

Tabs.Race:CreateToggle({
    Name = "Esp Mirage Island",
    Description = "",
    Value = false,
    Callback = function(Value)
        MirageIslandESP = Value
        if MirageIslandESP then
            task.spawn(function()
                while MirageIslandESP do
                    if UpdateIslandMirageESP then UpdateIslandMirageESP() end
                    task.wait(1)
                end
            end)
        elseif UpdateIslandMirageESP then
            UpdateIslandMirageESP()
        end
    end
})

Tabs.Race:CreateToggle({
    Name = "Auto Tween To Mirage Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoMysticIsland = Value
    end
})

Tabs.Race:CreateToggle({
Name = "Auto Tween To Highest Point",
Description = "",
Default = false,
Callback = function(Value)
  _G.HighestMirage = Value
end})

Tabs.Race:CreateToggle({
Name = "Auto Collect Gear",
Description = "",
Default = false,
Callback = function(Value)
  _G.TPGEAR = Value
end})

Tabs.Race:CreateToggle({
Name = "Change Transparency can see",
Description = "",
Default = false,
Callback = function(Value)
  _G.can = Value
end})

Tabs.Race:CreateToggle({
Name = "Auto Tween Advanced Fruit Dealer",
Description = "",
Default = false,
Callback = function(Value)
  _G.Addealer = Value
end})

Tabs.Race:CreateToggle({
Name = "Auto Collect Mirage Chest",
Description = "",
Default = false,
Callback = function(Value)
  _G.FarmChestM = Value
end})

Tabs.Race:CreateButton({
Name = "Talk With Stone",
Description = "",
Callback = function()
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Begin")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Teleport")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Continue")
end})

Tabs.Race:CreateToggle({
Name = "Auto Look At Moon",
Description = "",
Default = false,
Callback = function(Value)
  LookM = Value
end})

Tabs.Race:CreateToggle({
    Name = "Look Moon + Auto V3",
    Description = "",
    Default = false,
    Callback = function(Value)
        LookMV3 = Value
    end
})

Tabs.Race:CreateSection("Races V2 And V3")
RaceMink = Tabs.Race:CreateToggle({
Name = "Auto Upgrade Mink",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Mink = Value
end})

RaceHuman = Tabs.Race:CreateToggle({
Name = "Auto Upgrade Human",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Human = Value
end})

RaceSky = Tabs.Race:CreateToggle({
Name = "Auto Upgrade Angel",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Skypiea = Value
end})

RaceFish = Tabs.Race:CreateToggle({
Name = "Auto Upgrade FishMan",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Fish = Value
end})

Tabs.Race:CreateSection("Trial Race V4")
local CheckTier = Tabs.Race:CreateParagraph({Title = "Tiers V4 Status", Content = ""})
spawn(function()
    pcall(function()
        while wait(0.2) do
            CheckTier:SetContent("Tiers - V4 : " .. " " .. plr.Data.Race.C.Value)
        end
    end)
end)

PullLv = Tabs.Race:CreateToggle({
Name = "Auto Pull Lever",
Description = "",
Default = false,
Callback = function(Value)
  _G.Lver = Value
end})

Train = Tabs.Race:CreateToggle({
Name = "Auto Train V4",
Description = "",
Default = false,
Callback = function(Value)
  _G.AcientOne = Value
end})

Tabs.Race:CreateButton({
    Name = "Teleport to Temple of Time",
    Description = "",
    Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end

        if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})

Tabs.Race:CreateButton({
Name = "Teleport to Ancient One",
Description = "",
Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end

        if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
        
        task.wait(2)

        tween(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
    end
})

Tabs.Race:CreateButton({
Name = "Teleport to Ancient Clock",
Description = "",
Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

        local pos1 = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        local pos2 = CFrame.new(29549, 15069, -88)

        if hrp then
            hrp.CFrame = pos1
        end

        task.delay(2, function()
            _tp(pos2)
        end)

        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})

Doors = Tabs.Race:CreateToggle({
Name = "Auto Teleport to Race Doors",
Description = "",
Default = false,
Callback = function(Value)
  _G.TPDoor = Value
end})

Trials = Tabs.Race:CreateToggle({
Name = "Auto Complete Trial Race",
Description = "",
Default = false,
Callback = function(Value)
  _G.Complete_Trials = Value
end})

AutoKill = Tabs.Race:CreateToggle({
Name = "Auto Kill Player After Trial",
Description = "",
Default = false,
Callback = function(Value)
  _G.Defeating = Value
end})

-- ====================================================================
-- TAB: VOLCANO EVENT (PREHISTORIC)
-- ====================================================================

Tabs.Prehistoric:CreateSection("Dojo")
Tabs.Prehistoric:CreateButton({
    Name = "Teleport To Dragon Dojo",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906))
        _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
    end
})

DojoQ = Tabs.Prehistoric:CreateToggle({
Name = "Auto Dojo Trainer",
Description = "",
Default = false,
Callback = function(Value)
  _G.Dojoo = Value
end})

BlazeEM = Tabs.Prehistoric:CreateToggle({
Name = "Auto Dragon Hunter",
Description = "",
Default = false,
Callback = function(Value)
  _G.FarmBlazeEM = Value
end})

Tabs.Prehistoric:CreateSection("Droco Trial")
Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Tween To Upgrade Droco Trial",
Description = "",
Default = false,
Callback = function(Value)
  _G.UPGDrago = Value
end})

Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Auto Draco V1",
Description = "",
Default = false,
Callback = function(Value)
  _G.DragoV1 = Value
end})

fireflower = Tabs.Prehistoric:CreateToggle({
Name = "Auto Draco V2",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoFireFlowers = Value
end})

Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Auto Draco V3",
Description = "",
Default = false,
Callback = function(Value)
  _G.DragoV3 = Value
end})

Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Auto Relic Draco Trial",
Description = "",
Default = false,
Callback = function(Value)
  _G.Relic123 = Value
end})

Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Auto Train Droco v4",
Description = "",
Default = false,
Callback = function(Value)
  _G.TrainDrago = Value
end})

dragoTpVolcano = Tabs.Prehistoric:CreateToggle({
Name = "Tween to Droco Trials",
Description = "",
Default = false,
Callback = function(Value)
  _G.TpDrago_Prehis = Value
end})

bdrago = Tabs.Prehistoric:CreateToggle({
Name = "Swap Drago Race",
Description = "",
Default = false,
Callback = function(Value)
  _G.BuyDrago = Value
end})

UpTalon = Tabs.Prehistoric:CreateToggle({
Name = "Upgrade Dragon Talon With Uzoth",
Description = "",
Default = false,
Callback = function(Value)
  _G.DT_Uzoth = Value
end})

Tabs.Prehistoric:CreateSection("Volcano Crafting")
Tabs.Prehistoric:CreateButton({
Name = "Craft Dragonheart",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "Dragonheart"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.Prehistoric:CreateButton({
Name = "Craft Dragonstorm",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "Dragonstorm"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.Prehistoric:CreateButton({
    Name = "Craft Dino Hood",
    Description = "",
    Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "DinoHood"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.Prehistoric:CreateButton({
    Name = "Craft T-Rex Skull",
    Description = "",
    Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "TRexSkull"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.Prehistoric:CreateSection("Prehistoric Island")
local Check_Volcano = Tabs.Prehistoric:CreateParagraph({Title = "Prehistoric Island Status", Content = ""})
spawn(function()
    while wait(0.2) do
        if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
            Check_Volcano:SetContent("Prehistoric Island : True")
        else
            Check_Volcano:SetContent("Prehistoric Island : False")
        end
    end
end)

Tabs.Prehistoric:CreateButton({
    Name = "Craft Volcanic Magnet",
    Description = "",
    Callback = function()
        local RF = game:GetService("ReplicatedStorage").Modules.Net["RF/Craft"]
        RF:InvokeServer(
            "PossibleHardcode",
            "Volcanic Magnet"
        )
    end
})

Tabs.Prehistoric:CreateToggle({
    Name = "Craft Volcanic Magnet",
    Default = false,
    Callback = function(Value)
        getgenv().AutoCraftVolcanic = Value
    end
})

Tabs.Prehistoric:CreateToggle({
    Name = "Auto Find Prehistoric Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Prehis_Find = Value; PrehisUser.Find = Value
    end
})
local targetDestination = nil

Tabs.Prehistoric:CreateToggle({
    Name = "Auto Start Volcano Event",
    Default = false,
    Callback = function(Value)
        _G.AutoStartPrehistoric = Value
    end
})

Tabs.Prehistoric:CreateToggle({
    Name = "Auto Patch Volcano Event",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Prehis_Skills = Value; PrehisUser.Skills = Value
    end
})

Kaura = Tabs.Prehistoric:CreateToggle({
    Name = "Kill Aura",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.KillAuraFull = Value
end})
local Range = 500
local Delay = 2

Vocan = Tabs.Prehistoric:CreateToggle({
Name = "Auto Collect Dino Bones",
Description = "",
Default = false,
Callback = function(Value)
  _G.Prehis_DB = Value
end})

Vocan = Tabs.Prehistoric:CreateToggle({
Name = "Auto Collect Dragon Eggs",
Description = "",
Default = false,
Callback = function(Value)
  _G.Prehis_DE = Value; PrehisUser.DE = Value
end})

Toggle = Tabs.Prehistoric:CreateToggle({
Name = "Auto Reset When Complete Volcano",
Description = "",
Default = false,
Callback = function(Value)
  _G.ResetPH = Value
end})

-- ====================================================================
-- TAB: SEA EVENT
-- ====================================================================

Tabs.SeaEvent:CreateSection("Sea Event")
Tabs.SeaEvent:CreateButton({
    Name = "Remove Lighting Effect",
    Description = "",
    Callback = function()
        game:GetService("Lighting").BaseAtmosphere:Destroy()
    end
})

Tabs.SeaEvent:CreateToggle({
    Name = "Ship Speed Modifier",
    Default = false,
    Callback = function(Value)
        getgenv().SpeedBoat = Value
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().SpeedBoat then
        local plr = game:GetService("Players").LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Sit then
                for _, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                    local seat = boat:FindFirstChildWhichIsA("VehicleSeat")
                    if seat then
                        seat.MaxSpeed = SetSpeedBoat
                    end
                end
            end
        end
    end
end)

Tabs.SeaEvent:CreateSlider({
    Name = "Ship Speed",
    Min = 0,
    Max = 1000,
    Increment = 1,
    Default = 300,
    Callback = function(Value)
        SetSpeedBoat = Value
    end
})

Tabs.SeaEvent:CreateToggle({
    Name = "Auto Press W",
    Default = false,
    Callback = function(Value)
        getgenv().AutoPressW = Value
    end
})

Tabs.SeaEvent:CreateToggle({
    Name = "No Clip Ship",
    Default = false,
    Callback = function(Value)
        getgenv().NoClipShip = Value
    end
})

Tabs.SeaEvent:CreateSection("Sea Event Crafting")
Tabs.SeaEvent:CreateButton({
Name = "Craft SharkTooth",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "SharkTooth"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft TerrorJaw",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "TerrorJaw"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft SharkAnchor",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "SharkAnchor"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft LeviathanCrown",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanCrown"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft LeviathanShield",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanShield"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft LeviathanBoat",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanBoat"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft LegendaryScroll",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LegendaryScroll"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Craft MythicalScroll",
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "MythicalScroll"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:CreateSection("Sea Event Entity")
Q = Tabs.SeaEvent:CreateDropdown({
    Name = "Select Boats",
	Options = ListSeaBoat,
	Callback = function(Value)
        _G.SelectedBoat = Value
    end
})

Tabs.SeaEvent:CreateButton({
Name = "Buy Boats",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBoat",_G.SelectedBoat)
end})

Q = Tabs.SeaEvent:CreateDropdown({
Name = "Select Sea Level",
Options = ListSeaZone,
Callback = function(Value)
  _G.DangerSc = Value
end})

Q = Tabs.SeaEvent:CreateToggle({
Name = "Auto Sail Boat",
Description = "",
Default = false,
Callback = function(Value)
  _G.SailBoats = Value
end})

Tabs.SeaEvent:CreateSection("Sea Event Entity")
Tabs.SeaEvent:CreateToggle({
Name = "Auto Shark",
Description = "",
Default = false,
Callback = function(Value)
  _G.Shark = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Piranha",
Description = "",
Default = false,
Callback = function(Value)
  _G.Piranha = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Terror Shark",
Description = "",
Default = false,
Callback = function(Value)
  _G.TerrorShark = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Fish Crew Member",
Description = "",
Default = false,
Callback = function(Value)
  _G.MobCrew = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Haunted Crew Member",
Description = "",
Default = false,
Callback = function(Value)
  _G.HCM = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Attack PirateGrandBrigade",
Description = "",
Default = false,
Callback = function(Value)
  _G.PGB = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Attack Fish Boat",
Description = "",
Default = false,
Callback = function(Value)
  _G.FishBoat = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Attack Sea Beast",
Description = "",
Default = false,
Callback = function(Value)
  _G.SeaBeast1 = Value
end})

Tabs.SeaEvent:CreateSection("Kitsune Event")
local Check_Kitsu = Tabs.SeaEvent:CreateParagraph({Title = "Kitsune Island Status", Content = ""})
spawn(function()
    while wait(0.2) do
        if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
            Check_Kitsu:SetContent("Kitsune Island : True")
        else
            Check_Kitsu:SetContent("Kitsune Island : False")
        end
    end
end)

Tabs.SeaEvent:CreateToggle({
Name = "Auto Find Kitsune Island",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutofindKitIs = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Teleport to Shrine Actived",
Description = "",
Default = false,
Callback = function(Value)
  _G.tweenShrine = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Collect Azure Ember",
Description = "",
Default = false,
Callback = function(Value)
  _G.Collect_Ember = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Trade Azure Ember",
Description = "",
Default = false,
Callback = function(Value)
  _G.Trade_Ember = Value
end})

Tabs.SeaEvent:CreateButton({
Name = "Trade Items Azure",
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
end})

Tabs.SeaEvent:CreateButton({
Name = "Talk with kitsune statue",
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
end})

Tabs.SeaEvent:CreateSection("Frozen Dimension")
local FloD = Tabs.SeaEvent:CreateParagraph({Title = "FrozenDimension Status", Content = ""})
spawn(function()
    pcall(function()
        while wait(0.2) do
            if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
                FloD:SetContent('Frozen Dimension : True')
            else
                FloD:SetContent('Frozen Dimension : False')
            end
        end
    end)
end)

local SPYING = Tabs.SeaEvent:CreateParagraph({Title = "Spy Status", Content = ""})
spawn(function()
    while wait(0.2) do
        pcall(function()
            local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
            if spycheck then 
                SPYING:SetContent("Spy Leviathan : " .. tostring(spycheck))
                if tonumber(spycheck) == 5 then
                    SPYING:SetContent("Spy Leviathan : Already Done!!")
                end
            end
        end)
    end
end)

Tabs.SeaEvent:CreateButton({
    Name = "Buy Spy",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Teleport Frozen Dimension",
Description = "",
Default = false,
Callback = function(Value)
  _G.FrozenTP = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Drive To Hydra Island",
Description = "",
Default = false,
Callback = function(Value)
  _G.SailBoat_Hydra = Value
end})

Tabs.SeaEvent:CreateToggle({
Name = "Auto Attack Leviathan",
Description = "",
Default = false,
Callback = function(Value)
  _G.Leviathan1 = Value
end})

-- ====================================================================
-- TAB: STATS AND ESP (VISUAL ESP)
-- ====================================================================

Tabs.Esp:CreateSection("Esp")
Tabs.Esp:CreateToggle({
    Name = "Esp Berry",
    Description = "",
    Default = false,
    Callback = function(Value)
        BerryEsp = Value
        if not Value then
            for _, v in ipairs(workspace:GetChildren()) do
                if v:IsA("Part") and v.Name:match("BerryEspPart_.*") then
                    v:Destroy()
                end
            end
        else
            task.spawn(function()
                while BerryEsp do
                    berriesEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Player",
    Description = "",
    Default = false,
    Callback = function(Value)
        PlayerEsp = Value
        if not Value then
            for _,v in next, game.Players:GetChildren() do
                pcall(function()
                    if not isnil(v.Character) and not isnil(v.Character.Head) then
                        if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                            v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                        end
                    end
                end)
            end
        else
            task.spawn(function()
                while PlayerEsp do
                    EspPly()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Chest",
    Description = "",
    Default = false,
    Callback = function(Value)
        ChestESP = Value
        if not Value then
            for _, Chest in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                local espAttachment = Chest:FindFirstChild("ChestEspAttachment")
                if espAttachment then
                    espAttachment:Destroy()
                end
            end
        else
            task.spawn(function()
                while ChestESP do
                    ChestEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Fruit",
    Description = "",
    Default = false,
    Callback = function(Value)
        DevilFruitESP = Value
        if not Value then
            for i,v in next, workspace:GetChildren() do
                pcall(function()
                    if v:FindFirstChild('Handle') and v.Handle:FindFirstChild('NameEsp'..Number) then
                        v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end)
            end
        else
            task.spawn(function()
                while DevilFruitESP do
                    DevEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        IslandESP = Value
        if not Value then
            for _,v in next, workspace["_WorldOrigin"].Locations:GetChildren() do
                pcall(function()
                    if v:FindFirstChild('NameEsp') then
                        v:FindFirstChild('NameEsp'):Destroy()
                    end
                end)
            end
        else
            task.spawn(function()
                while IslandESP do
                    LocationEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Flower",
    Description = "",
    Default = false,
    Callback = function(Value)
        FlowerESP = Value
        if not Value then
            for i,v in pairs(workspace:GetChildren()) do
                pcall(function()
                    if (v.Name == "Flower2" or v.Name == "Flower1") and v:FindFirstChild('NameEsp'..Number) then
                        v:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end)
            end
        else
            task.spawn(function()
                while FlowerESP do
                    flowerEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Legendary Sword",
    Description = "",
    Default = false,
    Callback = function(Value)
        LegenS = Value
        if not Value then
            if workspace:FindFirstChild("Lgd") then
                workspace:FindFirstChild("Lgd"):Destroy()
            end
        else
            task.spawn(function()
                while LegenS do
                    LegenSword()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Haki Color",
    Description = "",
    Default = false,
    Callback = function(Value)
        ColorEsp = Value
        if not Value then
            if workspace:FindFirstChild("Gay") then
                workspace:FindFirstChild("Gay"):Destroy()
            end
        else
            task.spawn(function()
                while ColorEsp do
                    HakiClorEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Gear",
    Description = "",
    Default = false,
    Callback = function(Value)
        ESPGear = Value
        if not Value then
            local mystic = workspace.Map:FindFirstChild("MysticIsland")
            for _,v in pairs(mystic and mystic:GetDescendants() or {}) do
                pcall(function()
                    if v:FindFirstChild("NameEsp") then
                        v:FindFirstChild("NameEsp"):Destroy()
                    end
                end)
            end
        else
            task.spawn(function()
                while ESPGear do
                    gearEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp SeaEvent Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        EspEventIsland = Value
        if not Value then
            for i, v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
                pcall(function()
                    if v:FindFirstChild("NameEsp") then
                        v:FindFirstChild("NameEsp"):Destroy()
                    end
                end)
            end
        else
            task.spawn(function()
                while EspEventIsland do
                    EventIslandEsp()
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Esp:CreateToggle({
    Name = "Esp Advanced Dealer",
    Description = "",
    Default = false,
    Callback = function(Value)
        advanEsp = Value
        if not Value then
            if workspace:FindFirstChild("Adv") then
                workspace:FindFirstChild("Adv"):Destroy()
            end
        else
            task.spawn(function()
                while advanEsp do
                    AdvanFruitEsp()
                    task.wait()
                end
            end)
        end
    end
})

-- ====================================================================
-- TAB: FRUIT AND RAID
-- ====================================================================

Tabs.Raids:CreateSection("Fruit")
local stockParagraph = Tabs.Raids:CreateParagraph({Title = "Select Fruit Shop", Content = "Loading..."})
task.spawn(function()
    while task.wait(60) do
        pcall(function()
            stockParagraph:SetContent(getFruitStock())
        end)
    end
end)
pcall(function()
    stockParagraph:SetContent(getFruitStock())
end)

RandomFF = Tabs.Raids:CreateToggle({
Name = "Auto Random Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.Random_Auto = Value
  _G.RandomFruitCooldown = nil
end})
local RandomFruitCooldown = nil

DropF = Tabs.Raids:CreateToggle({
Name = "Auto Drop Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.DropFruit = Value
end})

StoredF = Tabs.Raids:CreateToggle({
Name = "Auto Store Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.StoreF = Value
end})

TwF = Tabs.Raids:CreateToggle({
Name = "Auto Tween to Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.TwFruits = Value
end})

BringF = Tabs.Raids:CreateToggle({
Name = "Auto Collect Fruit",
Description = "",
Default = false,
Callback = function(Value)
  _G.InstanceF = Value
end})

Tabs.Raids:CreateDropdown({
    Name = "Select Fruit Shop",
    Options = {
        "Rocket-Rocket", "Spin-Spin", "Blade-Blade", "Spring-Spring",
        "Bomb-Bomb", "Smoke-Smoke", "Spike-Spike", "Flame-Flame",
        "Ice-Ice", "Sand-Sand", "Dark-Dark", "Eagle-Eagle",
        "Diamond-Diamond", "Light-Light", "Rubber-Rubber", "Ghost-Ghost",
        "Magma-Magma", "Quake-Quake", "Buddha-Buddha", "Love-Love",
        "Creation-Creation", "Spider-Spider", "Sound-Sound", "Phoenix-Phoenix",
        "Portal-Portal", "Lightning-Lightning", "Pain-Pain", "Blizzard-Blizzard",
        "Gravity-Gravity", "T-Rex-T-Rex", "Mammoth-Mammoth", "Dough-Dough",
        "Shadow-Shadow", "Venom-Venom", "Gas-Gas", "Control-Control",
        "Spirit-Spirit", "Leopard-Leopard", "Yeti-Yeti", "Kitsune-Kitsune",
        "Dragon-Dragon"
    },
    Callback = function(Value)
        getgenv().SelectFruit = Value
    end
})

Tabs.Raids:CreateToggle({
    Name = "Auto Buy Fruit Shop",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyFruitSniper = Value
    end
})

Tabs.Raids:CreateSection("Dungeon")
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
Q = Tabs.Raids:CreateDropdown({
Name = "Select Chip",
Description = "",
Options = DungeonTables,
Callback = function(Value)
  _G.SelectChip = Value
end})

Q = Tabs.Raids:CreateToggle({
Name = "Auto Select Raid Chip",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoSelectDungeon = Value
end})

Tabs.Raids:CreateToggle({
    Name = "Get Fruit In Inventory Below 1M",
    Default = false,
    Callback = function(Value)
        getgenv().AutoGetFruit = Value
    end
})

Tabs.Raids:CreateButton({
Name = "Auto Buy Chip",
Description = "",
Callback = function()
  if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end
end})

Tabs.Raids:CreateButton({
Name = "Auto Buy Chip Fruit",
Description = "",
Callback = function()
  if GetBP("Special Microchip") then return end
  local FruitPrice = {}
  local FruitStore = {}
  for i,v in next,replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
    if v.Price <= 490000 then table.insert(FruitPrice,v.Name) end 
  end    
  for _,y in pairs(FruitPrice) do    
    for i,v in pairs(DungeonTables) do 
      if not GetBP("Special Microchip") then     
        replicated.Remotes.CommF_:InvokeServer("LoadFruit",tostring(y))	      
	    replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)	
	  end            
    end    
  end
end})

AutoChipBeli = Tabs.Raids:CreateToggle({
    Name = "Auto Buy Chip",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoChipBeli = Value
end
})

AutoChipFruit = Tabs.Raids:CreateToggle({
    Name = "Auto Buy Chip Fruit",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoChipFruit = Value
end
})

StartR = Tabs.Raids:CreateToggle({
    Name = "Auto Start Raid",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Auto_StartRaid = Value
    end
})

Raiding = Tabs.Raids:CreateToggle({
    Name = "Auto Raid + Next Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Raiding = Value
    end
})

KillAuraRaid = Tabs.Raids:CreateToggle({
    Name = "Kill Aura (Island 4 & 5)",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.KillAuraRaid = Value
    end
})

Tabs.Raids:CreateToggle({
Name = "Auto Awakening",
Description = "",
Default = false,
Callback = function(Value)
  _G.Auto_Awakener = Value
end})

Tabs.Raids:CreateToggle({
    Name = "Teleport To Lab",
    Default = false,
    Callback = function(Value)
        _G.TpLab = Value
        while _G.TpLab do
            wait()
            if _G.TpLab then
                if World2 and _G.TpLab then
                  _tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                elseif World3 and _G.TpLab then
                  _tp(CFrame.new(-5046, 314, -2960));
                end
            end
        end
    end
})

Tabs.Raids:CreateSection("Law")
Tabs.Raids:CreateButton({
Name = "Buy Chip Law",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
end})

Tabs.Raids:CreateButton({
Name = "Start Law",
Description = "",
Callback = function()
  fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
end})

Tabs.Raids:CreateToggle({
    Name = "Auto Buy Microchip Law",
    Description = "",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyMicrochipLaw = Value
    end
})

Tabs.Raids:CreateToggle({
    Name = "Auto Start Law",
    Description = "",
    Default = false,
    Callback = function(Value)
        getgenv().AutoStartLawRaids = Value
    end
})

Tabs.Raids:CreateToggle({
Name = "Auto Kill Law",
Description = "",
Default = false,
Callback = function(Value)
  _G.AutoLawKak = Value
end})

Tabs.Raids:CreateSection("Raid")
Tabs.Raids:CreateToggle({
    Name = "Auto Dungeon",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmDungeon = Value
    end
})
local FARM_RANGE = 5000

Tabs.Raids:CreateToggle({
    Name = "TP Exit (1)",
    Default = false,
    Callback = function(v)
        _G.TPFloor1 = v
    end
})
local tp1Done = false

Tabs.Raids:CreateToggle({
    Name = "TP Exit (2)",
    Default = false,
    Callback = function(v)
        _G.TPFloor2 = v
    end
})
local tp2Done = false

Tabs.Raids:CreateToggle({
    Name = "TP Exit (3)",
    Default = false,
    Callback = function(v)
        _G.TPFloor3 = v
    end
})
local tp3Done = false

Tabs.Raids:CreateToggle({
    Name = "TP Exit (4)",
    Default = false,
    Callback = function(v)
        _G.TPFloor4 = v
    end
})
local tp4Done = false

-- ====================================================================
-- TAB: LOCAL PLAYER / COMBAT
-- ====================================================================

Tabs.Combat:CreateSection("Combat")
local __indexPlayer = Tabs.Combat:CreateParagraph({Title = "Select Players", Content = ""})
spawn(function()
    while wait(Sec) do
        pcall(function()
            local playerCount = #game:GetService("Players"):GetPlayers()
            if playerCount == 12 then
                __indexPlayer:SetContent("All Players : " .. playerCount .. " / 12 [Max]")
            else
                __indexPlayer:SetContent("All Players : " .. playerCount .. " / 12")
            end
        end)
    end
end)

local __AimBotTurn = Tabs.Combat:CreateParagraph({Title = "Aimbot Status", Content = ""})
Checking_AimStatus = function()
    if _G.AimCam then
        return "Aimbot Camera"
    elseif _G.AimbotGun then
        return "Aimbot Guns"
    else
        return ""
    end
end

spawn(function()
    while wait(0.2) do
        pcall(function()
            if _G.AimMethod then
                if (_G.AimCam or _G.AimbotGun) then
                    __AimBotTurn:SetContent("Aimbot - " .. Checking_AimStatus() .. " : True")
                else
                    __AimBotTurn:SetContent("Aimbot - Skills : True")
                end
            else
                __AimBotTurn:SetContent("Aimbot - Skills : False")
            end
        end)
    end
end)

Tabs.Combat:CreateDropdown({
    Name = "Select Players",
    Description = "",
    Options = PlrList,
    Callback = function(Value)
        _G.PlayersList = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Teleport To Select Players",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.TpPly = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Spectate Select Players",
    Description = "",
    Default = false,
    Callback = function(Value)
        SpectatePlys = Value
    end
})

Tabs.Combat:CreateDropdown({
    Name = "Select Aim Method",
    Description = "",
    Options = {"Aim Player","Nearest Aim"},
    Callback = function(Value)
        ABmethod = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Aimbot Method Skills",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AimMethod = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Aimbot Camera Closet Players",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AimCam = Value
    end
})

Tabs.Combat:CreateSection("Quest Player")
Tabs.Combat:CreateButton({
    Name = "Get player quest",
    Description = "",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
        end)
    end
})

Tabs.Combat:CreateToggle({
    Name = "Auto Get Player Quest",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoReceivePlayerQuest = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Auto Kill Player Quest",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoPlayerHunter = Value
        if not Value then Useskill = false end
    end
})

Tabs.Combat:CreateToggle({
    Name = "Auto Enable PvP",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoPvP = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Auto Safe Mode",
    Default = false,
    Callback = function(Value)
        _G.SafeMode = Value
    end
})

Tabs.Combat:CreateSection("Local Player Setting")

Tabs.Combat:CreateToggle({
    Name = "Enable Fly",
    Default = false,
    Callback = function(Value)
        toggleFly(Value)
    end
})

Tabs.Combat:CreateSlider({
    Name = "Speed Fly Mode",
    Min = 10,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        updateFlySpeed(Value)
    end
})

Tabs.Combat:CreateToggle({
    Name = "Dash No Cooldown",
    Default = false,
    Callback = function(Value)
        getgenv().DodgeNoCD = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Instance Mink V3 [ INF ]",
    Description = "",
    Default = false,
    Callback = function(Value)
        InfAblities = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Instance Energy [ INF ]",
    Description = "",
    Default = false,
    Callback = function(Value)
        infEnergy = Value
        if Value then
            getInfinity_Ability("Energy", infEnergy)
        end
    end
})

Tabs.Combat:CreateToggle({
    Name = "Instance Soru [ INF ]",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.InfSoru = Value
        if Value then
            getInfinity_Ability("Soru", _G.InfSoru)
        end
    end
})

Tabs.Combat:CreateToggle({
    Name = "Instance Observation Range [ INF ]",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.InfiniteObRange = Value
        if Value then
            getInfinity_Ability("Observation", _G.InfiniteObRange)
        end
    end
})

Tabs.Combat:CreateToggle({
    Name = "Ignore Same Teams",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.NoAimTeam = Value
    end
})

Tabs.Combat:CreateToggle({
    Name = "Accept Allies",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AcceptAlly = Value
    end
})

-- ====================================================================
-- TAB: TELEPORT
-- ====================================================================

Tabs.Travel:CreateSection("Sea")
Tabs.Travel:CreateButton({
Name = "Travel Sea 1",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelMain")
end})

Tabs.Travel:CreateButton({
Name = "Travel Sea 2",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
end})

Tabs.Travel:CreateButton({
Name = "Travel Sea 3",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelZou")
end})

Tabs.Travel:CreateSection("Island")
Location = {}
for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do  
  table.insert(Location ,v.Name)
end

Travelllll = Tabs.Travel:CreateDropdown({
Name = "Select Island",
Description = "",
Options = Location,
Callback = function(Value)
  _G.Island = Value
end})

GoIsland = Tabs.Travel:CreateToggle({
Name = "Auto Teleport",
Description = "",
Default = false,
Callback = function(Value)
  _G.Teleport = Value
  if Value then
    for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
      if v.Name == _G.Island then
        repeat wait()
	     _tp(v.CFrame * CFrame.new(0, 30, 0)) 
        until not _G.Teleport or Root.CFrame == v.CFrame
      end
    end
  end
end
})

Tabs.Travel:CreateSection("Portal")
if World1 then
  Location_Portal = {
    "Sky",
    "UnderWater"
  }
elseif World2 then
  Location_Portal = {
    "SwanRoom",
    "Cursed Ship"
  }
elseif World3 then
  Location_Portal = {
    "Castle On The Sea",
    "Mansion Cafe",
    "Hydra Teleport",
    "Canvendish Room",
    "Temple of Time"
  }
end

PortalTP = Tabs.Travel:CreateDropdown({
Name = "Select Portal",
Options = Location_Portal,
Callback = function(Value)
  _G.Island_PT = Value
end})

Tabs.Travel:CreateButton({
Name = "requestEntrance",
Description = "",
Callback = function()
  if _G.Island_PT == "Sky" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894, 5547, -380))
  elseif _G.Island_PT == "UnderWater" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163, 11, 1819))
  elseif _G.Island_PT == "SwanRoom" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2285, 15, 905))
  elseif _G.Island_PT == "Cursed Ship" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 126, 32852))
  elseif _G.Island_PT == "Castle On The Sea" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
  elseif _G.Island_PT == "Mansion Cafe" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
  elseif _G.Island_PT == "Hydra Teleport" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
  elseif _G.Island_PT == "Canvendish Room" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
  elseif _G.Island_PT == "Temple of Time" then
    replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28310.0234, 14895.1123, 109.456741, -0.469690144, -2.85620132e-08, -0.882831335, -3.23509219e-08, 1, -1.51411736e-08, 0.882831335, 2.14487486e-08, -0.469690144))
  end
end})

Tabs.Travel:CreateSection("NPC")
for _, v in pairs(replicated.NPCs:GetChildren()) do table.insert(NPCList, v.Name) end
NPCsPos = Tabs.Travel:CreateDropdown({
Name = "Select NPC",
Options = NPCList,
Callback = function(Value)
  NPClist = Value
end})

GoNPCs = Tabs.Travel:CreateToggle({
Name = "Tween to NPC",
Description = "",
Default = false,
Callback = function(Value)
  _G.TPNpc = Value
end})

-- ====================================================================
-- TAB: SHOPPING
-- ====================================================================

Tabs.Shop:CreateSection("Shop")
Tabs.Shop:CreateButton({
Name = "Buy Buso",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end})

Tabs.Shop:CreateButton({
Name = "Buy Geppo",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end})

Tabs.Shop:CreateButton({
Name = "Buy Soru",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end})

Tabs.Shop:CreateButton({
Name = "Buy Ken",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")
end})

Tabs.Shop:CreateSection("Fighting Style")
Tabs.Shop:CreateButton({
Name = "Buy Black Leg",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
end})

Tabs.Shop:CreateButton({
Name = "Buy Electro",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyElectro")
end})

Tabs.Shop:CreateButton({
Name = "Buy Fishman Karate",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
end})

Tabs.Shop:CreateButton({
Name = "Buy DragonClaw",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end})

Tabs.Shop:CreateButton({
Name = "Buy Superhuman",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
end})

Tabs.Shop:CreateButton({
Name = "Buy Death Step",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
end})

Tabs.Shop:CreateButton({
Name = "Buy Sharkman Karate",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})

Tabs.Shop:CreateButton({
Name = "Buy ElectricClaw",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
end})

Tabs.Shop:CreateButton({
Name = "Buy DragonTalon",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
end})

Tabs.Shop:CreateButton({
Name = "Buy Godhuman",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
end})

Tabs.Shop:CreateButton({
Name = "Buy SanguineArt",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
end})

Tabs.Shop:CreateSection("Accessories")
Tabs.Shop:CreateButton({
Name = "Buy Tomoe Ring",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
end})

Tabs.Shop:CreateButton({
Name = "Buy Black Cape",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
end})

Tabs.Shop:CreateButton({
Name = "Buy Swordsman Hat",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
end})

Tabs.Shop:CreateButton({
Name = "Buy Bizarre Rifle",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1)
end})

Tabs.Shop:CreateButton({
Name = "Buy Ghoul Mask",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2)
end})

Tabs.Shop:CreateSection("Weapon")
Tabs.Shop:CreateButton({
Name = "Buy Cutlass",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
end})

Tabs.Shop:CreateButton({
Name = "Buy Katana",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Katana")
end})

Tabs.Shop:CreateButton({
Name = "Buy Iron Mace",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
end})

Tabs.Shop:CreateButton({
Name = "Buy Duel Katana",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
end})

Tabs.Shop:CreateButton({
Name = "Buy Triple Katana",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
end})

Tabs.Shop:CreateButton({
Name = "Buy Pipe",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Pipe")
end})

Tabs.Shop:CreateButton({
Name = "Buy Dual-Headed Blade",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
end})

Tabs.Shop:CreateButton({
Name = "Buy Bisento",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
end})

Tabs.Shop:CreateButton({
Name = "Buy Soul Cane",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
end})

Tabs.Shop:CreateButton({
Name = "Buy Slingshot",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
end})

Tabs.Shop:CreateButton({
Name = "Buy Musket",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Musket")
end})

Tabs.Shop:CreateButton({
Name = "Buy Dual Flintlock",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual Flintlock")
end})

Tabs.Shop:CreateButton({
Name = "Buy Flintlock",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
end})

Tabs.Shop:CreateButton({
Name = "Buy Refined Flintlock",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
end})

Tabs.Shop:CreateButton({
Name = "Buy Cannon",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cannon")
end})

Tabs.Shop:CreateButton({
Name = "Buy Kabucha",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
end})

Tabs.Shop:CreateSection("Fragment")
Tabs.Shop:CreateButton({
Name = "Buy Refund Stats",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end})

Tabs.Shop:CreateButton({
Name = "Buy Reroll Race",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end})

Tabs.Shop:CreateButton({
Name = "Buy Ghoul Race",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm"," Change", 4)
end})

Tabs.Shop:CreateButton({
Name = "Buy Cyborg Race (2.5k)",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CyborgTrainer"," Buy")
end})

Tabs.Shop:CreateButton({
    Name = "Buy Draco Race",
    Description = "",
    Callback = function()
        _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
        local targetPosition = Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)
        local character = player.Character or player.CharacterAdded:Wait()
        repeat wait()
        until (character.HumanoidRootPart.Position - targetPosition).Magnitude < 1
        local args = {
          [1] = {
                ["NPC"] = "Dragon Wizard",
                ["Command"] = "DragonRace"
            }
        }
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
    end
})

-- ====================================================================
-- TAB: MISCELLANEOUS
-- ====================================================================

Tabs.Misc:CreateSection("Server")
Tabs.Misc:CreateButton({
  Name = "Redeem All Codes",
  Description = "",
  Callback = function()
      local codes = {
          "LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK",
          "BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS",
          "SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10",
          "fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE",
          "Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK",
          "StARCodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123",
          "Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie",
          "TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN",
          "ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT",
          "NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"
      }

      local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local RemotesFolder = ReplicatedStorage:WaitForChild("Remotes")
      local RedeemRemote = RemotesFolder:FindFirstChild("Redeem")

      if not RedeemRemote then
          return
      end

      for _, code in ipairs(codes) do
          task.wait(0)
          pcall(function()
              if RedeemRemote.InvokeServer then
                  RedeemRemote:InvokeServer(code)
              else
                  RedeemRemote:FireServer(code)
              end
          end)
      end
  end
})

Tabs.Misc:CreateButton({
Name = "Rejoin Server",
Description = "",
Callback = function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})

Tabs.Misc:CreateButton({
    Name = "Hop Server",
    Description = "",
    Callback = function()
        task.spawn(function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local PlaceId = game.PlaceId
            local Players = game:GetService("Players")

            local success, servers = pcall(function()
                local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
                local response = game:HttpGet(url)
                return HttpService:JSONDecode(response).data
            end)

            if success and servers then
                local targetServer
                for _, s in pairs(servers) do
                    if s.playing < s.maxPlayers then
                        targetServer = s.id
                    end
                end

                if targetServer then
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceId, targetServer, Players.LocalPlayer)
                    end)
                end
            end
        end)
    end
})

Tabs.Misc:CreateButton({
Name = "Hop to Lowest Players",
Description = "",
Callback = function()
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"

   local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
  until Server

  TPS:TeleportToPlaceInstance(_place,Server.id,plr)
end})

Tabs.Misc:CreateButton({
Name = "Hop to Lowest Pings Server",
Description = "",
Callback = function()
local HTTPService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StatsService = game:GetService("Stats")
  local placeId = game.PlaceId
  local serverLimit = 100
  local servers = fetchServersData(placeId, serverLimit)
  if not servers then return end
  local lowestPingServer = servers[1]
  for _, server in pairs(servers) do
    if server["ping"] < lowestPingServer["ping"] and server.maxPlayers > server.playing then
      lowestPingServer = server
    end
  end
  local commonLoadTime = 0.5
  task.wait(commonLoadTime)
  local pingThreshold = 100
  local serverStats = StatsService.Network.ServerStatsItem
  local dataPing = serverStats["Data Ping"]:GetValueString()
  local pingValue = tonumber(dataPing:match("(%d+)"))
  if pingValue >= pingThreshold then
    TeleportService:TeleportToPlaceInstance(placeId, lowestPingServer.id)
  else
  end
end})

Tabs.Misc:CreateTextBox({
    Name = "Input Job Id",
    Placeholder = "Job ID",
    ClearOnFocus = true,
    Callback = function(Value)
        getgenv().Job = Value
    end
})

Tabs.Misc:CreateButton({
    Name = "Teleport Job ID",
    Description = "",
    Callback = function()
        if getgenv().Job and getgenv().Job ~= "" then
            game:GetService("TeleportService")
                :TeleportToPlaceInstance(
                    game.PlaceId,
                    getgenv().Job,
                    game.Players.LocalPlayer
                )
        end
    end
})

Tabs.Misc:CreateButton({
Name = "Copy Job ID",
Description = "",
Callback = function()
  setclipboard(tostring(game.JobId))
end})

Tabs.Misc:CreateSection("GUI")
Tabs.Misc:CreateButton({
Name = "Open Awakenings Expert",
Description = "",
Callback = function()
  plr.PlayerGui.Main.AwakeningToggler.Visible = true
end})

Tabs.Misc:CreateButton({
Name = "Open Title Selection",
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("getTitles",true)
  plr.PlayerGui.Main.Titles.Visible = true
end})

DisbleChat = Tabs.Misc:CreateToggle({
Name = "Disable Chat GUI",
Description = "",
Default = false,
Callback = function(Value)
  _G.Rechat = Value
  if _G.Rechat == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)    
  elseif _G.chat == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)    
  end
end
})

DisbleLeaderB = Tabs.Misc:CreateToggle({
Name = "Disable Leader Board GUI",
Description = "",
Default = false,
Callback = function(Value)
  ReLeader = Value
  if ReLeader == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)   
  elseif ReLeader == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)   
  end
end
})

Tabs.Misc:CreateButton({
Name = "Set Pirate Team",
Description = "",
Callback = function()
  Pirates()
end})

Tabs.Misc:CreateButton({
Name = "Set Marine Team",
Description = "",
Callback = function()
  Marines()
end})

UnPortal = Tabs.Misc:CreateToggle({
Name = "Unlock All Portals",
Description = "",
Default = false,
Callback = function(Value)
  _G.PortalUnLock = Value
end})

Tabs.Misc:CreateSection("Boost FPS")
HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
HakiStat = Tabs.Misc:CreateDropdown({
Name = "Select Haki States",
Options = HakiSt,
Callback = function(Value)
  _G.SelectStateHaki = Value
end})

Tabs.Misc:CreateButton({
Name = "ChangeBusoStage",
Description = "",
Callback = function()
  if _G.SelectStateHaki == "State 0" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",0)
  elseif _G.SelectStateHaki == "State 1" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",1)
  elseif _G.SelectStateHaki == "State 2" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",2)
  elseif _G.SelectStateHaki == "State 3" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",3)
  elseif _G.SelectStateHaki == "State 4" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",4)
  elseif _G.SelectStateHaki == "State 5" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",5)
  end
end})

rtxM = Tabs.Misc:CreateToggle({
Name = "Turn on RTX Mode",
Description = "",
Default = false,
Callback = function(Value)
  _G.RTXMode = Value
  local a = game.Lighting
  local c = Instance.new("ColorCorrectionEffect", a)
  local e = Instance.new("ColorCorrectionEffect", a)
  OldAmbient = a.Ambient
  OldBrightness = a.Brightness
  OldColorShift_Top = a.ColorShift_Top
  OldBrightnessc = c.Brightness
  OldContrastc = c.Contrast
  OldTintColorc = c.TintColor
  OldTintColore = e.TintColor    

  if not _G.RTXMode then return end

  while _G.RTXMode do wait()
    a.Ambient = Color3.fromRGB(33, 33, 33)
    a.Brightness = 0.3
    c.Brightness = 0.176
    c.Contrast = 0.39
    c.TintColor = Color3.fromRGB(217, 145, 57)
    game.Lighting.FogEnd = 999
    if not plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
      local a2 = Instance.new("PointLight")
      a2.Parent = plr.Character.HumanoidRootPart
      a2.Range = 15
      a2.Color = Color3.fromRGB(217, 145, 57)
    end
    if not _G.RTXMode then
      a.Ambient = OldAmbient
      a.Brightness = OldBrightness
      a.ColorShift_Top = OldColorShift_Top
      c.Contrast = OldContrastc
      c.Brightness = OldBrightnessc
      c.TintColor = OldTintColorc
      e.TintColor = OldTintColore
      game.Lighting.FogEnd = 2500
      plr.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
    end
  end
end
})

Tabs.Misc:CreateButton({
Name = "Turn on Fast Mode",
Description = "",
Callback = function()
  for _,zx in next, workspace:GetDescendants() do
  if table.find(Past, zx.ClassName) then  zx.Material = "Plastic" end
  end
end})

Tabs.Misc:CreateButton({
Name = "Turn on Low CPU",
Description = "",
Callback = function()
  LowCpu()
end})

Tabs.Misc:CreateButton({
Name = "Turn on increase Boats",
Description = "",
Callback = function()
  for _, v in pairs(workspace.Boats:GetDescendants()) do
    if table.find(ListSeaBoat, v.Name) and tostring(v.Owner.Value) == tostring(plr.Name) then              
      v.VehicleSeat.MaxSpeed = 350
      v.VehicleSeat.Torque = 0.2
      v.VehicleSeat.TurnSpeed = 5
      v.VehicleSeat.HeadsUpDisplay = true
    end
  end
end})

Tabs.Misc:CreateButton({
Name = "Remove Sky Fog",
Description = "",
Callback = function()
  if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
  if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
  if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
end})

Tabs.Misc:CreateSection("Other")
Tabs.Misc:CreateButton({
Name = "Rain Fruits (Client)",
Description = "",
Callback = function()
  for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
    v.Parent = game.Workspace.Map
    v:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
    if v.Fruit:FindFirstChild("AnimationController") then
      v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
    end
    v.Handle.Touched:Connect(function(otherPart)
      if otherPart.Parent == plr.Character then
        v.Parent = plr.Backpack
        plr.Character.Humanoid:EquipTool(v)
      end
    end)
  end
end})

briggt1 = Tabs.Misc:CreateToggle({
Name = "Turn on Full Bright",
Description = "",
Default = false,
Callback = function(Value)
  bright = Value
  if Value == true then
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
  else
    Lighting.Ambient = Color3.new(0, 0, 0)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
  end  
end
})

DayN = Tabs.Misc:CreateDropdown({
Name = "Select Time",
Description = "",
Options = {"Day", "Night"},
Default = Day,
Callback = function(Value)
  _G.SelectDN = Value
end})

dayornight = Tabs.Misc:CreateToggle({
Name = "Turn on Time",
Description = "",
Default = false,
Callback = function(Value)
  _G.daylightN = Value
end})

walkWater = Tabs.Misc:CreateToggle({
Name = "Turn on Walk on Water",
Description = "",
Default = true,
Callback = function(Value)
  _G.WalkWater_Part = Value
  if _G.WalkWater_Part then
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
  else
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
  end
end
})

iceWalk = Tabs.Misc:CreateToggle({
Name = "Turn on Ice Walk",
Description = "",
Default = false,
Callback = function(Value)
  _G.WalkWater = Value
end})

Window:Notify({
  Title = "ARC Hub",
  Description = "ARC Hub comeback",
  Icon = "rbxassetid://78044894473429",
  Duration = 5
})
