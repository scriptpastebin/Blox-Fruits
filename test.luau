loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/Blox-Fruits/refs/heads/main/core.luau"))()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Flen Hub",
    SubTitle = "discord.gg/pKS6qzcaqB",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Info = Window:AddTab({ Title = "Info And Status", Icon = "info" }),
    Main = Window:AddTab({ Title = "Farming", Icon = "sword" }),
    Settings = Window:AddTab({ Title = "Setting", Icon = "settings" }),
    Fish = Window:AddTab({ Title = "Fishing", Icon = "anchor" }),
    Quests = Window:AddTab({ Title = "Quest And Item", Icon = "scroll" }),
    Halloween = Window:AddTab({ Title = "Halloween Event", Icon = "ghost" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "compass" }),
    Race = Window:AddTab({ Title = "Mirage And Race", Icon = "moon" }),
    Prehistoric = Window:AddTab({ Title = "Volcano Event", Icon = "flame" }),
    Esp = Window:AddTab({ Title = "Stats And Esp", Icon = "eye" }),
    Raids = Window:AddTab({ Title = "Fruit And Raid", Icon = "skull" }),
    Combat = Window:AddTab({ Title = "Local Player", Icon = "crosshair" }),
    Travel = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Shop = Window:AddTab({ Title = "Shopping", Icon = "shopping-cart" }),
    Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "more-horizontal" }),
}

Window:SelectTab(1)

-- Hook all Tabs and Sections so AddDropdown automatically triggers Callback with Default value
-- and binds Dropdown:OnChanged(Callback)
local function hookContainer(container)
    local oldAddDropdown = container.AddDropdown
    if oldAddDropdown then
        container.AddDropdown = function(self, id, config)
            local cb = config.Callback
            local default = config.Default
            local values = config.Values or {}
            local dd = oldAddDropdown(self, id, config)
            
            if dd and dd.OnChanged and cb then
                dd:OnChanged(function(v)
                    cb(v)
                end)
            end
            
            -- Resolve initial default value and trigger callback immediately!
            local initialVal
            if dd and dd.Value ~= nil then
                initialVal = dd.Value
            elseif type(default) == "number" and values[default] ~= nil then
                initialVal = values[default]
            else
                initialVal = default
            end
            
            if initialVal ~= nil and cb then
                task.spawn(function()
                    pcall(cb, initialVal)
                end)
            end
            
            return dd
        end
    end
    
    local oldAddSection = container.AddSection
    if oldAddSection then
        container.AddSection = function(self, title)
            local sec = oldAddSection(self, title)
            hookContainer(sec)
            return sec
        end
    end
end

for _, tab in pairs(Tabs) do
    hookContainer(tab)
end

_G.ChooseWP = _G.ChooseWP or "Melee"
_G.SelectedBoat = _G.SelectedBoat or "Guardian"
_G.DangerSc = _G.DangerSc or "Lv 1"
_G.SelectIslandMastery = _G.SelectIslandMastery or "Cake"
getgenv().SelectIslandMastery = getgenv().SelectIslandMastery or "Cake"


-- ====================================================================
-- TAB: INFO AND STATUS
-- ====================================================================

GRP_Info_Status_Server = Tabs.Info:AddSection("Status Server")

local GameTime = GRP_Info_Status_Server:AddParagraph({ Title = "Game Time", Content = "" })

function UpdateGameTime()
    local GameTimeValue = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTimeValue / (60^2)) % 24
    local Minute = math.floor(GameTimeValue / (60^1)) % 60
    local Second = math.floor(GameTimeValue / (60^0)) % 60
    GameTime:SetDesc(Hour.." Hour (h) "..Minute.." Minute (m) "..Second.." Second (s)")
end

spawn(function()
    while true do
        UpdateGameTime()
        wait(1)
    end
end)

local MirageCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Mirage Island", Content = "Status: " })
local previousMirageStatus = ""
spawn(function()
    pcall(function()
        while true do
            wait(1)            
            local mirageIslandExists = game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') ~= nil
            local currentStatus = mirageIslandExists and '✅' or '❌'
            if currentStatus ~= previousMirageStatus then
                MirageCheck:SetDesc('Status: ' .. currentStatus)
                previousMirageStatus = currentStatus
            end
        end
    end)
end)

local KitsuneCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Kitsune Island", Content = "Status: " })
local previousKitsuneStatus = ""
spawn(function()
    while task.wait(1) do
        local currentStatus = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and '✅' or '❌'
        if currentStatus ~= previousKitsuneStatus then
            KitsuneCheck:SetDesc('Status: ' .. currentStatus)
            previousKitsuneStatus = currentStatus
        end
    end
end)

local PrehistoricCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Prehistoric Island", Content = "Status: " })
local previousPrehistoricStatus = ""
task.spawn(function()
    while task.wait(1) do
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and '✅' or '❌'
        if currentStatus ~= previousPrehistoricStatus then
            PrehistoricCheck:SetDesc("Status: " .. currentStatus)
            previousPrehistoricStatus = currentStatus
        end
    end
end)

local FrozenCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Frozen Dimension", Content = "Status: " })
local previousFrozenStatus = ""
spawn(function()
    while wait(1) do
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and '✅' or '❌'
        if currentStatus ~= previousFrozenStatus then
            FrozenCheck:SetDesc('Status: ' .. currentStatus)
            previousFrozenStatus = currentStatus
        end
    end
end)

local RipIndraCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Rip Indra", Content = "Status: " })
local previousRipStatus = ""
spawn(function()
    while wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and '✅' or '❌'
        if currentStatus ~= previousRipStatus then
            RipIndraCheck:SetDesc("Status: " .. currentStatus)
            previousRipStatus = currentStatus
        end
    end
end)

local DoughKingCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Dough King", Content = "Status: " })
local previousDoughStatus = ""
spawn(function()
    while wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and '✅' or '❌'
        if currentStatus ~= previousDoughStatus then
            DoughKingCheck:SetDesc("Status: " .. currentStatus)
            previousDoughStatus = currentStatus
        end
    end
end)

local FullMoonCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Full Moon", Content = "" })
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
            
            FullMoonCheck:SetDesc(moonStatus)
        end)
    end
end)

local LegendarySwordCheck = GRP_Info_Status_Server:AddParagraph({ Title = "Legendary Sword", Content = "Status: " })
spawn(function()
    while wait(1) do
        pcall(function()
            local swordStatus = "Not Found"
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                swordStatus = "Shisui ✅"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                swordStatus = "Wando ✅"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                swordStatus = "Saddi ✅"
            end
            LegendarySwordCheck:SetDesc(swordStatus)
        end)
    end
end)

local CakePrinceStatus = GRP_Info_Status_Server:AddParagraph({ Title = "Cake Prince", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            local cakePrince = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            local killStatus = "Cake Prince: ✅"
            if type(cakePrince) == "string" and string.len(cakePrince) >= 86 then
                local killCount = string.sub(cakePrince, 39, 41)
                killStatus = "Killed: " .. killCount
            end
            CakePrinceStatus:SetDesc(killStatus)
        end)
    end
end)

local BoneCount = GRP_Info_Status_Server:AddParagraph({ Title = "Bone", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            BoneCount:SetDesc("You Have: " .. tostring(bones) .. " Bones")
        end)
    end
end)

-- ====================================================================
-- TAB: FARMING
-- ====================================================================

GRP_Main_Select_Weapon = Tabs.Main:AddSection("Select Weapon")
WeaponDropdown = GRP_Main_Select_Weapon:AddDropdown("Select_Weapon", {
    Title = "Select Weapon", 
    Values = {"Melee","Sword","Blox Fruit","Gun"}, 
    Default = "Melee", 
    Callback = function(v) 
        _G.ChooseWP = v 
    end
})

GRP_Main_Farming = Tabs.Main:AddSection("Farming")

FarmLevel = GRP_Main_Farming:AddToggle("Auto_Farm_Level", {
    Title = "Auto Farm Level", 
    Default = false, 
    Callback = function(Value)
        _G.Level = Value
    end
})

ClosetMons = GRP_Main_Farming:AddToggle("Auto_Farm_Nearest", {
    Title = "Auto Farm Nearest", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFarmNear = Value
    end
})

FactoryRaids = GRP_Main_Farming:AddToggle("Auto_Factory_Raid", {
    Title = "Auto Factory Raid", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFactory = Value
    end
})

CastleRaids = GRP_Main_Farming:AddToggle("Auto_Pirate_Raid", {
    Title = "Auto Pirate Raid", 
    Default = false, 
    Callback = function(Value)
        _G.AutoRaidCastle = Value
    end
})

Ecto = GRP_Main_Farming:AddToggle("Auto_Farm_Ectoplasm", {
    Title = "Auto Farm Ectoplasm", 
    Default = false, 
    Callback = function(Value)
        _G.AutoEctoplasm = Value
    end
})

GRP_Main_Chest = Tabs.Main:AddSection("Chest")

ChestTW = GRP_Main_Chest:AddToggle("Auto_Farm_Chest", {
    Title = "Auto Farm Chest", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFarmChest = Value
    end
})

ChestBP = GRP_Main_Chest:AddToggle("Auto_Chest_Bypass", {
    Title = "Auto Chest Bypass", 
    Default = false, 
    Callback = function(Value)
        _G.AutoChestBP = Value
    end
})

StopI = GRP_Main_Chest:AddToggle("Stop_Items", {
    Title = "Stop Farm for FOD & Chalice", 
    Default = true, 
    Callback = function(Value)
        _G.StopWhenChalice = Value
    end
})

GRP_Main_Collect_Berry = Tabs.Main:AddSection("Berry")

Berry = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry", {
    Title = "Auto Farm Berry", 
    Default = false, 
    Callback = function(Value)
        _G.AutoBerry = Value
    end
})

BerryH = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry_+_Hop", {
    Title = "Auto Farm Berry + Hop", 
    Default = false, 
    Callback = function(Value)
        _G.AutoBerryH = Value
    end
})

GRP_Main_Farm_Mob = Tabs.Main:AddSection("Farm Mob")

