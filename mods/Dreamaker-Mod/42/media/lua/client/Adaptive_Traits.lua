local AdaptiveTraits = {}

local Config = {
    Values = {
        -- Cowardly
        Cowardly_CanLose = true,
        Cowardly_LoseKills = 10,

        -- Adrenaline Junkie
        AdrenalineJunkie_CanGain = true,
        AdrenalineJunkie_GainKills = 50,

        -- Brave
        Brave_CanGain = true,
        Brave_GainKills = 100,

        -- Desensitized
        Desensitized_CanGain = true,
        Desensitized_GainKills = 500,

        -- Axeman
        Axeman_CanGain = true,
        Axeman_GainHours = 40,
        Axeman_GainByLevel = 10,

        -- Angler
        Angler_CanGain = true,
        Angler_GainByLevel = 9,
		
        -- Burglar (Speed Demon)
        Burglar_CanGain = true,
		
        -- Carpenter
        Carpenter_CanGain = true,
		
        -- Construction Worker (Mason)
        Construction_Worker_CanGain = true,
        Construction_Worker_GainByLevel = 8,
		
        -- First Aider (Doctor and Nurse)
        First_Aider_CanGain = true,
        First_Aider_GainByLevel = 9,
		
        -- Mechanics
        Mechanics_CanGain = true,
        Mechanics_GainByLevel = 9,
		
        -- Park Ranger
        Park_Ranger_CanGain = true,
		
        -- Sewer (Tailor)
        Sewer_CanGain = true,
        Sewer_GainByLevel = 9,
		
        -- Target Shooter
        Target_Shooter_CanGain = true,
        Target_Shooter_GainByLevel = 9,

        -- Tinkerer
        Tinkerer_CanGain = true,
        Tinkerer_GainByLevel = 9,
    }
}

--

local Store = {}
Store.getValue = function(player, key, default)
    local data = player:getModData()
    if not data.AdaptiveTraits then data.AdaptiveTraits = {} end
    return data.AdaptiveTraits[key] or default
end

Store.setValue = function(player, key, value)
    local data = player:getModData()
    if not data.AdaptiveTraits then data.AdaptiveTraits = {} end
    data.AdaptiveTraits[key] = value
end

local Utils = {}
Utils.getTraitById = function(traitId)
    local definitions = CharacterTraitDefinition.getTraits()
    for i = 0, definitions:size() - 1 do
        local definition = definitions:get(i)
        local trait = definition:getType()
        if trait:toString() == traitId then return trait end
    end
end

Utils.forceNormalSpeed = function()
    local gt = getGameTime()
    gt:setMultiplier(1.0)

    if UIManager and UIManager.getSpeedControls() then
        UIManager.getSpeedControls():SetCurrentGameSpeed(1)
    end
end

local Notifier = {}
Notifier.notify = function(player, trait, gained, positive)
    local color = positive and HaloTextHelper.getColorGreen() or HaloTextHelper.getColorRed()
    local definition = CharacterTraitDefinition.getCharacterTraitDefinition(trait)

    local symbol = gained and "+" or "-"
    local message = symbol .. " " .. definition:getUIName()

    HaloTextHelper.addTextWithArrow(player, message, positive, color)

    local timeStamp = getTimestamp()
    local lastUpdated = Store.getValue(player, "Notification.LastPlayed", 0)
    if timeStamp - lastUpdated < 5 then return end

    local soundName = positive and "GainExperienceLevel" or "multipleBeep"
    player:playSoundLocal(soundName)
    Store.setValue(player, "Notification.LastPlayed", timeStamp)
end

