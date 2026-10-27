--[[
local Poles = {}

Poles.poleTiles = {
    ["recreational_sports_01_32"] = true,
    ["recreational_sports_01_33"] = true,
}

function Poles.isNear(player, targetSquare)
    local dist = math.sqrt(
        math.pow(player:getX() - targetSquare:getX(), 2) +
        math.pow(player:getY() - targetSquare:getY(), 2)
    )
    return dist <= 1
end

function Poles.doTeleport(player, object, isUp)

    if not Poles.isNear(player, object:getSquare()) then
        return
    end

    local sq = object:getSquare()
    local x = sq:getX()
    local y = sq:getY()
    local z = math.floor(player:getZ())

    local targetZ = z

    if isUp then
        targetZ = z + 1
    else
        targetZ = z - 1
    end

    local targetSquare = getSquare(x, y, targetZ)

    if not targetSquare then
        return
    end

    UIManager.FadeOut(player:getPlayerNum(), 0.33)

    local timer = 33

    local function process()
        timer = timer - 1

        if timer <= 0 then
            player:setX(x + 0.5)
            player:setY(y + 0.5)
            player:setZ(targetZ)
            player:setCurrent(targetSquare)

            UIManager.FadeIn(player:getPlayerNum(), 0.33)

            Events.OnTick.Remove(process)
        end
    end

    Events.OnTick.Add(process)
end

Events.OnFillWorldObjectContextMenu.Add(function(playerNum, context, worldobjects, test)

    if test then return end

    local player = getSpecificPlayer(playerNum)
    local poleObj = nil

    for _, obj in ipairs(worldobjects) do
        local sprite = obj:getSprite()

        if sprite and sprite:getName() and Poles.poleTiles[sprite:getName()] then
            poleObj = obj
            break
        end
    end

    if poleObj and Poles.isNear(player, poleObj:getSquare()) then

        local pZ = math.floor(player:getZ())

        if pZ == 0 then
            if player:getDescriptor():isCharacterProfession(CharacterProfession.FIRE_OFFICER) or player:hasTrait(CharacterTrait.STRONG) or player:getPerkLevel(Perks.Strength) >= 10 then
                context:addOption(getText("UI_ServerSettings_ButtonMoveUp"), player, Poles.doTeleport, poleObj, true)
            end
        elseif pZ == 1 then
            context:addOption(getText("UI_ServerSettings_ButtonMoveDown"), player, Poles.doTeleport, poleObj, false)
        end

    end

end)

return Poles
--]]
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISUnequipAction"

local POLE_SPRITES = {
    ["recreational_sports_01_32"] = true,
    ["recreational_sports_01_33"] = true,
}

local MAX_Z = 7

local function canClimbUp(player)
    if not player then return false end
    local ok, result = pcall(function()
        return player:getDescriptor():isCharacterProfession(CharacterProfession.FIRE_OFFICER)
            or player:hasTrait(CharacterTrait.STRONG)
            or player:getPerkLevel(Perks.Strength) >= 10
    end)
    return ok and result == true
end

local function isSafeFloor(square)
    if not square then return false end
    local ok, safe = pcall(function()
        return square:isSolidFloor() or square:getFloor() ~= nil or square:TreatAsSolidFloor()
    end)
    return ok and safe == true
end

local function isPole(object)
    if not object then return false end
    local ok, result = pcall(function()
        local name = object:getSpriteName()
        if not name then
            local sprite = object:getSprite()
            name = sprite and sprite:getName() or nil
        end
        return name ~= nil and POLE_SPRITES[name] == true
    end)
    return ok and result == true
end

local function poleOnSquare(square)
    if not square then return nil end
    local objects = square:getObjects()
    for i = 0, objects:size() - 1 do
        local object = objects:get(i)
        if isPole(object) then return object end
    end
    return nil
end