if World1 then
    GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
        Title = "Select Mob", 
        Values = {
            "Bandit", "Monkey", "Gorilla", "Pirate", "Brute",
            "Desert Bandit", "Desert Officer", "Snow Bandit", "Snowman",
            "Chief Petty Officer", "Sky Bandit", "Dark Master", "Toga Warrior",
            "Gladiator", "Military Soldier", "Military Spy",
            "Fishman Warrior", "Fishman Commando",
            "God's Guard", "Shanda", "Royal Squad", "Royal Soldier",
            "Galley Pirate", "Galley Captain",
        }, 
        Default = 1, 
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
elseif World2 then
    GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
        Title = "Select Mob", 
        Values = {
            "Raider", "Mercenary", "Swan Pirate", "Factory Staff",
            "Marine Lieutenant", "Marine Captain", "Zombie", "Vampire",
            "Snow Trooper", "Winter Warrior", "Lab Subordinate",
            "Horned Warrior", "Magma Ninja", "Lava Pirate",
            "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer",
            "Arctic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter",
        }, 
        Default = 1, 
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
elseif World3 then
    GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
        Title = "Select Mob", 
        Values = {
            "Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew Archer",
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
        Default = 1, 
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end

GRP_Main_Farm_Mob:AddToggle("Auto_Kill_Mob", {
    Title = "Auto Kill Mob", 
    Default = false, 
    Callback = function(Value)
        _G.AutoKillMob = Value
    end
})

GRP_Main_Farm_All_Island = Tabs.Main:AddSection("Farm Island")

if World1 then
    GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
        Title = "Select Island", 
        Values = {"Pirates", "Marine", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress", "Skylands Lower", "Prison", "Colosseum", "Magma Village", "Underwater City", "Skylands Upper"}, 
        Default = 1, 
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
elseif World2 then
    GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
        Title = "Select Island", 
        Values = {"Kingdom of Rose", "Green Zone", "Graveyard Island", "Snow Mountain", "Hot and Cold (Cold)", "Hot and Cold (Hot)", "Cursed Ship", "Ice Castle", "Forgotten Island"}, 
        Default = 1, 
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
elseif World3 then
    GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
        Title = "Select Island", 
        Values = {"Port Town", "Hydra Island", "Great Tree", "Floating Turtle", "Haunted Castle", "Sea of Treats", "Tiki Outpost", "Submerged Island"}, 
        Default = 1, 
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
end

GRP_Main_Farm_All_Island:AddToggle("Auto_Farm_All_Island", {
    Title = "Auto Farm All Island", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFarmIsland = Value
    end
})

GRP_Main_Farm_Elite_Hunter = Tabs.Main:AddSection("Elite Hunter")

local EliteHunter = GRP_Main_Farm_Elite_Hunter:AddParagraph({ Title = "Elite Hunter", Content = "Status: " })
spawn(function()
    local previousStatus = ""
    while wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or 
                               game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or 
                               game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or 
                               game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '✅' or '❌'
        local progress = replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
        if currentStatus ~= previousStatus then
            EliteHunter:SetDesc("Status: " .. currentStatus .. " | Killed: " .. tostring(progress))
            previousStatus = currentStatus
        end
    end
end)

EliteQ = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite", {
    Title = "Auto Farm Elite", 
    Default = false, 
    Callback = function(v) 
        _G.FarmEliteHunt = v
    end
})

EliteH = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite_+_Hop", {
    Title = "Auto Farm Elite + Hop", 
    Default = false, 
    Callback = function(Value)
        _G.FarmEliteHuntH = Value
    end
})

GRP_Main_Farm_Rip_Indra = Tabs.Main:AddSection("Rip Indra")

GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Attack_Rip_Indra", {
    Title = "Auto Attack Rip Indra", 
    Default = false, 
    Callback = function(Value)
        _G.AttackRipIndra = Value
    end
})

GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Unlocked_Haki", {
    Title = "Auto Unlock Haki", 
    Default = false, 
    Callback = function(Value)
        _G.AutoUnHaki = Value
    end
})

GRP_Main_Farming_Cake = Tabs.Main:AddSection("Cake Prince")

local MobKilled = GRP_Main_Farming_Cake:AddParagraph({ Title = "Cake Prince", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
            if Killed then
                MobKilled:SetDesc("Killed : " .. (500 - (tonumber(Killed) or 0)))
            end
        end)
    end
end)

Cake = GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Cake_Prince", {
    Title = "Auto Farm Cake Prince", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Cake_Prince = Value
    end
})

CakeQ = GRP_Main_Farming_Cake:AddToggle("Accept_Quests", {
    Title = "Accept Quests", 
    Default = false, 
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

CakeSM = GRP_Main_Farming_Cake:AddToggle("Auto_Summon_Cake_Prince", {
    Title = "Auto Summon Cake Prince", 
    Default = false, 
    Callback = function(Value)
        _G.AutoSpawnCP = Value
    end
})

GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King", {
    Title = "Auto Farm Dough King", 
    Default = false, 
    Callback = function(Value)
        _G.AutoAttackDoughKing = Value
    end
})

GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_Fully", {
    Title = "Auto Farm Dough King Fully", 
    Default = false, 
    Callback = function(Value)
        _G.AutoDoughKing = Value
    end
})

GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_Hop", {
    Title = "Auto Farm Dough King + Hop", 
    Default = false, 
    Callback = function(Value)
        _G.AutoHop_Dough = Value
    end
})

GRP_Main_Farming_Bone = Tabs.Main:AddSection("Bone")

local CheckingBone = GRP_Main_Farming_Bone:AddParagraph({ Title = "Bones", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            CheckingBone:SetDesc("You Have: " .. tostring(bones) .. " Bones")
        end)
    end
end)

GRP_Main_Farming_Bone:AddToggle("Auto_Farm_Bone", {
    Title = "Auto Farm Bone", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

BoneQ = GRP_Main_Farming_Bone:AddToggle("Accept_Quests_Bone", {
    Title = "Accept Quests", 
    Default = false, 
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

RanBone = GRP_Main_Farming_Bone:AddToggle("Auto_Random_Bones", {
    Title = "Auto Random Bones", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Random_Bone = Value
    end
})

GRP_Main_Farming_Bone:AddToggle("Auto_Soul_Reaper", {
    Title = "Auto Soul Reaper", 
    Default = false, 
    Callback = function(Value)
        _G.AutoHytHallow = Value
    end
})

Lucky = GRP_Main_Farming_Bone:AddToggle("Auto_Try_Luck_Gravestone", {
    Title = "Auto Try Luck Gravestone", 
    Default = false, 
    Callback = function(Value)
        _G.TryLucky = Value
    end
})

Pray = GRP_Main_Farming_Bone:AddToggle("Auto_Pray_Gravestone", {
    Title = "Auto Pray Gravestone", 
    Default = false, 
    Callback = function(Value)
        _G.Praying = Value
    end
})

GRP_Main_Tyrant_of_the_Skies = Tabs.Main:AddSection("Tyrant of the Skies")

local TyrantStatus = GRP_Main_Tyrant_of_the_Skies:AddParagraph({ Title = "Boss Spawn", Content = "" })
spawn(function()
    pcall(function()
        while wait(1) do
            if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetDesc("✅")
            else
                TyrantStatus:SetDesc("❌")
            end
        end
    end)
end)

local EyeStatus = GRP_Main_Tyrant_of_the_Skies:AddParagraph({ Title = "Eyes Status", Content = "" })

function Check_Eye()
    local ok, e = pcall(function() return workspace.Map.TikiOutpost.IslandModel end)
    if not ok or not e then return 0, false end
    local eyes = {
        e:FindFirstChild("Eye1"),
        e:FindFirstChild("Eye2"),
        e:FindFirstChild("IslandChunks") and e.IslandChunks:FindFirstChild("E") and e.IslandChunks.E:FindFirstChild("Eye3"),
        e:FindFirstChild("IslandChunks") and e.IslandChunks:FindFirstChild("E") and e.IslandChunks.E:FindFirstChild("Eye4")
    }

    local count = 0
    for _, eye in ipairs(eyes) do
        if eye and eye.Transparency ~= 1 then
            count = count + 1
        end
    end
    return count, (count == 4)
end

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local current, full = Check_Eye()
            EyeStatus:SetDesc("Eyes: " .. current .. "/4")
        end)
    end
end)

FarmTyrant = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Farm_Boss_TOTS", {
    Title = "Auto Farm Tyrant of the Skies", 
    Default = false, 
    Callback = function(Value) 
        _G.BossTots = Value 
    end
})

FarmPhaBinh = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Summon_Boss", {
    Title = "Auto Summon Tyrant of the Skies", 
    Default = false, 
    Callback = function(Value)
        _G.PhaBinh = Value
    end
})

GRP_Main_Farm_Material = Tabs.Main:AddSection("Material")

Test = GRP_Main_Farm_Material:AddDropdown("Choose_Material", {
    Title = "Select Material", 
    Values = MaterialList, 
    Default = 1, 
    Callback = function(Value)
        getgenv().SelectMaterial = Value
    end
})

Toggle = GRP_Main_Farm_Material:AddToggle("Auto_Farm_Materials", {
    Title = "Auto Farm Materials", 
    Default = false, 
    Callback = function(Value)
        _G.AutoMaterial = Value
    end
})

GRP_Main_Farm_Boss = Tabs.Main:AddSection("Boss")

BossDropdown = GRP_Main_Farm_Boss:AddDropdown("Select_Boss", {
    Title = "Select Boss", 
    Values = BossList, 
    Default = 1, 
    Callback = function(value)
        _G.FindBoss = value
    end
})

FarmBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_Boss", {
    Title = "Auto Farm Boss", 
    Default = false, 
    Callback = function(value)
        _G.FarmBoss = value
    end
})

BossQ = GRP_Main_Farm_Boss:AddToggle("Accept_Quests_Boss", {
    Title = "Accept Quests", 
    Default = true, 
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

FarmAllBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_All_Boss", {
    Title = "Auto Farm All Boss", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFarmAllBoss = Value
    end
})

GRP_Main_Farming_Mastery = Tabs.Main:AddSection("Mastery")
local posMastery = {"Cake", "Bone"}
local SelectIsland = "Cake"
_G.SelectIslandMastery = "Cake"
getgenv().SelectIslandMastery = "Cake"

local Mastery_Config = GRP_Main_Farming_Mastery:AddDropdown("Choose_Island", {
    Title = "Select Island", 
    Values = posMastery, 
    Default = "Cake", 
    Callback = function(Value)
        SelectIsland = Value
        _G.SelectIslandMastery = Value
        getgenv().SelectIslandMastery = Value
    end
})

_G.MasteryHealthPct = 70
_G.SelectedMasterySkills = {["Z"] = true, ["X"] = true, ["C"] = true, ["V"] = true, ["F"] = true}

GRP_Main_Farming_Mastery:AddSlider("NPC_Health___Switch_to_Weapon", {
    Title = "NPC Health % to Switch Weapon", 
    Min = 10, 
    Max = 95, 
    Default = 70, 
    Rounding = 1, 
    Callback = function(v) 
        _G.MasteryHealthPct = v 
    end
})

GRP_Main_Farming_Mastery:AddDropdown("Select_Skills_to_Use", {
    Title = "Select Skills to Use",
    Values = {"Z", "X", "C", "V", "F", "Y"},
    Multi = true,
    Default = {["Z"] = true, ["X"] = true, ["C"] = true, ["V"] = true, ["F"] = true},
    Callback = function(Value)
        _G.SelectedMasterySkills = Value
    end
})

local MasteryFruits = GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_Fruits", {
    Title = "Auto Mastery Fruits", 
    Default = false, 
    Callback = function(Value)
        _G.FarmMastery_Dev = Value
    end
})

local MasteryGun = GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_Gun", {
    Title = "Auto Mastery Gun", 
    Default = false, 
    Callback = function(Value)
        _G.FarmMastery_G = Value
    end
})

local MasterySword = GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_All_Sword", {
    Title = "Auto Mastery Sword", 
    Default = false, 
    Callback = function(Value)
        _G.FarmMastery_S = Value
    end
})

-- ====================================================================
-- TAB: SETTING
-- ====================================================================

GRP_Settings_Settings_Configure = Tabs.Settings:AddSection("Setting")

Initialize = GRP_Settings_Settings_Configure:AddToggle("Fast_Attack", {
    Title = "Fast Attack", 
    Default = true, 
    Callback = function(Value)
        _G.Seriality = Value
    end
})

Bringmob = GRP_Settings_Settings_Configure:AddToggle("Bring_Mobs", {
    Title = "Bring Mobs", 
    Default = true, 
    Callback = function(Value)
        _B = Value
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Hop_Server_with_time", {
    Title = "Auto Hop Server with time", 
    Default = false, 
    Callback = function(Value)
        _G.AutoHopServer = Value
        if not Value then
            _G.HopTimer = nil
        end
    end
})