local Manager = {}
Manager.addTrait = function(player, trait, positive)
    if player:hasTrait(trait) then return end

    Utils.forceNormalSpeed()

    if isClient() then
        sendClientCommand(player, "AdaptiveTraits", "addTrait", {traitId = trait:toString(), positive = positive})
        return
    end
    player:getCharacterTraits():add(trait)
    local definition = CharacterTraitDefinition.getCharacterTraitDefinition(trait)
    local xpBoosts = transformIntoKahluaTable(definition:getXpBoosts())
    local xp = player:getXp()
    for perk, boost in pairs(xpBoosts) do xp:setPerkBoost(perk, boost) end
    local grantedRecipes = definition:getGrantedRecipes()
    local knownRecipes = player:getKnownRecipes()
    for i = 0, grantedRecipes:size() - 1 do
        local recipe = grantedRecipes:get(i)
        if not knownRecipes:contains(recipe) then knownRecipes:add(recipe) end
    end
    if isServer() then
        sendServerCommand(player, "AdaptiveTraits", "traitAdded", {traitId = trait:toString(), positive = positive})
    else
        Notifier.notify(player, trait, true, positive)
    end
end

Manager.removeTrait = function(player, trait, positive)
    if not player:hasTrait(trait) then return end

    Utils.forceNormalSpeed()

    if isClient() then
        sendClientCommand(player, "AdaptiveTraits", "removeTrait", {traitId = trait:toString(), positive = positive})
        return
    end

    player:getCharacterTraits():remove(trait)

    if isServer() then
        sendServerCommand(player, "AdaptiveTraits", "traitRemoved", {traitId = trait:toString(), positive = positive})
    else
        Notifier.notify(player, trait, false, positive)
    end
end

--

local entries = {}

entries.Cowardly = {
    update = function(player)
        if player:getZombieKills() >= Config.Values.Cowardly_LoseKills and Config.Values.Cowardly_CanLose then
            Manager.removeTrait(player, CharacterTrait.COWARDLY, true)
        end
    end,
}

entries.AdrenalineJunkie = {
    update = function(player)
        if player:getZombieKills() >= Config.Values.AdrenalineJunkie_GainKills and Config.Values.AdrenalineJunkie_CanGain then
            if player:hasTrait(CharacterTrait.DESENSITIZED) then return end
            Manager.addTrait(player, CharacterTrait.ADRENALINE_JUNKIE, true)
        end
    end,
}

entries.Brave = {
    update = function(player)
        if player:getZombieKills() >= Config.Values.Brave_GainKills and Config.Values.Brave_CanGain then
            if player:hasTrait(CharacterTrait.DESENSITIZED) then return end
            Manager.addTrait(player, CharacterTrait.BRAVE, true)
        end
    end,
}

entries.Desensitized = {
    update = function(player)
        if player:getZombieKills() >= Config.Values.Desensitized_GainKills and Config.Values.Desensitized_CanGain then
            if player:hasTrait(CharacterTrait.DESENSITIZED) then return end
            Manager.removeTrait(player, CharacterTrait.ADRENALINE_JUNKIE, true)
			Manager.removeTrait(player, CharacterTrait.BRAVE, true)
            Manager.addTrait(player, CharacterTrait.DESENSITIZED, true)
        end
    end,
}

entries.Axeman = {
    update = function(player)
        if not Config.Values.Axeman_CanGain then return end
        if player:getPerkLevel(Perks.Axe) >= Config.Values.Axeman_GainByLevel then
            Manager.addTrait(player, CharacterTrait.AXEMAN, true)
            return
        end
        local actionQueue = ISTimedActionQueue.getTimedActionQueue(player)
        if not actionQueue then return end
        local minutes = Store.getValue(player, "Axeman.Minutes", 0)
        if actionQueue:indexOfType("ISChopTreeAction") == 1 then
            minutes = minutes + 1
            Store.setValue(player, "Axeman.Minutes", minutes)
        end
        if (minutes / 60) >= Config.Values.Axeman_GainHours then
            Manager.addTrait(player, CharacterTrait.AXEMAN, true)
        end
    end,
}