local function findNearbyPole(player)
    local square = player and player:getSquare()
    local cell = getCell()
    if not square or not cell then return nil end

    local best, bestDistance
    local z = square:getZ()
    for dy = -1, 1 do
        for dx = -1, 1 do
            local candidate = cell:getGridSquare(square:getX() + dx, square:getY() + dy, z)
            local object = poleOnSquare(candidate)
            if object then
                local ox = player:getX() - (candidate:getX() + 0.5)
                local oy = player:getY() - (candidate:getY() + 0.5)
                local distance = ox * ox + oy * oy
                if not bestDistance or distance < bestDistance then
                    bestDistance = distance
                    best = { object = object, square = candidate }
                end
            end
        end
    end
    return best
end

local function findClickedPole(worldobjects, player)
    if type(worldobjects) ~= "table" or not player then return nil end
    local playerZ = player:getSquare() and player:getSquare():getZ() or math.floor(player:getZ())

    for _, object in ipairs(worldobjects) do
        local square = object and object.getSquare and object:getSquare() or nil
        if square and isPole(object) and square:getZ() >= playerZ - 1 and square:getZ() <= playerZ then
            return { object = object, square = square }
        end
    end
    return nil
end

local function resolveClimb(player, pole)
    local cell = getCell()
    if not cell or not pole then return nil end

    local x, y = pole.square:getX(), pole.square:getY()
    local baseZ = pole.square:getZ()
    local highestZ = baseZ

    for z = baseZ + 1, MAX_Z do
        if not poleOnSquare(cell:getGridSquare(x, y, z)) then break end
        highestZ = z
    end

    local topZ = highestZ
    if topZ <= baseZ or topZ > MAX_Z then return nil end

    local landing = cell:getGridSquare(x, y, topZ)
    if not isSafeFloor(landing) then return nil end

    return {
        pole = pole,
        startZ = player:getZ(),
        topZ = topZ,
        landing = landing,
        descending = false,
    }
end

local function resolveDownClimb(player, preferredPole)
    local cell = getCell()
    local playerSquare = player and player:getSquare()
    if not cell or not playerSquare then return nil end

    local roofZ = playerSquare:getZ()
    local bestPlan, bestDistance

    for y = playerSquare:getY() - 1, playerSquare:getY() + 1 do
        for x = playerSquare:getX() - 1, playerSquare:getX() + 1 do
            local topSquare = cell:getGridSquare(x, y, roofZ)
            local topObject = poleOnSquare(topSquare)

            if topObject and preferredPole and
                    (x ~= preferredPole.square:getX() or y ~= preferredPole.square:getY()) then
                topObject = nil
            end

            if topObject then
                local baseZ = roofZ
                while baseZ > -32 do
                    if not poleOnSquare(cell:getGridSquare(x, y, baseZ - 1)) then break end
                    baseZ = baseZ - 1
                end

                local bottom = cell:getGridSquare(x, y, baseZ)
                local dx = playerSquare:getX() - x
                local dy = playerSquare:getY() - y
                local distance = dx * dx + dy * dy

                if baseZ < roofZ and isSafeFloor(bottom) and (not bestDistance or distance < bestDistance) then
                    bestPlan = {
                        pole = { object = topObject, square = topSquare },
                        startZ = player:getZ(),
                        topZ = baseZ,
                        landing = bottom,
                        descending = true,
                    }
                    bestDistance = distance
                end
            end
        end
    end
    return bestPlan
end

local function setCharacterPosition(character, x, y, z)
    character:setX(x)
    character:setY(y)
    character:setZ(z)
    if character.setLx then pcall(function() character:setLx(x) end) end
    if character.setLy then pcall(function() character:setLy(y) end) end
    if character.setLz then pcall(function() character:setLz(z) end) end
end

local function placeCharacterOnSquare(character, square, x, y, z)
    setCharacterPosition(character, x, y, z)
    if square and character.setCurrentSquare then
        character:setCurrentSquare(square)
    end
end