GRP_Settings_Settings_Configure:AddSlider("Hop_Delay__Minutes_", {
    Title = "Hop Delay (Minutes)", 
    Min = 5, 
    Max = 120, 
    Default = 30, 
    Rounding = 1, 
    Callback = function(Value)
        _G.HopDelay = Value * 60
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Set_Spawn_Point", {
    Title = "Auto Set Spawn Point", 
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

BusuAura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Buso", {
    Title = "Auto Turn on Buso", 
    Default = true, 
    Callback = function(Value)
        Boud = Value
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Haki_Observation", {
    Title = "Auto Haki Observation", 
    Default = false, 
    Callback = function(Value)
        getgenv().Observation = Value
    end
})

RaceV3Aura = GRP_Settings_Settings_Configure:AddToggle("AutoTurnonRaceV3", {
    Title = "Auto Turn on Race V3", 
    Default = false, 
    Callback = function(Value)
        _G.RaceClickAutov3 = Value
    end
})

RaceV4Aura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Race_V4", {
    Title = "Auto Turn on Race V4", 
    Default = false, 
    Callback = function(Value)
        _G.RaceClickAutov4 = Value
    end
})

RandomAround = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Spin__xyz", {
    Title = "Auto Turn on Spin", 
    Default = false, 
    Callback = function(Value)
        RandomCFrame = Value
    end
})

SafeModes = GRP_Settings_Settings_Configure:AddToggle("Safe_Mode", {
    Title = "Safe Mode", 
    Default = false, 
    Callback = function(Value)
        _G.Safemode = Value
    end
})

DisableHitVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Hit_VFX", {
    Title = "Remove Hit VFX", 
    Default = false, 
    Callback = function(Value)
        _G.DestroyHit = Value
    end
})

RmvVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Death_&_Respawned_VFX", {
    Title = "Remove Death & Respawn VFX", 
    Default = false, 
    Callback = function(Value)
        RDeath = Value
    end
})

DisblesNotify = GRP_Settings_Settings_Configure:AddToggle("Disable_Notify", {
    Title = "Disable Notifications", 
    Default = false, 
    Callback = function(Value)
        RemoveDamage = Value
    end
})

GRP_Settings_Settings_Configure:AddToggle("Anti_AFK", {
    Title = "Anti AFK", 
    Default = true, 
    Callback = function(Value)
        if Value then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Anti_-_Admin_Join_Server", {
    Title = "Auto Hop Server on Admin Join", 
    Default = true, 
    Callback = function(Value)
        getgenv().HopServerAdmin = Value
    end
})

GRP_Settings_Settings_Configure:AddToggle("No_Clip", {
    Title = "No Clip", 
    Default = false, 
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})

-- ====================================================================
-- TAB: FISHING
-- ====================================================================

GRP_Fish_Fishing = Tabs.Fish:AddSection("Fishing")

GRP_Fish_Fishing:AddDropdown("Select_Fishing_Rod", {
    Title = "Select Fishing Rod", 
    Values = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"}, 
    Default = "Fishing Rod", 
    Callback = function(Value)
        _G.SelectedRod = Value
    end
})

BaitDropdown = GRP_Fish_Fishing:AddDropdown("Select_Bait", {
    Title = "Select Bait", 
    Values = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"}, 
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

BuyBaitToggle = GRP_Fish_Fishing:AddToggle("Auto_Buy_Bait", {
    Title = "Auto Buy Bait", 
    Default = false, 
    Callback = function(Value)
        _G.AutoBuyBait = Value
        if Value and _G.SelectedBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

FishingToggle = GRP_Fish_Fishing:AddToggle("Auto_Fishing", {
    Title = "Auto Fishing", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFishing = Value
    end
})

SellFishToggle = GRP_Fish_Fishing:AddToggle("Auto_Sell_Fish", {
    Title = "Auto Sell Fish", 
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

FishingQ = GRP_Fish_Fishing:AddToggle("Auto_Quest_Fishing", {
    Title = "Auto Fishing Quest", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFishingQuest = Value
    end
})

QuestToggle = GRP_Fish_Fishing:AddToggle("Auto_Complete_Quest", {
    Title = "Auto Complete Quest", 
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

SpamSkillZ = GRP_Fish_Fishing:AddToggle("Auto_Spam_Skill_Z", {
    Title = "Auto Spam Skill Z", 
    Default = false, 
    Callback = function(Value)
        _G.AutoSkillZ = Value
    end
})

-- ====================================================================
-- TAB: QUEST AND ITEM
-- ====================================================================
GRP_Quests_Auto_Quest_Sea = Tabs.Quests:AddSection("Auto Sea")

TravelDress = GRP_Quests_Auto_Quest_Sea:AddToggle("Auto_Quest_Sea_2", {
    Title = "Auto Quest Sea 2", 
    Default = false, 
    Callback = function(Value)
        _G.TravelDres = Value
    end
})

Zou = GRP_Quests_Auto_Quest_Sea:AddToggle("Auto_Quest_Sea_3", {
    Title = "Auto Quest Sea 3", 
    Default = false, 
    Callback = function(Value)
        _G.AutoZou = Value
    end
})

GRP_Quests_Tushita_Yama = Tabs.Quests:AddSection("Tushita + Yama")

GRP_Quests_Tushita_Yama:AddToggle("Auto_Tushita_Sword", {
    Title = "Auto Tushita Sword", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Tushita = Value
    end
})

GRP_Quests_Tushita_Yama:AddToggle("Auto_Yama_Sword", {
    Title = "Auto Yama Sword", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Yama = Value
    end
})

GRP_Quests_Skull_Guitars_Misc = Tabs.Quests:AddSection("Skull Guitar")

local CheckSoul = GRP_Quests_Skull_Guitars_Misc:AddParagraph({ Title = "Skull Guitar", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            if Quest1 == true then 
                CheckSoul:SetDesc("Quest Number : Quest1")
            elseif Quest2 == true then 
                CheckSoul:SetDesc("Quest Number : Quest2")
            elseif Quest3 == true then 
                CheckSoul:SetDesc("Quest Number : Quest3")
            elseif Quest4 == true then 
                CheckSoul:SetDesc("Quest Number : Quest4")
            elseif plr.Backpack:FindFirstChild("Skull Guitar") or (plr.Character and plr.Character:FindFirstChild("Skull Guitar")) then 
                CheckSoul:SetDesc("Quest Number : Collect!!")
            else 
                CheckSoul:SetDesc("Quest Number : No Quest!!")
            end
        end)
    end
end)

GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Skull_Guitar", {
    Title = "Auto Skull Guitar", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Soul_Guitar = Value
    end
})

GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Farm_Material_Skull_Guitar", {
    Title = "Auto Farm Material Skull Guitar", 
    Default = false, 
    Callback = function(Value)
        _G.AutoMatSoul = Value
    end
})

GRP_Quests_Cursed_Dual_Katana = Tabs.Quests:AddSection("Cursed Dual Katana")

local CheckCDK = GRP_Quests_Cursed_Dual_Katana:AddParagraph({ Title = "Cursed Dual Katana Quest", Content = "" })
spawn(function()  
    while wait(1) do 
        pcall(function()
            if QuestYama_1 == true then 
                CheckCDK:SetDesc("Quest Numbers : yama quest 1") 
            elseif QuestYama_2 == true then
                CheckCDK:SetDesc("Quest Numbers : yama quest 2") 
            elseif QuestYama_3 == true then
                CheckCDK:SetDesc("Quest Numbers : yama quest 3") 
            elseif QuestTushita_1 == true then
                CheckCDK:SetDesc("Quest Numbers : tushita quest 1") 
            elseif QuestTushita_2 == true then
                CheckCDK:SetDesc("Quest Numbers : tushita quest 2") 
            elseif plr.Backpack:FindFirstChild("Cursed Dual Katana") or (plr.Character and plr.Character:FindFirstChild("Cursed Dual Katana")) then
                CheckCDK:SetDesc("Quest Numbers : CDK done!!")
            end 
        end)
    end
end)

GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Get_CDK_[_Last_Quest_]", {
    Title = "Auto Get CDK Last Quest", 
    Default = false, 
    Callback = function(v)
        _G.CDK = v
    end
})

GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Yama_CDK", {
    Title = "Auto Yama CDK", 
    Default = false, 
    Callback = function(Value)
        _G.CDK_YM = Value
    end
})

GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Tushita_CDK", {
    Title = "Auto Tushita CDK", 
    Default = false, 
    Callback = function(Value)
        _G.CDK_TS = Value
    end
})

GRP_Quests_True_Triple_Katana_Sword = Tabs.Quests:AddSection("True Triple Katana")

GRP_Quests_True_Triple_Katana_Sword:AddButton({Title = "Buy Legendary Sword", Callback = function()
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
end})

GRP_Quests_True_Triple_Katana_Sword:AddButton({Title = "Buy True Triple Katana Sword", Callback = function()
    replicated.Remotes.CommF_:InvokeServer("MysteriousMan","2")
end})

GRP_Quests_True_Triple_Katana_Sword:AddToggle("Tween_to_Legendary_Sword_Dealer", {
    Title = "Tween to Legendary Sword Dealer", 
    Default = false, 
    Callback = function(v) 
        _G.Tp_LgS = v 
    end
})

GRP_Quests_Rengoku_Sword = Tabs.Quests:AddSection("Rengoku")

GRP_Quests_Rengoku_Sword:AddToggle("Auto_Rengoku_Sword", {
    Title = "Auto Rengoku Sword", 
    Default = false, 
    Callback = function(Value)
        _G.IceBossRen = Value
    end
})

GRP_Quests_Rengoku_Sword:AddToggle("Auto_Key_Rengoku", {
    Title = "Auto Key Rengoku", 
    Default = false, 
    Callback = function(Value)
        _G.KeysRen = Value
    end
})

GRP_Quests_Sword = Tabs.Quests:AddSection("Sword")

GRP_Quests_Sword:AddToggle("Auto_Pole_V1", {
    Title = "Auto Pole V1", 
    Default = false, 
    Callback = function(Value)
        _G.AutoPole = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Pole_V2_Beta", {
    Title = "Auto Pole V2 Beta", 
    Default = false, 
    Callback = function(Value)
        _G.AutoPoleV2 = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Saw_Sword", {
    Title = "Auto Saw Sword", 
    Default = false, 
    Callback = function(Value)
        _G.AutoSaw = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Saber_Sword", {
    Title = "Auto Saber Sword", 
    Default = false, 
    Callback = function(Value)
        _G.AutoSaber = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Warden_Sword", {
    Title = "Auto Warden Sword", 
    Default = false, 
    Callback = function(Value)
        _G.WardenBoss = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Long_Sword", {
    Title = "Auto Long Sword", 
    Default = false, 
    Callback = function(Value)
        _G.LongsWord = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Canvendish_Sword", {
    Title = "Auto Cavendish Sword", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Cavender = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Twin_Hooks", {
    Title = "Auto Twin Hooks", 
    Default = false, 
    Callback = function(Value)
        _G.TwinHook = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Bigmom", {
    Title = "Auto Bigmom", 
    Default = false, 
    Callback = function(Value)
        _G.AutoBigmom = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Midnight_Blade", {
    Title = "Auto Midnight Blade", 
    Default = false, 
    Callback = function(Value)
        _G.AutoEcBoss = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Black_Spikey", {
    Title = "Auto Black Spikey", 
    Default = false, 
    Callback = function(Value)
        _G.BlackSpikey = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Dragon_Trident", {
    Title = "Auto Dragon Trident", 
    Default = false, 
    Callback = function(Value)
        _G.AutoTridentW2 = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Bisento_V2", {
    Title = "Auto Bisento V2", 
    Default = false, 
    Callback = function(Value)
        _G.Greybeard = Value
    end
})

