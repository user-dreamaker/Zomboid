local Jason_Config = {

    KillsRequired = 666,
    SpawnDistance = 6.666,

}

local Jason_Store = {}

Jason_Store.getKills = function(player)
    local data = player:getModData()
    if not data.Jason then data.Jason = { count = 0 } end
    return data.Jason.count
end

Jason_Store.setKills = function(player, count)
    local data = player:getModData()
    if not data.Jason then data.Jason = { count = 0 } end
    data.Jason.count = count
end

local Jason_Manager = {}

Jason_Manager.spawnSpecialZombie = function(player)

    local cell = getCell()
    if not cell then return end

    local x = math.floor(player:getX() + ZombRand(Jason_Config.SpawnDistance * 2) - Jason_Config.SpawnDistance)
    local y = math.floor(player:getY() + ZombRand(Jason_Config.SpawnDistance * 2) - Jason_Config.SpawnDistance)
    local z = player:getZ()

--	addZombiesInOutfit(int x, int y, int z, int totalZombies, String outfit, Integer femaleChance)
    addZombiesInOutfit(x, y, z, 1, "HockeyPsycho", 0)

    local square = cell:getGridSquare(x, y, z)
    if not square then return end

    local movingObjects = square:getMovingObjects()

    for i = 0, movingObjects:size()-1 do
        local obj = movingObjects:get(i)

        if instanceof(obj, "IsoZombie") then
            local zombie = obj

            zombie:setWalkType("sprint2")
			zombie:setHealth(6.666)

            local weaponType = ZombRand(3) == 0 and "Base.Katana" or "nil" or "nil"
            local weapon = instanceItem(weaponType)

            if weapon then
                zombie:getInventory():AddItem(weapon)
                zombie:setAttachedItem("Stomach", weapon)
            end

            zombie:setTarget(player)
            zombie:pathToCharacter(player)
        end
    end

    player:Say("o.o")
end


local function OnZombieDead(zombie)

    local player = getPlayer()
    if not player or player:isDead() then return end

    local killer = zombie:getAttackedBy()

    if killer == player then

        local currentCount = Jason_Store.getKills(player) + 1

        if currentCount >= Jason_Config.KillsRequired then
            Jason_Manager.spawnSpecialZombie(player)
            Jason_Store.setKills(player, 0)
        else
            Jason_Store.setKills(player, currentCount)
        end
    end
end

Events.OnZombieDead.Add(OnZombieDead)