entries.Angler = {
    update = function(player)
        if not Config.Values.Angler_CanGain then return end
        
        if player:hasTrait(CharacterTrait.FISHING) then return end
		
        if player:getPerkLevel(Perks.Fishing) >= Config.Values.Angler_GainByLevel then
            Manager.addTrait(player, CharacterTrait.FISHING, true)
			player:LevelPerk(Perks.Fishing)
            return
        end

		if player:getDescriptor():isCharacterProfession(CharacterProfession.FISHERMAN) then
            Manager.addTrait(player, CharacterTrait.FISHING, true)
			player:LevelPerk(Perks.Fishing)
        end
    end,
}

entries.Burglar = {
    update = function(player)
        if not Config.Values.Burglar_CanGain then return end
        
		if player:getDescriptor():isCharacterProfession(CharacterProfession.BURGLAR) then
            
            if player:hasTrait(CharacterTrait.SUNDAY_DRIVER) then
                Manager.removeTrait(player, CharacterTrait.SUNDAY_DRIVER, true)
            end
			
            if not player:hasTrait(CharacterTrait.SPEED_DEMON) then
                Manager.addTrait(player, CharacterTrait.SPEED_DEMON, true)
            end
        end
    end,
}

entries.Carpenter = {
    update = function(player)
        if not Config.Values.Carpenter_CanGain then return end
        
		if player:getDescriptor():isCharacterProfession(CharacterProfession.CARPENTER) then
            
            if not player:hasTrait(CharacterTrait.CRAFTY) then
                Manager.addTrait(player, CharacterTrait.CRAFTY, true)
            end

            if not player:hasTrait(CharacterTrait.HANDY) then
                Manager.addTrait(player, CharacterTrait.HANDY, true)
                player:LevelPerk(Perks.Carving)
                player:LevelPerk(Perks.Maintenance)
                player:LevelPerk(Perks.Masonry)
                player:LevelPerk(Perks.Woodwork)
            end
        end
    end,
}

entries.Construction_Worker = {
    update = function(player)
        if not Config.Values.Construction_Worker_CanGain then return end
        
        if player:hasTrait(CharacterTrait.MASON) then return end
		
        if player:getPerkLevel(Perks.Masonry) >= Config.Values.Construction_Worker_GainByLevel then
            Manager.addTrait(player, CharacterTrait.MASON, true)
			player:LevelPerk(Perks.Masonry)
			player:LevelPerk(Perks.Masonry)
            return
        end

		if player:getDescriptor():isCharacterProfession(CharacterProfession.CONSTRUCTION_WORKER) then
            Manager.addTrait(player, CharacterTrait.MASON, true)
			player:LevelPerk(Perks.Masonry)
			player:LevelPerk(Perks.Masonry)
        end
    end,
}

entries.First_Aider = {
    update = function(player)
        if not Config.Values.First_Aider_CanGain then return end
        
        if player:hasTrait(CharacterTrait.FIRST_AID) then return end
		
        if player:getPerkLevel(Perks.Doctor) >= Config.Values.First_Aider_GainByLevel then
            Manager.addTrait(player, CharacterTrait.FIRST_AID, true)
			player:LevelPerk(Perks.Doctor)
            return
        end

		if player:getDescriptor():isCharacterProfession(CharacterProfession.DOCTOR) or player:getDescriptor():isCharacterProfession(CharacterProfession.NURSE) then
            Manager.addTrait(player, CharacterTrait.FIRST_AID, true)
			player:LevelPerk(Perks.Doctor)
        end
    end,
}

entries.Mechanics = {
    update = function(player)
        if not Config.Values.Mechanics_CanGain then return end
        
        if player:hasTrait(CharacterTrait.MECHANICS) then return end
		
        if player:getPerkLevel(Perks.Mechanics) >= Config.Values.Mechanics_GainByLevel then
            Manager.addTrait(player, CharacterTrait.MECHANICS, true)
			player:LevelPerk(Perks.Mechanics)
            return
        end
		
		if player:getDescriptor():isCharacterProfession(CharacterProfession.MECHANICS) then
            Manager.addTrait(player, CharacterTrait.MECHANICS, true)
			player:LevelPerk(Perks.Mechanics)
        end
    end,
}