GRP_Quests_Sword:AddToggle("Auto_Dark_Blade_V3", {
    Title = "Auto Dark Blade V3", 
    Default = false, 
    Callback = function(Value)
        _G.DarkBladev3 = Value
    end
})

GRP_Quests_Accessories = Tabs.Quests:AddSection("Accessories")

GRP_Quests_Accessories:AddToggle("Auto_Usoap's_Hat", {
    Title = "Auto Usoap's Hat", 
    Default = false, 
    Callback = function(Value)
        _G.AutoGetUsoap = Value
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Marine_Coat", {
    Title = "Auto Marine Coat", 
    Default = false, 
    Callback = function(Value)
        _G.MarinesCoat = Value
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Swan_Coat", {
    Title = "Auto Swan Coat", 
    Default = false, 
    Callback = function(Value)
        _G.SwanCoat = Value
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Swan_Glasses", {
    Title = "Auto Swan Glasses", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_SwanGG = Value
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Lei_Accessory", {
    Title = "Auto Lei Accessory", 
    Default = false, 
    Callback = function(Value)
        _G.AutoKilo = Value
    end
})

GRP_Quests_Gun = Tabs.Quests:AddSection("Gun")

GRP_Quests_Gun:AddToggle("Auto_Serpent_Bow", {
    Title = "Auto Serpent Bow", 
    Default = false, 
    Callback = function(Value)
        _G.AutoSerpentBow = Value
    end
})

GRP_Quests_Other = Tabs.Quests:AddSection("Other")

GRP_Quests_Other:AddToggle("Auto_Cybrog", {
    Title = "Auto Cyborg", 
    Default = false, 
    Callback = function(Value)
        _G.AutoColShad = Value
    end
})

GRP_Quests_Other:AddToggle("Auto_Darkbeard", {
    Title = "Auto Darkbeard", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Def_DarkCoat = Value
    end
})

GRP_Quests_Other:AddToggle("Auto_Unlocked_DonSwan", {
    Title = "Auto Unlocked DonSwan", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_DonAcces = Value
    end
})

GRP_Quests_Other:AddToggle("Auto_Done_Bartilo_Quest", {
    Title = "Auto Done Bartilo Quest", 
    Default = false, 
    Callback = function(Value)
        _G.Bartilo_Quest = Value
    end
})

GRP_Quests_Other:AddToggle("Auto_Done_Citizen_Quest", {
    Title = "Auto Done Citizen Quest", 
    Default = false, 
    Callback = function(Value)
        _G.CitizenQuest = Value
    end
})

GRP_Quests_Other:AddToggle("Auto_Training_Dummy", {
    Title = "Auto Training Dummy", 
    Default = false, 
    Callback = function(Value)
        _G.DummyMan = Value
    end
})

GRP_Quests_Buso_Aura_Colours = Tabs.Quests:AddSection("Haki Color")

GRP_Quests_Buso_Aura_Colours:AddButton({Title = "Buy Buso Colors", Callback = function()
    replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})

GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Rainbow_Colors", {
    Title = "Auto Rainbow Colors", 
    Default = false, 
    Callback = function(v) 
        _G.Auto_Rainbow_Haki = v 
    end
})

GRP_Quests_Buso_Aura_Colours:AddToggle("Accept_Rainbow_Quest_Faster", {
    Title = "Accept Rainbow Quest", 
    Default = false, 
    Callback = function(Value)
        _G.GetQFast = Value
    end
})

GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Teleport_Barista_Cousin", {
    Title = "Auto Teleport Barista Cousin", 
    Default = false, 
    Callback = function(Value)
        _G.Tp_MasterA = Value
    end
})

GRP_Quests_Instinct_Observation = Tabs.Quests:AddSection("Observation")

GRP_Quests_Instinct_Observation:AddToggle("Auto_Farm_Observation", {
    Title = "Auto Farm Observation", 
    Default = false, 
    Callback = function(Value)
        _G.obsFarm = Value
    end
})

GRP_Quests_Instinct_Observation:AddToggle("Auto_Observation_V2", {
    Title = "Auto Observation V2", 
    Default = false, 
    Callback = function(Value)
        _G.AutoKenVTWO = Value
    end
})

GRP_Quests_Fighting_Melee_Styles = Tabs.Quests:AddSection("Fighting Style")

SuperHuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Superhuman", {
    Title = "Auto Superhuman", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_SuperHuman = Value
    end
})

DeathStep = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DeathStep", {
    Title = "Auto DeathStep", 
    Default = false, 
    Callback = function(Value)
        _G.AutoDeathStep = Value
    end
})

SharkManV2 = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Sharkman_Karate", {
    Title = "Auto Sharkman Karate", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_SharkMan_Karate = Value
    end
})

ElectricClaw = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_ElectricClaw", {
    Title = "Auto ElectricClaw", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Electric_Claw = Value
    end
})

DragonTalon = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DragonTalon", {
    Title = "Auto DragonTalon", 
    Default = false, 
    Callback = function(Value)
        _G.AutoDragonTalon = Value
    end
})

Godhuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Godhuman", {
    Title = "Auto Godhuman", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_God_Human = Value
    end
})

SanguineArt = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_SanguineArt", {
    Title = "Auto SanguineArt", 
    Default = false, 
    Callback = function(Value)
        _G.Snaguine = Value
    end
})

-- ====================================================================
-- TAB: HALLOWEEN EVENT
-- ====================================================================

GRP_Halloween_Event = Tabs.Halloween:AddSection("Halloween Event")

GRP_Halloween_Event:AddButton({
    Title = "Copy Arvyn Hub - Halloween",
    Callback = function()
    setclipboard('loadstring(game:HttpGet("https://api.luasentry.com/api/scripts/loader/e664cbd4c071c95381797367d7444a7b.lua"))()')

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Halloween Event",
            Text = "Arvyn Hub copied successfully!",
            Duration = 5
        })
    end
})

-- ====================================================================
-- TAB: SEA EVENT
-- ====================================================================

GRP_SeaEvent_Sea_Event_Setting_Sail = Tabs.SeaEvent:AddSection("Sea Event Setting")
local ListSeaBoat = {"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
local ListSeaZone = {"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}

GRP_SeaEvent_Sea_Event_Setting_Sail:AddButton({Title = "Remove Lighting Effect", Callback = function()
    pcall(function()
        game:GetService("Lighting").BaseAtmosphere:Destroy()
    end)
end})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Ship_Speed_Modifier", {
    Title = "Ship Speed Modifier", 
    Default = false, 
    Callback = function(v) 
        getgenv().SpeedBoat = v 
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddSlider("Ship_Speed", {
    Title = "Ship Speed", 
    Min = 0, 
    Max = 1000, 
    Default = 300, 
    Rounding = 1, 
    Callback = function(Value)
        SetSpeedBoat = Value
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Auto_Press_W", {
    Title = "Auto Press W", 
    Default = false, 
    Callback = function(Value)
        getgenv().AutoPressW = Value
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("No_Clip_Ship", {
    Title = "No Clip Ship", 
    Default = false, 
    Callback = function(Value)
        getgenv().NoClipShip = Value
    end
})

GRP_SeaEvent_Choose_Sea_Event = Tabs.SeaEvent:AddSection("Sea Event")

GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Boats", {
    Title = "Select Boats", 
    Values = ListSeaBoat, 
    Default = 1, 
    Callback = function(v) 
        _G.SelectedBoat = v 
    end
})

_G.SelectedBoat = ListSeaBoat and ListSeaBoat[1] or "Guardian"

GRP_SeaEvent_Choose_Sea_Event:AddButton({Title = "Buy Boats", Callback = function()
    local boatToBuy = _G.SelectedBoat or (ListSeaBoat and ListSeaBoat[1]) or "Guardian"
    replicated.Remotes.CommF_:InvokeServer("BuyBoat", boatToBuy)
end})

GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Sea_Level", {
    Title = "Select Sea Level", 
    Values = ListSeaZone, 
    Default = 1, 
    Callback = function(v) 
        _G.DangerSc = v 
    end
})

GRP_SeaEvent_Choose_Sea_Event:AddToggle("Auto_Sail_Boat", {
    Title = "Auto Sail Boat", 
    Default = false, 
    Callback = function(Value)
        _G.SailBoats = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event = Tabs.SeaEvent:AddSection("Sea Event Entity")

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Shark", {
    Title = "Auto Shark", 
    Default = false, 
    Callback = function(Value)
        _G.Shark = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Piranha", {
    Title = "Auto Piranha", 
    Default = false, 
    Callback = function(Value)
        _G.Piranha = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Terror_Shark", {
    Title = "Auto Terror Shark", 
    Default = false, 
    Callback = function(Value)
        _G.TerrorShark = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Fish_Crew_Member", {
    Title = "Auto Fish Crew Member", 
    Default = false, 
    Callback = function(Value)
        _G.MobCrew = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Haunted_Crew_Member", {
    Title = "Auto Haunted Crew Member", 
    Default = false, 
    Callback = function(Value)
        _G.HCM = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_PirateGrandBrigade", {
    Title = "Auto Attack Pirate Grand Brigade", 
    Default = false, 
    Callback = function(Value)
        _G.PGB = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Fish_Boat", {
    Title = "Auto Attack Fish Boat", 
    Default = false, 
    Callback = function(Value)
        _G.FishBoat = Value
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Sea_Beast", {
    Title = "Auto Attack Sea Beast", 
    Default = false, 
    Callback = function(Value)
        _G.SeaBeast1 = Value
    end
})

GRP_SeaEvent_Crafting_Items = Tabs.SeaEvent:AddSection("Sea Event Crafting")

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft SharkTooth", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "SharkTooth"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft TerrorJaw", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "TerrorJaw"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft SharkAnchor", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "SharkAnchor"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft LeviathanCrown", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "LeviathanCrown"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft LeviathanShield", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "LeviathanShield"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft LeviathanBoat", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "LeviathanBoat"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft LegendaryScroll", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "LegendaryScroll"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Crafting_Items:AddButton({Title = "Craft MythicalScroll", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "MythicalScroll"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_SeaEvent_Kitsune_Island_Event = Tabs.SeaEvent:AddSection("Kitsune Event")

local Check_Kitsu = GRP_SeaEvent_Kitsune_Island_Event:AddParagraph({ Title = "Kitsune Island Status", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
                Check_Kitsu:SetDesc("Kitsune Island : True")
            else
                Check_Kitsu:SetDesc("Kitsune Island : False")
            end
        end)
    end
end)

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Find_Kitsune_Island", {
    Title = "Auto Find Kitsune Island", 
    Default = false, 
    Callback = function(Value)
        _G.AutofindKitIs = Value
    end
})

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Teleport_to_Shrine_Actived", {
    Title = "Auto Teleport to Activated Shrine", 
    Default = false, 
    Callback = function(Value)
        _G.tweenShrine = Value
    end
})

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Collect_Azure_Ember", {
    Title = "Auto Collect Azure Ember", 
    Default = false, 
    Callback = function(Value)
        _G.Collect_Ember = Value
    end
})

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Trade_Azure_Ember", {
    Title = "Auto Trade Azure Ember", 
    Default = false, 
    Callback = function(Value)
        _G.Trade_Ember = Value
    end
})

GRP_SeaEvent_Kitsune_Island_Event:AddButton({Title = "Trade Items Azure", Callback = function()
    replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
end})

