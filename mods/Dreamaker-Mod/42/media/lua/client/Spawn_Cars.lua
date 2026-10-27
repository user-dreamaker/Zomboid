local SPAWN_CONFIG = {
	["105,8955,0"] = { type = "Base.PickUpTruck", vx = 109, vy = 8952, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["1670,5748,0"] = { type = "Base.PickUpTruck", vx = 1670, vy = 5753, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["1956,10452,0"] = { type = "Base.PickUpTruckLightsRanger", vx = 1973, vy = 10452, vz = 0},
	["2212,13914,0"] = { type = "Base.VanPluggedInElectrics", vx = 2208, vy = 13914, vz = 0},
	["3579,10901,0"] = { type = "Base.PickUpTruck", vx = 3592, vy = 10901, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["4675,8605,0"] = { type = "Base.PickUpTruckLightsRanger", vx = 4687, vy = 8605, vz = 0},
    ["8240,11827,0"] = { type = "Base.PickUpTruck", vx = 8252, vy = 11830, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["10073,9550,0"] = { type = "Base.PickUpTruck", vx = 10110, vy = 9550, vz = 0, color = { 0.333, 0.333, 0.333 }},
    ["10091,8265,0"] = { type = "Base.PickUpTruck", vx = 10083, vy = 8271, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["10333,9649,0"] = { type = "Base.PickUpTruckMccoy", vx = 10356, vy = 9624, vz = 0},
	["10382,10067,0"] = { type = "Base.VanPluggedInElectrics", vx = 10396, vy = 10067, vz = 0},
	["10480,10077,0"] = { type = "Base.PickUpTruck", vx = 10477, vy = 10068, vz = 0, color = { 0.333, 0.333, 0.333 }},
    ["11580,9292,0"] = { type = "Base.SportsCar", vx = 11541, vy = 9306, vz = 0, color = { 0.333, 0.333, 0.333 }},
	["14732,4084,0"] = { type = "Base.VanPluggedInElectrics", vx = 14729, vy = 4084, vz = 0},
}

local VEHICLE_SPAWN_CHANCE = 100
local spawnedForPlayer = {}

local function findPlayerKeyRing(player)
    local inv = player:getInventory()
    local items = inv:getItems()

    for i = 0, items:size() - 1 do
        local item = items:get(i)

        if item:getType() == "KeyRing" or item:hasTag(ItemTag.KEY_RING) then
            return item
        end
    end

    return nil
end

local function spawnVehicleDelayed(playerObj)
    if isClient() then return end
    if not playerObj or spawnedForPlayer[playerObj] then return end

    spawnedForPlayer[playerObj] = true

--	if not (playerObj:hasTrait(CharacterTrait.SUNDAY_DRIVER) or (playerObj:getDescriptor():isCharacterProfession(CharacterProfession.BURGLAR) and playerObj:hasTrait(CharacterTrait.SPEED_DEMON))) then return end 
    if ZombRand(100) >= VEHICLE_SPAWN_CHANCE then return end

    local px = math.floor(playerObj:getX())
    local py = math.floor(playerObj:getY())
    local pz = math.floor(playerObj:getZ())

    local spawnKey = string.format("%d,%d,%d", px, py, pz)
    local config = SPAWN_CONFIG[spawnKey]

    if not config then return end

    local square = getCell():getGridSquare(config.vx, config.vy, config.vz)
    if not square then return end

    local vehicle = addVehicle(config.type, config.vx, config.vy, config.vz)
    if not vehicle then return end

    if config.color then
        vehicle:setColor(config.color[1], config.color[2], config.color[3])
    end

    vehicle:repair()

    local key = vehicle:createVehicleKey()
    if key then
        local inventory = playerObj:getInventory()
        local keyRing = findPlayerKeyRing(playerObj)

        if keyRing then
            keyRing:getItemContainer():AddItem(key)
            keyRing:getItemContainer():AddItem("Base.BottleOpener_Keychain")
        else
            inventory:AddItem(key)
            inventory:AddItem("Base.BottleOpener_Keychain")
        end
    end
end

local function onFirstTick(playerObj)
    spawnVehicleDelayed(playerObj)
    Events.OnTick.Remove(onFirstTick)
end

local function onCreatePlayer(playerIndex, playerObj)
    Events.OnTick.Add(function()
        onFirstTick(playerObj)
    end)
end

Events.OnCreatePlayer.Add(onCreatePlayer)