entries.Park_Ranger = {
    update = function(player)
        if not Config.Values.Park_Ranger_CanGain then return end
        
		if player:getDescriptor():isCharacterProfession(CharacterProfession.PARK_RANGER) then
            
            if not player:hasTrait(CharacterTrait.HERBALIST) then
                Manager.addTrait(player, CharacterTrait.HERBALIST, true)
                player:LevelPerk(Perks.PlantScavenging)
            end
            
            if not player:hasTrait(CharacterTrait.HIKER) then
                Manager.addTrait(player, CharacterTrait.HIKER, true)
                player:LevelPerk(Perks.PlantScavenging)
                player:LevelPerk(Perks.Trapping)
            end

            if not player:hasTrait(CharacterTrait.SCOUT) then
                Manager.addTrait(player, CharacterTrait.SCOUT, true)
                player:LevelPerk(Perks.Doctor)
                player:LevelPerk(Perks.PlantScavenging)
                player:LevelPerk(Perks.Fishing)
            end

            if not player:hasTrait(CharacterTrait.WILDERNESS_KNOWLEDGE) then
                Manager.addTrait(player, CharacterTrait.WILDERNESS_KNOWLEDGE, true)
                player:LevelPerk(Perks.PlantScavenging)
                player:LevelPerk(Perks.FlintKnapping)
                player:LevelPerk(Perks.Maintenance)
                player:LevelPerk(Perks.Carving)
            end
        end
    end,
}

entries.Sewer = {
    update = function(player)
        if not Config.Values.Sewer_CanGain then return end
        
        if player:hasTrait(CharacterTrait.TAILOR) then return end
		
        if player:getPerkLevel(Perks.Tailoring) >= Config.Values.Sewer_GainByLevel then
            Manager.addTrait(player, CharacterTrait.TAILOR, true)
			player:LevelPerk(Perks.Tailoring)
            return
        end

		if player:getDescriptor():isCharacterProfession(CharacterProfession.TAILOR) then
            Manager.addTrait(player, CharacterTrait.TAILOR, true)
			player:LevelPerk(Perks.Tailoring)
        end
    end,
}

entries.Target_Shooter = {
    update = function(player)
        if not Config.Values.Target_Shooter_CanGain then return end
        
        if player:hasTrait(CharacterTrait.TARGET_SHOOTER) then return end
		
        if player:getPerkLevel(Perks.Aiming) >= Config.Values.Target_Shooter_GainByLevel then
            Manager.addTrait(player, CharacterTrait.TARGET_SHOOTER, true)
			player:LevelPerk(Perks.Aiming)
            return
        end
    end,
}

entries.Tinkerer = {
    update = function(player)
        if not Config.Values.Tinkerer_CanGain then return end
        
        if player:hasTrait(CharacterTrait.TINKERER) then return end
		
        if player:getPerkLevel(Perks.Maintenance) >= Config.Values.Tinkerer_GainByLevel then
            Manager.addTrait(player, CharacterTrait.TINKERER, true)
			player:LevelPerk(Perks.Maintenance)
            return
        end

		if player:getDescriptor():isCharacterProfession(CharacterProfession.REPAIRMAN) then
            Manager.addTrait(player, CharacterTrait.TINKERER, true)
			player:LevelPerk(Perks.Maintenance)
        end
    end,
}

--

Events.EveryOneMinute.Add(function()
    local player = getPlayer()
    if not player or player:isDead() then return end
    for _, entry in pairs(entries) do
        entry.update(player)
    end
end)

Events.OnServerCommand.Add(function(module, command, args)
    if module ~= "AdaptiveTraits" then return end
    local player = getPlayer()
    local trait = Utils.getTraitById(args.traitId)
    if not trait then return end

    if command == "traitAdded" then
        Notifier.notify(player, trait, true, args.positive)
    elseif command == "traitRemoved" then
        Notifier.notify(player, trait, false, args.positive)
    end
end)