GRP_SeaEvent_Kitsune_Island_Event:AddButton({Title = "Talk to Kitsune Statue", Callback = function()
    replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
end})

GRP_SeaEvent_Frozen_Dimension_Event = Tabs.SeaEvent:AddSection("Frozen Dimension")

local FloD = GRP_SeaEvent_Frozen_Dimension_Event:AddParagraph({ Title = "Frozen Dimension", Content = "" })
spawn(function()
    pcall(function()
        while wait(1) do
            if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
                FloD:SetDesc('Frozen Dimension : True')
            else
                FloD:SetDesc('Frozen Dimension : False')
            end
        end
    end)
end)

local SPYING = GRP_SeaEvent_Frozen_Dimension_Event:AddParagraph({ Title = "Spy Status", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
            if spycheck then 
                SPYING:SetDesc("Spy Leviathan : " .. tostring(spycheck))
                if tonumber(spycheck) == 5 then
                    SPYING:SetDesc("Spy Leviathan : Already Done!!")
                end
            end
        end)
    end
end)

GRP_SeaEvent_Frozen_Dimension_Event:AddButton({Title = "Buy Spy", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
end})

GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Teleport_Frozen_Dimension", {
    Title = "Auto Teleport Frozen Dimension", 
    Default = false, 
    Callback = function(v) 
        _G.FrozenTP = v 
    end
})

GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Drive_To_Hydra_Island", {
    Title = "Auto Drive To Hydra Island", 
    Default = false, 
    Callback = function(Value)
        _G.SailBoat_Hydra = Value
    end
})

GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Attack_Leviathan", {
    Title = "Auto Attack Leviathan", 
    Default = false, 
    Callback = function(Value)
        _G.Leviathan1 = Value
    end
})

-- ====================================================================
-- TAB: VOLCANO EVENT (PREHISTORIC)
-- ====================================================================

GRP_Prehistoric_Dojo_Quest = Tabs.Prehistoric:AddSection("Dojo")

GRP_Prehistoric_Dojo_Quest:AddButton({Title = "Teleport To Dragon Dojo", Callback = function()
    replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, -334.9649963378906))
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938) end
end})

DojoQ = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dojo_Trainer", {
    Title = "Auto Dojo Trainer", 
    Default = false, 
    Callback = function(v) 
        _G.Dojoo = v 
    end
})

BlazeEM = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dragon_Hunter", {
    Title = "Auto Dragon Hunter", 
    Default = false, 
    Callback = function(Value)
        _G.FarmBlazeEM = Value
    end
})

GRP_Prehistoric_Drago_Trial = Tabs.Prehistoric:AddSection("Draco Trial")

GRP_Prehistoric_Drago_Trial:AddToggle("Tween_To_Upgrade_Droco_Trial", {
    Title = "Tween To Upgrade Droco Trial", 
    Default = false, 
    Callback = function(Value)
        _G.UPGDrago = Value
    end
})

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V1", {
    Title = "Auto Droco V1", 
    Default = false, 
    Callback = function(Value)
        _G.DragoV1 = Value
    end
})

fireflower = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V2", {
    Title = "Auto Droco V2", 
    Default = false, 
    Callback = function(Value)
        _G.AutoFireFlowers = Value
    end
})

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V3", {
    Title = "Auto Droco V3", 
    Default = false, 
    Callback = function(Value)
        _G.DragoV3 = Value
    end
})

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Relic_Droco_Trial", {
    Title = "Auto Relic Droco Trial", 
    Default = false, 
    Callback = function(Value)
        _G.Relic123 = Value
    end
})

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Train_Droco_v4", {
    Title = "Auto Train Droco v4", 
    Default = false, 
    Callback = function(Value)
        _G.TrainDrago = Value
    end
})

dragoTpVolcano = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_to_Droco_Trials", {
    Title = "Tween to Drago Trials", 
    Default = false, 
    Callback = function(Value)
        _G.TpDrago_Prehis = Value
    end
})

bdrago = GRP_Prehistoric_Drago_Trial:AddToggle("Swap_Droco_Race", {
    Title = "Swap Droco Race", 
    Default = false, 
    Callback = function(Value)
        _G.BuyDrago = Value
    end
})

UpTalon = GRP_Prehistoric_Drago_Trial:AddToggle("Upgrade_Dragon_Talon_With_Uzoth", {
    Title = "Upgrade Dragon Talon With Uzoth", 
    Default = false, 
    Callback = function(Value)
        _G.DT_Uzoth = Value
    end
})

GRP_Prehistoric_Volcanic_Crafting = Tabs.Prehistoric:AddSection("Volcano Crafting")

GRP_Prehistoric_Volcanic_Crafting:AddButton({Title = "Craft Dragonheart", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "Dragonheart"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_Prehistoric_Volcanic_Crafting:AddButton({Title = "Craft Dragonstorm", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "Dragonstorm"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_Prehistoric_Volcanic_Crafting:AddButton({Title = "Craft Dino Hood", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "DinoHood"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_Prehistoric_Volcanic_Crafting:AddButton({Title = "Craft T-Rex Skull", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "Trex"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_Prehistoric_Prehistoric_Island = Tabs.Prehistoric:AddSection("Prehistoric Island")

local Check_Volcano = GRP_Prehistoric_Prehistoric_Island:AddParagraph({ Title = "Prehistoric Island Status", Content = "" })
spawn(function()
    while wait(1) do
        pcall(function()
            if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                Check_Volcano:SetDesc("Prehistoric Island : True")
            else
                Check_Volcano:SetDesc("Prehistoric Island : False")
            end
        end)
    end
end)

GRP_Prehistoric_Prehistoric_Island:AddButton({Title = "Craft Volcanic Magnet", Callback = function()
    local args = {[1] = "CraftItem", [2] = "Craft", [3] = "Magnet"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Craft_Volcanic_Magnet", {
    Title = "Craft Volcanic Magnet", 
    Default = false, 
    Callback = function(v) 
        _G.Prehis_Find = v 
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Find_Prehistoric_Island", {
    Title = "Auto Find Prehistoric Island", 
    Default = false, 
    Callback = function(Value)
        _G.Prehis_Find = Value
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Start_Prehistoric_Event", {
    Title = "Auto Start Prehistoric Event", 
    Default = false, 
    Callback = function(Value)
        _G.AutoStartPrehistoric = Value
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Patch_Prehistoric_Event", {
    Title = "Auto Patch Prehistoric Event", 
    Default = false, 
    Callback = function(Value)
        _G.Prehis_Skills = Value
    end
})

Kaura = GRP_Prehistoric_Prehistoric_Island:AddToggle("Kill_Aura", {
    Title = "Kill Aura", 
    Default = false, 
    Callback = function(Value)
        _G.KillAuraFull = Value
    end
})

VocanDino = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dino_Bones", {
    Title = "Auto Collect Dino Bones", 
    Default = false, 
    Callback = function(Value)
        _G.Prehis_DB = Value
    end
})

VocanEgg = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dragon_Eggs", {
    Title = "Auto Collect Dragon Eggs", 
    Default = false, 
    Callback = function(Value)
        _G.Prehis_DE = Value
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Reset_When_Complete_Volcano", {
    Title = "Auto Reset When Complete Volcano", 
    Default = false, 
    Callback = function(Value)
        _G.ResetPH = Value
    end
})

-- ====================================================================
-- TAB: MIRAGE AND RACE
-- ====================================================================

GRP_Race_Mystic_Island_Full_Moon = Tabs.Race:AddSection("Mirage Island")

local FullMOOn = GRP_Race_Mystic_Island_Full_Moon:AddParagraph({ Title = "Full Moon", Content = "" })
local Ismirage = GRP_Race_Mystic_Island_Full_Moon:AddParagraph({ Title = "Mirage Island", Content = "" })

spawn(function()
    while wait(1) do
        pcall(function()
            if workspace.Map:FindFirstChild("MysticIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                Ismirage:SetDesc("Mirage Island : True")
            else
                Ismirage:SetDesc("Mirage Island : False")
            end
        end)
    end
end)

spawn(function()
    while wait(1) do
        pcall(function()
            local moon8 = "http://www.roblox.com/asset/?id=9709150401"
            local moon7 = "http://www.roblox.com/asset/?id=9709150086"
            local moon6 = "http://www.roblox.com/asset/?id=9709149680"
            local moon5 = "http://www.roblox.com/asset/?id=9709149431"
            local moon4 = "http://www.roblox.com/asset/?id=9709149052"
            local moon3 = "http://www.roblox.com/asset/?id=9709143733"
            local moon2 = "http://www.roblox.com/asset/?id=9709139597"
            local moon1 = "http://www.roblox.com/asset/?id=9709135895"
            local moon = game:GetService("Lighting").Sky.MoonTextureId
            
            if moon == moon1 then
                FullMOOn:SetDesc("Moon : 0 / 8")
            elseif moon == moon2 then
                FullMOOn:SetDesc("Moon : 1 / 8")
            elseif moon == moon3 then
                FullMOOn:SetDesc("Moon : 2 / 8")
            elseif moon == moon4 then
                FullMOOn:SetDesc("Moon : 3 / 8 [ Next Night ]")
            elseif moon == moon5 then
                FullMOOn:SetDesc("Moon : 4 / 8 [ Full Moon ]")
            elseif moon == moon6 then
                FullMOOn:SetDesc("Moon : 5 / 8 [ Last Night ]")
            elseif moon == moon7 then
                FullMOOn:SetDesc("Moon : 6 / 8")
            elseif moon == moon8 then
                FullMOOn:SetDesc("Moon : 7 / 8")
            end
        end)
    end
end)

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Find_Mirage_Island", {
    Title = "Auto Find Mirage Island", 
    Default = false, 
    Callback = function(Value)
        _G.FindMirage = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Esp_Mirage_Island", {
    Title = "Esp Mirage Island", 
    Default = false, 
    Callback = function(Value)
        MirageIslandESP = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Mirage_Island", {
    Title = "Auto Tween To Mirage Island", 
    Default = false, 
    Callback = function(Value)
        _G.AutoMysticIsland = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Highest_Point", {
    Title = "Auto Tween To Highest Point", 
    Default = false, 
    Callback = function(Value)
        _G.HighestMirage = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Gear", {
    Title = "Auto Collect Gear", 
    Default = false, 
    Callback = function(Value)
        _G.TPGEAR = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Change_Transparency_can_see", {
    Title = "Change Transparency can see", 
    Default = false, 
    Callback = function(Value)
        _G.can = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_Advanced_Fruit_Dealer", {
    Title = "Auto Tween Advanced Fruit Dealer", 
    Default = false, 
    Callback = function(Value)
        _G.Addealer = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Mirage_Chest", {
    Title = "Auto Collect Mirage Chest", 
    Default = false, 
    Callback = function(Value)
        _G.FarmChestM = Value
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddButton({Title = "Talk With Stone", Callback = function()
    replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Begin")
    replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
    replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Teleport")
    replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Continue")
end})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Look_At_Moon", {
    Title = "Auto Look At Moon", 
    Default = false, 
    Callback = function(v) 
        _G.LookM = v 
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Look_Moon_+_Auto_V3", {
    Title = "Look Moon + Auto V3", 
    Default = false, 
    Callback = function(Value)
        LookMV3 = Value
    end
})

GRP_Race_Upgrade_Races_V2_And_V3 = Tabs.Race:AddSection("Races V2 And V3")

RaceMink = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Mink", {
    Title = "Auto Upgrade Mink", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Mink = Value
    end
})

RaceHuman = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Human", {
    Title = "Auto Upgrade Human", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Human = Value
    end
})