CPFadeTeleportAction = ISBaseTimedAction:derive("CPFadeTeleportAction")

function CPFadeTeleportAction:isValid()
    if not self.character or self.character:isDead() then return false end
    if not self.plan.descending and not canClimbUp(self.character) then return false end
    return isSafeFloor(self.plan.landing)
end

function CPFadeTeleportAction:start()
    ISBaseTimedAction.start(self)

    if self.action then
        self.action:setBlockMovementEtc(true)
    end

    UIManager.FadeOut(self.character:getPlayerNum(), 0.01)
    self.teleported = false
end

function CPFadeTeleportAction:update()
    ISBaseTimedAction.update(self)

    if self:getJobDelta() >= 0.5 and not self.teleported then
        self.teleported = true

        local target = self.plan.landing
        placeCharacterOnSquare(self.character, target,
            target:getX() + 0.5, target:getY() + 0.5, target:getZ())
    end
end

function CPFadeTeleportAction:stop()
    UIManager.FadeIn(self.character:getPlayerNum(), 0.33)
    ISBaseTimedAction.stop(self)
end

function CPFadeTeleportAction:perform()
    UIManager.FadeIn(self.character:getPlayerNum(), 0.33)
    ISBaseTimedAction.perform(self)
end

function CPFadeTeleportAction:new(character, plan)
    local o = ISBaseTimedAction.new(self, character)
    o.plan = plan
    o.stopOnWalk = false
    o.stopOnRun = false
    o.stopOnAim = false
    o.maxTime = 150
    return o
end

local function queueClimb(playerIndex, plan)
    local player = getSpecificPlayer(playerIndex)
    if not player or not plan then return end
    if not plan.descending and not canClimbUp(player) then return end

    ISTimedActionQueue.clear(player)

    local primary = player:getPrimaryHandItem()
    local secondary = player:getSecondaryHandItem()

    if primary then
        ISTimedActionQueue.add(ISUnequipAction:new(player, primary, 20))
    end
    if secondary and secondary ~= primary then
        ISTimedActionQueue.add(ISUnequipAction:new(player, secondary, 20))
    end

    ISTimedActionQueue.add(CPFadeTeleportAction:new(player, plan))
end

local function beginClimb(worldobjects, playerIndex, plan)
    queueClimb(playerIndex, plan)
end

local function addPoleOption(playerIndex, context, worldobjects)
    local player = getSpecificPlayer(playerIndex)
    if not player then return end

    local clickedPole = findClickedPole(worldobjects, player)
    local downPlan = resolveDownClimb(player, clickedPole)
    local pole = clickedPole or findNearbyPole(player)
    local upPlan = pole and resolveClimb(player, pole) or nil

    if upPlan then
        local label = getText("UI_ServerSettings_ButtonMoveUp")
        local option = context:addOption(label, worldobjects, beginClimb, playerIndex, upPlan)
        if not canClimbUp(player) then
            option.notAvailable = true
        end
    end

    if downPlan then
        context:addOption(getText("UI_ServerSettings_ButtonMoveDown"), worldobjects, beginClimb, playerIndex, downPlan)
    end
end

Events.OnFillWorldObjectContextMenu.Add(addPoleOption)

local function onInteractKeyStarted(key)
    if not getCore():isKey("Interact", key) then return end

    local player = getPlayer()
    if not player or player:isDead() or player:getVehicle() or player:isAiming() then return end

    local queue = ISTimedActionQueue.getTimedActionQueue(player)
    if queue and queue.current then return end

    local plan = resolveDownClimb(player)
    if not plan and canClimbUp(player) then
        local nearbyPole = findNearbyPole(player)
        if nearbyPole then plan = resolveClimb(player, nearbyPole) end
    end

    if plan then
        GameKeyboard.eatKeyPress(key)
        beginClimb(nil, player:getPlayerNum(), plan)
    end
end

Events.OnKeyStartPressed.Add(onInteractKeyStarted)