RaceSky = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Angel", {
    Title = "Auto Upgrade Angel", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Skypiea = Value
    end
})

RaceFish = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_FishMan", {
    Title = "Auto Upgrade FishMan", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Fish = Value
    end
})

GRP_Race_Trials_Quest_V4 = Tabs.Race:AddSection("Trial Race V4")

local CheckTier = GRP_Race_Trials_Quest_V4:AddParagraph({ Title = "Race V4 Tier", Content = "" })
spawn(function()
    pcall(function()
        while wait(1) do
            if plr.Data.Race:FindFirstChild("C") then
                CheckTier:SetDesc("Tiers - V4 : " .. " " .. tostring(plr.Data.Race.C.Value))
            end
        end
    end)
end)

PullLv = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Pull_Lever", {
    Title = "Auto Pull Lever", 
    Default = false, 
    Callback = function(Value)
        _G.Lver = Value
    end
})

Train = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Train_V4", {
    Title = "Auto Train V4", 
    Default = false, 
    Callback = function(Value)
        _G.AcientOne = Value
    end
})

GRP_Race_Trials_Quest_V4:AddButton({Title = "Teleport to Temple of Time", Callback = function()
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875) end
end})

GRP_Race_Trials_Quest_V4:AddButton({Title = "Teleport to Ancient One", Callback = function()
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875) end
end})

GRP_Race_Trials_Quest_V4:AddButton({Title = "Teleport to Ancient Clock", Callback = function()
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875) end
end})

Doors = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Teleport_to_Race_Doors", {
    Title = "Auto Teleport to Race Doors", 
    Default = false, 
    Callback = function(v) 
        _G.TPDoor = v 
    end
})

Trials = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Complete_Trial_Race", {
    Title = "Auto Complete Trial Race", 
    Default = false, 
    Callback = function(Value)
        _G.Complete_Trials = Value
    end
})

AutoKill = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Kill_Player_After_Trial", {
    Title = "Auto Kill Player After Trial", 
    Default = false, 
    Callback = function(Value)
        _G.Defeating = Value
    end
})

-- ====================================================================
-- TAB: STATS AND ESP
-- ====================================================================

GRP_Esp_Stats_Upgrade = Tabs.Esp:AddSection("Stats")

local pSats = 10
StatusSelect = GRP_Esp_Stats_Upgrade:AddSlider("Stats_Value", {
    Title = "Stats Value", 
    Min = 0, 
    Max = 1000, 
    Default = 10, 
    Rounding = 1, 
    Callback = function(Value)
        pSats = Value
    end
})

StatsMelee = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Melee", {
    Title = "Auto Melee", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Melee = Value
    end
})

StatsSword = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Swords", {
    Title = "Auto Sword", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Sword = Value
    end
})

StatsGun = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Gun", {
    Title = "Auto Gun", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Gun = Value
    end
})

StatsFruit = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Blox_Fruit", {
    Title = "Auto Blox Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_DevilFruit = Value
    end
})

StatsDef = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Defense", {
    Title = "Auto Defense", 
    Default = false, 
    Callback = function(Value)
        _G.Auto_Defense = Value
    end
})

GRP_Esp_Esp = Tabs.Esp:AddSection("Esp")

GRP_Esp_Esp:AddToggle("Esp_Berry", {Title = "Esp Berry", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Player", {Title = "Esp Player", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Chest", {Title = "Esp Chest", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Fruit", {Title = "Esp Fruit", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Island", {Title = "Esp Island", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Flower", {Title = "Esp Flower", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Legendary_Sword", {Title = "Esp Legendary Sword", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Haki_Color", {Title = "Esp Haki Color", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Gear", {Title = "Esp Gear", Default = false, Callback = function(Value)
    ESPGear = Value
    if not Value then
      local mysticIsland = workspace.Map:FindFirstChild("MysticIsland")
      if mysticIsland then
          for _,v in pairs(mysticIsland:GetDescendants()) do
              pcall(function()
                  if v:FindFirstChild("NameEsp") then
                      v:FindFirstChild("NameEsp"):Destroy()
                  end
              end)
          end
      end
    else
        task.spawn(function()
            while ESPGear do
                gearEsp()
                task.wait()
            end
        end)
    end
end})

GRP_Esp_Esp:AddToggle("Esp_SeaEvent_Island", {Title = "Esp Sea Event Island", Default = false, Callback = function(Value)
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
end})

GRP_Esp_Esp:AddToggle("Esp_Advanced_Dealer", {Title = "Esp Advanced Dealer", Default = false, Callback = function(Value)
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
end})

-- ====================================================================
-- TAB: FRUIT AND RAID
-- ====================================================================

GRP_Raids_Fruits_Options = Tabs.Raids:AddSection("Fruit")

local function formatNumber(number)
    local str = tostring(number)
    repeat
        local replaced, count = str:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        str = replaced
    until count == 0
    return str
end

local function getFruitStock()
    local resultStr = "Advance Fruit Stock\n"
    local success, advanceFruits = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
    end)

    if not success or not advanceFruits then
        resultStr = resultStr .. "- Error while retrieving data.\n"
    else
        local hasFruit = false
        for _, fruit in pairs(advanceFruits) do
            if fruit.OnSale then
                hasFruit = true
                resultStr = resultStr .. fruit.Name .. " - $" .. formatNumber(fruit.Price) .. "\n"
            end
        end
        if not hasFruit then
            resultStr = resultStr .. "- No fruit.\n"
        end
    end

    resultStr = resultStr .. "\nNormal Fruit Stock\n"
    local success2, normalFruits = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
    end)

    if success2 and normalFruits then
        local hasFruit = false
        for _, fruit in pairs(normalFruits) do
            if fruit.OnSale then
                hasFruit = true
                resultStr = resultStr .. fruit.Name .. " - $" .. formatNumber(fruit.Price) .. "\n"
            end
        end
        if not hasFruit then
            resultStr = resultStr .. "- No fruit.\n"
        end
    else
        resultStr = resultStr .. "- Error while retrieving data.\n"
    end

    return resultStr
end

local stockParagraph = GRP_Raids_Fruits_Options:AddParagraph({ Title = "Loading...", Content = "" })

task.spawn(function()
    while task.wait(60) do
        pcall(function()
            stockParagraph:SetDesc(getFruitStock())
        end)
    end
end)

pcall(function()
    stockParagraph:SetDesc(getFruitStock())
end)

RandomFF = GRP_Raids_Fruits_Options:AddToggle("Auto_Random_Fruit", {
    Title = "Auto Random Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.Random_Auto = Value
        _G.RandomFruitCooldown = nil
    end
})

DropF = GRP_Raids_Fruits_Options:AddToggle("Auto_Drop_Fruit", {
    Title = "Auto Drop Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.DropFruit = Value
    end
})

StoredF = GRP_Raids_Fruits_Options:AddToggle("Auto_Store_Fruit", {
    Title = "Auto Store Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.StoreF = Value
    end
})

TwF = GRP_Raids_Fruits_Options:AddToggle("Auto_Tween_to_Fruit", {
    Title = "Auto Tween to Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.TwFruits = Value
    end
})

BringF = GRP_Raids_Fruits_Options:AddToggle("Auto_Collect_Fruit", {
    Title = "Auto Collect Fruit", 
    Default = false, 
    Callback = function(Value)
        _G.InstanceF = Value
    end
})

GRP_Raids_Fruits_Options:AddDropdown("Select_Fruit_Shop", {
    Title = "Select Fruit Shop", 
    Values = {
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
    Default = 1, 
    Callback = function(Value)
        getgenv().SelectFruit = Value
    end
})

GRP_Raids_Fruits_Options:AddToggle("Auto_Buy_Fruit_Shop", {
    Title = "Auto Buy Fruit Shop", 
    Default = false, 
    Callback = function(Value)
        getgenv().AutoBuyFruitSniper = Value
    end
})

GRP_Raids_Dungeon_Event_Raiding = Tabs.Raids:AddSection("Raid")
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
Q = GRP_Raids_Dungeon_Event_Raiding:AddDropdown("Select_Chip", {Title = "Select Chip", Values = DungeonTables, Default = "", Callback = function(Value)
  _G.SelectChip = Value
end})
Q = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Select_Dungeon_Chip", {Title = "Auto Select Raid Chip", Default = false, Callback = function(Value)
  _G.AutoSelectDungeon = Value
end})
GRP_Raids_Dungeon_Event_Raiding:AddToggle("Get_Fruit_In_Inventory_Below_1M", {Title = "Get Fruit in Inventory Below 1M", Default = false, Callback = function(Value)
  getgenv().AutoGetFruit = Value
end})

GRP_Raids_Dungeon_Event_Raiding:AddButton({Title = "Buy Raid Chips Beli", Callback = function()
  if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end
end})

GRP_Raids_Dungeon_Event_Raiding:AddButton({Title = "Buy Dungeon Chips Devil Fruit", Callback = function()
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

AutoChipBeli = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Beli]", {Title = "Auto Buy Chip Beli", Default = false, Callback = function(Value)
  _G.AutoChipBeli = Value
end})

AutoChipFruit = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Devil_Fruit]", {Title = "Auto Buy Chip Devil Fruit", Default = false, Callback = function(Value)
  _G.AutoChipFruit = Value
end})

StartR = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Start_Raid", {Title = "Auto Start Raid", Default = false, Callback = function(Value)
  _G.Auto_StartRaid = Value
end})

Raiding = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Raid_+_Next_Island", {Title = "Auto Raid + Next Island", Default = false, Callback = function(Value)
  _G.Raiding = Value
end})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Awakening", {Title = "Auto Awakening", Default = false, Callback = function(Value)
  _G.Auto_Awakener = Value
end})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Kill_Aura", {Title = "Kill Aura (Island 4 & 5)", Default = false, Callback = function(Value)
  _G.KillAuraRaid = Value
end})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Teleport_To_Lab", {Title = "Auto Teleport to Lab", Default = false, Callback = function(Value)
  _G.TpLab = Value
  while _G.TpLab do
    wait()
    if _G.TpLab then
      if World2 and _G.TpLab then
        _tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
      elseif World3 and _G.TpLab then
        _tp(CFrame.new(-5046, 314, -2960))
      end
    end
  end
end})

GRP_Raids_Items_Law_Order_Sword = Tabs.Raids:AddSection("Law")

GRP_Raids_Items_Law_Order_Sword:AddButton({Title = "Buy Chip Law", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
end})
GRP_Raids_Items_Law_Order_Sword:AddButton({Title = "Start Law Raids", Callback = function()
  fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
end})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Buy_Microchip_Law", {Title = "Auto Buy Chip Law", Default = false, Callback = function(Value)
  getgenv().AutoBuyMicrochipLaw = Value
end})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Start_Law_Raids", {Title = "Auto Start Law", Default = false, Callback = function(Value)
  getgenv().AutoStartLawRaids = Value
end})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Kill_Law", {Title = "Auto Kill Law", Default = false, Callback = function(Value)
  _G.AutoLawKak = Value
end})

GRP_Raids_Raids_Dungeons = Tabs.Raids:AddSection("Dungeon")

GRP_Raids_Raids_Dungeons:AddToggle("Auto_Farm_Dungeon", {Title = "Auto Farm Dungeon", Default = false, Callback = function(Value)
  _G.AutoFarmDungeon = Value
end})

local FARM_RANGE = 5000

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(1)", {Title = "TP Exit (1)", Default = false, Callback = function(v)
  _G.TPFloor1 = v
end})
local tp1Done = false

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(2)", {Title = "TP Exit (2)", Default = false, Callback = function(v)
  _G.TPFloor2 = v
end})
local tp2Done = false

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(3)", {Title = "TP Exit (3)", Default = false, Callback = function(v)
  _G.TPFloor3 = v
end})
local tp3Done = false

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(4)", {Title = "TP Exit (4)", Default = false, Callback = function(v)
  _G.TPFloor4 = v
end})
local tp4Done = false


-- ====================================================================
-- TAB: LOCAL PLAYER / COMBAT
-- ====================================================================

GRP_Combat_Combat_AimBot = Tabs.Combat:AddSection("Combat")

local __indexPlayer = GRP_Combat_Combat_AimBot:AddParagraph({ Title = "Players on Server", Content = "" })

spawn(function()
    while wait(Sec) do
        pcall(function()
            local playerCount = #game:GetService("Players"):GetPlayers()
            if playerCount == 12 then
                __indexPlayer:SetDesc("All Players : " .. playerCount .. " / 12 [Max]")
            else
                __indexPlayer:SetDesc("All Players : " .. playerCount .. " / 12")
            end
        end)
    end
end)

local __AimBotTurn = GRP_Combat_Combat_AimBot:AddParagraph({ Title = "Aimbot Status", Content = "" })

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
                    __AimBotTurn:SetDesc("Aimbot - " .. Checking_AimStatus() .. " : True")
                else
                    __AimBotTurn:SetDesc("Aimbot - Skills : True")
                end
            else
                __AimBotTurn:SetDesc("Aimbot - Skills : False")
            end
        end)
    end
end)

local PlrList = {}   
for _, v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(PlrList, v.Name)
end

GRP_Combat_Combat_AimBot:AddDropdown("Select_Players", {Title = "Select Players", Values = PlrList, Default = 1, Callback = function(Value)
        _G.PlayersList = Value
    end})

GRP_Combat_Combat_AimBot:AddToggle("Teleport_To_Select_Players", {Title = "Teleport To Select Players", Default = false, Callback = function(Value)
        _G.TpPly = Value
    end})

GRP_Combat_Combat_AimBot:AddToggle("Spectate_Select_Players", {Title = "Spectate Select Players", Default = false, Callback = function(Value)
        SpectatePlys = Value
        spawn(function()
            repeat
                task.wait(0.1)
                if _G.PlayersList and game:GetService("Players"):FindFirstChild(_G.PlayersList) then
                    workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.PlayersList).Character.Humanoid
                end
            until not SpectatePlys
            if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                workspace.Camera.CameraSubject = plr.Character.Humanoid
            end
        end)
    end})

GRP_Combat_Combat_AimBot:AddDropdown("Select_Aim_Method", {Title = "Select Aim Method", Values = {"Aim Player","Nearest Aim"}, Default = 1, Callback = function(Value)
        ABmethod = Value
    end})

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Method_Skills", {Title = "Aimbot Method Skills", Default = false, Callback = function(Value)
        _G.AimMethod = Value
    end})

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Camera_Closet_Players", {Title = "Aimbot Camera Closest Players", Default = false, Callback = function(Value)
        _G.AimCam = Value
    end})

GRP_Combat_Quests_Players = Tabs.Combat:AddSection("Quest Player")

GRP_Combat_Quests_Players:AddButton({Title = "Get Player Quests", Callback = function()
  pcall(function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
  end)
end})

GRP_Combat_Quests_Players:AddToggle("Auto_Get_PlayerQuest", {Title = "Auto Get Player Quest", Default = false, Callback = function(v)
    _G.AutoReceivePlayerQuest = v
end})

GRP_Combat_Quests_Players:AddToggle("Auto_Kill_Player_Quest", {Title = "Auto Kill Player Quest", Default = false, Callback = function(Value)
    _G.AutoPlayerHunter = Value
    if not Value then Useskill = false end
end})

GRP_Combat_Quests_Players:AddToggle("Auto_Enable_PvP", {Title = "Auto Enable PvP", Default = false, Callback = function(Value)
    _G.AutoPvP = Value
end})

GRP_Combat_Quests_Players:AddToggle("Auto_Safe_Mode", {Title = "Auto Safe Mode", Default = false, Callback = function(Value)
    _G.SafeMode = Value
end})

GRP_Combat_LocalPlayer_Settings = Tabs.Combat:AddSection("Local Player Setting")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local flySpeed = 50
local flyConnection
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local bg, bv

local function setupMobileControls()
    local function updateControlsFromJoystick()
        local character = plr.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        local moveDirection = humanoid.MoveDirection
        
        ctrl.f = 0
        ctrl.b = 0
        ctrl.l = 0
        ctrl.r = 0
        
        if moveDirection.Z < -0.1 then
            ctrl.f = 1
        elseif moveDirection.Z > 0.1 then
            ctrl.b = 1
        end
        
        if moveDirection.X < -0.1 then
            ctrl.l = 1
        elseif moveDirection.X > 0.1 then
            ctrl.r = 1
        end
    end
    
    local controlConnection
    controlConnection = RunService.Heartbeat:Connect(function()
        if flying then
            updateControlsFromJoystick()
        else
            if controlConnection then
                controlConnection:Disconnect()
            end
        end
    end)
end

local function toggleFly(value)
    flying = value
    
    if flying then
        if not plr.Character then return end
        
        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        local rootPart
        
        if plr.Character:FindFirstChild("Torso") then
            rootPart = plr.Character.Torso
        else
            rootPart = plr.Character.UpperTorso
        end
        
        if not humanoid or not rootPart then return end
        
        for _, part in ipairs(plr.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Massless = true
            end
        end
        
        local descendantAddedConnection
        descendantAddedConnection = plr.Character.DescendantAdded:Connect(function(descendant)
            if flying and descendant:IsA("BasePart") then
                descendant.CanCollide = false
                descendant.Massless = true
            end
        end)
        
        bg = Instance.new("BodyGyro", rootPart)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = rootPart.CFrame
        
        bv = Instance.new("BodyVelocity", rootPart)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        humanoid.PlatformStand = true
        
        setupMobileControls()
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flying or not plr.Character then
                return
            end
            
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
            
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + 
                              ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - 
                              workspace.CurrentCamera.CoordinateFrame.p)) * flySpeed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = workspace.CurrentCamera.CoordinateFrame
        end)
        
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if plr.Character then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                    part.Massless = false
                end
            end
            
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
        end
        
        ctrl = {f = 0, b = 0, l = 0, r = 0}
    end
end

local function updateFlySpeed(value)
    flySpeed = value
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Enable_Fly", {Title = "Enable Fly", Default = false, Callback = function(Value)
        toggleFly(Value)
    end})

GRP_Combat_LocalPlayer_Settings:AddSlider("Speed_Fly_Mode", {Title = "Speed Fly Mode", Min = 10, Max = 200, Default = 50, Rounding = 1, Callback = function(Value)
        updateFlySpeed(Value)
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Dash_No_Cooldown", {Title = "Dash No Cooldown", Default = false, Callback = function(Value)
        getgenv().DodgeNoCD = Value
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Mink_V3_[_INF_]", {Title = "Instance Mink V3 [ INF ]", Default = false, Callback = function(Value)
        InfAblities = Value
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Energy_[_INF_]", {Title = "Instance Energy [ INF ]", Default = false, Callback = function(Value)
        infEnergy = Value
        if Value then
            getInfinity_Ability("Energy", infEnergy)
        end
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Soru_[_INF_]", {Title = "Instance Soru [ INF ]", Default = false, Callback = function(Value)
        _G.InfSoru = Value
        if Value then
            getInfinity_Ability("Soru", _G.InfSoru)
        end
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Observation_Range_[_INF_]", {Title = "Instance Observation Range [ INF ]", Default = false, Callback = function(Value)
        _G.InfiniteObRange = Value
        if Value then
            getInfinity_Ability("Observation", _G.InfiniteObRange)
        end
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Ignore_Same_Teams", {Title = "Ignore Same Teams", Default = false, Callback = function(Value)
        _G.NoAimTeam = Value
    end})

GRP_Combat_LocalPlayer_Settings:AddToggle("Accept_Allies", {Title = "Accept Allies", Default = false, Callback = function(Value)
        _G.AcceptAlly = Value
    end})

-- ====================================================================
-- TAB: TELEPORT / TRAVEL
-- ====================================================================

GRP_Travel_Travel_Worlds = Tabs.Travel:AddSection("Sea")

GRP_Travel_Travel_Worlds:AddButton({Title = "Travel East Blue (World 1)", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelMain")
end})
GRP_Travel_Travel_Worlds:AddButton({Title = "Travel Dressrosa (World 2)", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
end})
GRP_Travel_Travel_Worlds:AddButton({Title = "Travel Zou (World 3)", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelZou")
end})

GRP_Travel_Travel_Island = Tabs.Travel:AddSection("Island")
Location = {}
for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do  
  table.insert(Location ,v.Name)
end
Travelllll = GRP_Travel_Travel_Island:AddDropdown("Select_Travelling", {Title = "Select Travelling", Values = Location, Default = 1, Callback = function(v) _G.Island = v end})
GoIsland = GRP_Travel_Travel_Island:AddToggle("Auto_Travel", {Title = "Auto Travel", Default = false, Callback = function(Value)
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
end})

GRP_Travel_Travel_Portal = Tabs.Travel:AddSection("Portal")
local Location_Portal = {}
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

PortalTP = GRP_Travel_Travel_Portal:AddDropdown("Select_Portal", {Title = "Select Portal", Values = Location_Portal, Default = 1, Callback = function(Value)
  _G.Island_PT = Value
end})
GRP_Travel_Travel_Portal:AddButton({Title = "Teleport Portal", Callback = function()
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

GRP_Travel_Travel_NPCs = Tabs.Travel:AddSection("NPC")
local NPCList = {}
for _, v in pairs(replicated.NPCs:GetChildren()) do table.insert(NPCList, v.Name) end
NPCsPos = GRP_Travel_Travel_NPCs:AddDropdown("Select_NPCs", {Title = "Select NPCs", Values = NPCList, Default = 1, Callback = function(v) _G.TPNpc = v end})
GoNPCs = GRP_Travel_Travel_NPCs:AddToggle("Auto_Tween_to_NPC", {Title = "Auto Tween to NPC", Default = false, Callback = function(Value)
  _G.TPNpc = Value
end})

-- ====================================================================
-- TAB: SHOPPING
-- ====================================================================

GRP_Shop_Shop_Options = Tabs.Shop:AddSection("Shop")
GRP_Shop_Shop_Options:AddButton({Title = "Buy Buso", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end})
GRP_Shop_Shop_Options:AddButton({Title = "Buy Geppo", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end})
GRP_Shop_Shop_Options:AddButton({Title = "Buy Soru", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end})
GRP_Shop_Shop_Options:AddButton({Title = "Buy Ken", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")
end})

GRP_Shop_Fighting_Style = Tabs.Shop:AddSection("Fighting Style")
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Black Leg", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Electro", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyElectro")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Fishman Karate", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy DragonClaw", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Superhuman", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Death Step", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Sharkman Karate", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy ElectricClaw", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy DragonTalon", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy Godhuman", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
end})
GRP_Shop_Fighting_Style:AddButton({Title = "Buy SanguineArt", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
end})

GRP_Shop_Accessory = Tabs.Shop:AddSection("Accessories")
GRP_Shop_Accessory:AddButton({Title = "Buy Tomoe Ring", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
end})
GRP_Shop_Accessory:AddButton({Title = "Buy Black Cape", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
end})
GRP_Shop_Accessory:AddButton({Title = "Buy Swordsman Hat", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
end})
GRP_Shop_Accessory:AddButton({Title = "Buy Bizarre Rifle", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1)
end})
GRP_Shop_Accessory:AddButton({Title = "Buy Ghoul Mask", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2)
end})

GRP_Shop_Weapon_World1 = Tabs.Shop:AddSection("Weapon")
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Cutlass", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Katana", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Katana")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Iron Mace", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Duel Katana", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Triple Katana", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Pipe", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Pipe")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Dual-Headed Blade", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Bisento", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Soul Cane", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Slingshot", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Musket", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Musket")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Dual Flintlock", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual Flintlock")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Flintlock", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Refined Flintlock", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Cannon", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cannon")
end})
GRP_Shop_Weapon_World1:AddButton({Title = "Buy Kabucha", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
end})

GRP_Shop_Fragments_shop = Tabs.Shop:AddSection("Fragment")
GRP_Shop_Fragments_shop:AddButton({Title = "Buy Refund Stats", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end})
GRP_Shop_Fragments_shop:AddButton({Title = "Buy Reroll Race", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end})
GRP_Shop_Fragments_shop:AddButton({Title = "Buy Ghoul Race", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm"," Change", 4)
end})
GRP_Shop_Fragments_shop:AddButton({Title = "Buy Cyborg Race (2.5k)", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CyborgTrainer"," Buy")
end})

GRP_Shop_Fragments_shop:AddButton({Title = "Buy Draco Race", Callback = function()
  _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
  local targetPosition = Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)
  local character = plr.Character or plr.CharacterAdded:Wait()
  repeat wait() until (character.HumanoidRootPart.Position - targetPosition).Magnitude < 1
  local args = {[1] = {["NPC"] = "Dragon Wizard", ["Command"] = "DragonRace"}}
  replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
end})

-- ====================================================================
-- TAB: MISCELLANEOUS
-- ====================================================================

GRP_Misc_Server_Function = Tabs.Misc:AddSection("Server")
GRP_Misc_Server_Function:AddButton({Title = "Redeem All Codes", Callback = function()
  local codes = {
    "LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK",
    "BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS",
    "SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10",
    "fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE",
    "Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK",
    "Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123",
    "Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie",
    "TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN",
    "ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT",
    "NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"
  }
  local RedeemRemote = replicated:WaitForChild("Remotes"):FindFirstChild("Redeem")
  if not RedeemRemote then return end
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
end})
GRP_Misc_Server_Function:AddButton({Title = "Rejoin Server", Callback = function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})
GRP_Misc_Server_Function:AddButton({Title = "Hop Server", Callback = function()
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
end})
GRP_Misc_Server_Function:AddButton({Title = "Hop to Lowest Players", Callback = function()
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
  local function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
  end
  local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
  until Server
  TPS:TeleportToPlaceInstance(_place,Server.id,plr)
end})

GRP_Misc_Server_Function:AddButton({Title = "Hop to Lowest Pings Server", Callback = function()
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
  local function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
  end
  local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
  until Server
  TPS:TeleportToPlaceInstance(_place,Server.id,plr)
end})

GRP_Misc_Server_Function:AddInput("Input_Job_Id", {Title = "Input Job Id", Default = "", Placeholder = "Job ID", Callback = function(v)
  getgenv().Job = v
end})

GRP_Misc_Server_Function:AddButton({Title = "Teleport Job ID", Callback = function()
  if getgenv().Job and getgenv().Job ~= "" then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getgenv().Job, game.Players.LocalPlayer)
  end
end})
GRP_Misc_Server_Function:AddButton({Title = "Copy Job ID", Callback = function()
  setclipboard(tostring(game.JobId))
end})

GRP_Misc_Player_Gui_Others = Tabs.Misc:AddSection("GUI")

GRP_Misc_Player_Gui_Others:AddButton({Title = "Open Awakenings Expert", Callback = function()
  if plr and plr.PlayerGui and plr.PlayerGui.Main and plr.PlayerGui.Main:FindFirstChild("AwakeningToggler") then
    plr.PlayerGui.Main.AwakeningToggler.Visible = true
  end
end})
GRP_Misc_Player_Gui_Others:AddButton({Title = "Open Title Selection", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("getTitles", true)
  if plr and plr.PlayerGui and plr.PlayerGui.Main and plr.PlayerGui.Main:FindFirstChild("Titles") then
    plr.PlayerGui.Main.Titles.Visible = true
  end
end})
DisbleChat = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Chat_GUI", {Title = "Disable Chat GUI", Default = false, Callback = function(Value)
  _G.Rechat = Value
  local StarterGui = game:GetService("StarterGui")
  if _G.Rechat == true then
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
  else
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
  end
end})
DisbleLeaderB = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Leader_Board_GUI", {Title = "Disable Leader Board GUI", Default = false, Callback = function(Value)
  ReLeader = Value
  local StarterGui = game:GetService("StarterGui")
  if ReLeader == true then
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
  elseif ReLeader == false then
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
  end
end})

GRP_Boost_FPS = Tabs.Misc:AddSection("Boost FPS")

rtxM = GRP_Boost_FPS:AddToggle("Turn_on_RTX_Mode", {Title = "Turn on RTX Mode", Default = false, Callback = function(v)
  _G.RTXMode = v
  local a = game.Lighting
  for _, fx in pairs(a:GetChildren()) do
    if fx.Name == "RTXColorCorrection" or fx.Name == "RTXTint" then
      fx:Destroy()
    end
  end
  if _G.RTXMode then
    local c = Instance.new("ColorCorrectionEffect", a)
    c.Name = "RTXColorCorrection"
    local e = Instance.new("ColorCorrectionEffect", a)
    e.Name = "RTXTint"
    OldAmbient = a.Ambient
    OldBrightness = a.Brightness
    OldColorShift_Top = a.ColorShift_Top
    c.Brightness = 0.176
    c.Contrast = 0.39
    c.TintColor = Color3.fromRGB(217, 145, 57)
    e.TintColor = Color3.fromRGB(217, 145, 57)
    a.FogEnd = 999
    spawn(function()
      while _G.RTXMode do
        wait()
        a.Ambient = Color3.fromRGB(33, 33, 33)
        a.Brightness = 0.3
        if not _G.RTXMode then break end
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and not plr.Character.HumanoidRootPart:FindFirstChild("RTXPointLight") then
          local a2 = Instance.new("PointLight")
          a2.Name = "RTXPointLight"
          a2.Parent = plr.Character.HumanoidRootPart
          a2.Range = 15
          a2.Color = Color3.fromRGB(217, 145, 57)
        end
      end
    end)
  else
    pcall(function()
      if OldAmbient then a.Ambient = OldAmbient end
      if OldBrightness then a.Brightness = OldBrightness end
      if OldColorShift_Top then a.ColorShift_Top = OldColorShift_Top end
      a.FogEnd = 2500
    end)
    for _, fx in pairs(a:GetChildren()) do
      if fx.Name == "RTXColorCorrection" or fx.Name == "RTXTint" then
        fx:Destroy()
      end
    end
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
      local pl = plr.Character.HumanoidRootPart:FindFirstChild("RTXPointLight")
      if pl then pl:Destroy() end
    end
  end
end})
GRP_Boost_FPS:AddButton({Title = "Turn on Fast Mode", Callback = function()
  for _,zx in next, workspace:GetDescendants() do
    if table.find(Past, zx.ClassName) then zx.Material = "Plastic" end
  end
end})
GRP_Boost_FPS:AddButton({Title = "Turn on Low CPU", Callback = function()
  if LowCpu then LowCpu() end
end})
GRP_Boost_FPS:AddButton({Title = "Remove Sky Fog", Callback = function()
  for _, v in pairs(game.Lighting:GetChildren()) do
    if v.Name == "Sky" or v.Name == "LightingLayers" or v.Name == "SeaTerrorCC" or v.Name == "FantasySky" then
      v:Destroy()
    end
  end
end})

GRP_Misc_Configure_God = Tabs.Misc:AddSection("Other")
GRP_Misc_Configure_God:AddButton({Title = "Rain Fruits (Client)", Callback = function()
  for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
    v.Parent = game.Workspace.Map
    v:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
    if v.Fruit:FindFirstChild("AnimationController") then
      v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
    end
    v.Handle.Touched:Connect(function(otherPart)
      if otherPart.Parent == plr.Character then
        v.Parent = plr.Backpack
      end
    end)
  end
end})
briggt1 = GRP_Misc_Configure_God:AddToggle("Turn_on_Full_Bright", {Title = "Turn on Full Bright", Default = false, Callback = function(v)
  _G.SelectDN = v
  if v then
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
  else
    Lighting.Ambient = Color3.new(0, 0, 0)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
  end
end})

GRP_Misc_Configure_God:AddButton({Title = "Increase Boat Speed", Callback = function()
  for _, v in pairs(workspace.Boats:GetDescendants()) do
    if table.find(ListSeaBoat, v.Name) and tostring(v.Owner.Value) == tostring(plr.Name) then
      v.VehicleSeat.MaxSpeed = 350
      v.VehicleSeat.Torque = 0.2
      v.VehicleSeat.TurnSpeed = 5
      v.VehicleSeat.HeadsUpDisplay = true
    end
  end
end})

GRP_Misc_Configure_God:AddButton({Title = "Set Pirate Team", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end})
GRP_Misc_Configure_God:AddButton({Title = "Set Marine Team", Callback = function()
  replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end})
UnPortal = GRP_Misc_Configure_God:AddToggle("Unlock_All_Portals", {Title = "Unlock All Portals", Default = false, Callback = function(Value)
  _G.PortalUnLock = Value
end})

HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
HakiStat = GRP_Misc_Configure_God:AddDropdown("Select_Haki_States", {Title = "Select Haki States", Values = HakiSt, Default = 1, Callback = function(Value)
  _G.SelectStateHaki = Value
end})
GRP_Misc_Configure_God:AddButton({Title = "Change Buso Stage", Callback = function()
  local stageMap = {
    ["State 0"] = 0,
    ["State 1"] = 1,
    ["State 2"] = 2,
    ["State 3"] = 3,
    ["State 4"] = 4,
    ["State 5"] = 5
  }
  local stage = stageMap[_G.SelectStateHaki] or 0
  replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", stage)
end})

DayN = GRP_Misc_Configure_God:AddDropdown("Select_Time", {Title = "Select Time", Values = {"Day", "Night"}, Default = 1, Callback = function(Value)
  _G.SelectDN = Value
end})
dayornight = GRP_Misc_Configure_God:AddToggle("Turn_on_Time", {Title = "Turn on Time", Default = false, Callback = function(Value)
  _G.daylightN = Value
end})
walkWater = GRP_Misc_Configure_God:AddToggle("Turn_on_Walk_on_Water", {Title = "Turn on Walk on Water", Default = true, Callback = function(Value)
  _G.WalkWater_Part = Value
  pcall(function()
    if _G.WalkWater_Part then
      game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
    else
      game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
    end
  end)
end})
iceWalk = GRP_Misc_Configure_God:AddToggle("Turn_on_Ice_Walk", {Title = "Turn on Ice Walk", Default = false, Callback = function(Value)
  _G.WalkWater = Value
end})

Fluent:Notify({
    Title = "Flen Hub",
    Content = "Flen Hub comeback",
    Duration = 8
})
