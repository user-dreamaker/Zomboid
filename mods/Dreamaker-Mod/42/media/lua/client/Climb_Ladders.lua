require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISUnequipAction"
require "Vehicles/TimedActions/ISPathFindAction"

if isClient() then
    require "ICLN_ClimbNetworkClient"
end

local LADDER_KEYS = { "ladderN", "ladderS", "ladderE", "ladderW" }

local DIRECTIONS = {
    ladderN = { dir = IsoDirections.N, dx = 0,  dy = -1, alignX = 0.50, alignY = 0.35 },
    ladderS = { dir = IsoDirections.S, dx = 0,  dy = 1,  alignX = 0.55, alignY = 0.70 },
    ladderE = { dir = IsoDirections.E, dx = 1,  dy = 0,  alignX = 0.65, alignY = 0.50 },
    ladderW = { dir = IsoDirections.W, dx = -1, dy = 0,  alignX = 0.35, alignY = 0.65 },
}

local function isSafeFloor(square)
    if not square or square:isSolid() then return false end
    local ok, safe = pcall(function()
        return square:isSolidFloor() or square:getFloor() ~= nil or square:TreatAsSolidFloor()
    end)
    return ok and safe == true
end

local function ladderKeyOf(object)
    if not object then return nil end
    local ok, result = pcall(function()
        local sprite = object:getSprite()
        local props = sprite and sprite:getProperties() or nil
        if not props then return nil end
        for _, key in ipairs(LADDER_KEYS) do
            if props:has(key) then return key end
        end
        return nil
    end)
    return ok and result or nil
end

local function ladderOnSquare(square, requiredKey)
    if not square then return nil, nil end
    local objects = square:getObjects()
    for i = 0, objects:size() - 1 do
        local object = objects:get(i)
        local key = ladderKeyOf(object)
        if key and (not requiredKey or key == requiredKey) then
            return object, key
        end
    end
    return nil, nil
end

local function findNearbyLadder(player)
    local square = player and player:getSquare()
    local cell = getCell()
    if not square or not cell then return nil end

    local best, bestDistance
    local z = square:getZ()
    for dy = -1, 1 do
        for dx = -1, 1 do
            local candidate = cell:getGridSquare(square:getX() + dx, square:getY() + dy, z)
            local object, key = ladderOnSquare(candidate)
            if object then
                local facing = DIRECTIONS[key]
                local alignX = candidate:getX() + (facing and facing.alignX or 0.5)
                local alignY = candidate:getY() + (facing and facing.alignY or 0.5)
                local offsetX = player:getX() - alignX
                local offsetY = player:getY() - alignY
                local distance = offsetX * offsetX + offsetY * offsetY
                if not bestDistance or distance < bestDistance then
                    bestDistance = distance
                    best = { object = object, square = candidate, key = key }
                end
            end
        end
    end
    return best
end

local function isSafeLandingBoundary(cell, ladderX, ladderY, landing)
    if not cell or not landing then return false end
    local edge = cell:getGridSquare(ladderX, ladderY, landing:getZ())
    if not edge then return false end

    local function either(method)
        local ok, result = pcall(function()
            return edge[method](edge, landing) or landing[method](landing, edge)
        end)
        return ok and result == true
    end

    if either("isHoppableTo") then return true end
    if either("isDoorTo") then
        if either("isDoorBlockedTo") or either("isBlockedTo") then return false end
        return true
    end
    if either("isWindowTo") then
        if either("isBlockedTo") then return false end
        return true
    end
    if either("isWallTo") then return false end
    return true
end

local function resolveClimb(player, ladder)
    local cell = getCell()
    if not cell or not ladder then return nil end

    local x, y = ladder.square:getX(), ladder.square:getY()
    local baseZ = ladder.square:getZ()
    local highestZ = baseZ

    for z = baseZ + 1, 7 do
        local square = cell:getGridSquare(x, y, z)
        local object = ladderOnSquare(square, ladder.key)
        if not object then break end
        highestZ = z
    end

    local topZ = highestZ + 1
    if topZ > 7 then return nil end
    local facing = DIRECTIONS[ladder.key]
    if not facing then return nil end

    local landing = cell:getGridSquare(x + facing.dx, y + facing.dy, topZ)
    if not isSafeFloor(landing) then return nil end
    if not isSafeLandingBoundary(cell, x, y, landing) then return nil end

    return {
        ladder = ladder,
        facing = facing,
        startZ = player:getZ(),
        topZ = topZ,
        landing = landing,
        descending = false
    }
end

local function resolveDownClimb(player, preferredLadder)
    local cell = getCell()
    local playerSquare = player and player:getSquare()
    if not cell or not playerSquare then return nil end

    local roofZ = playerSquare:getZ()
    local bestPlan, bestDistance

    for y = playerSquare:getY() - 2, playerSquare:getY() + 2 do
        for x = playerSquare:getX() - 2, playerSquare:getX() + 2 do
            local topSquare = cell:getGridSquare(x, y, roofZ - 1)
            local topObject, key = ladderOnSquare(topSquare)
            if preferredLadder and (not topObject or
                    x ~= preferredLadder.square:getX() or
                    y ~= preferredLadder.square:getY() or
                    key ~= preferredLadder.key) then
                topObject, key = nil, nil
            end
            local facing = key and DIRECTIONS[key] or nil
            if topObject and facing then
                local landingX, landingY = x + facing.dx, y + facing.dy
                local dx = playerSquare:getX() - landingX
                local dy = playerSquare:getY() - landingY
                local landingDistance = dx * dx + dy * dy
                local upperLanding = cell:getGridSquare(landingX, landingY, roofZ)
                local safeBoundary = false
                if landingDistance <= 2 and isSafeFloor(upperLanding) then
                    safeBoundary = isSafeLandingBoundary(cell, x, y, upperLanding)
                end
                if landingDistance <= 2 and isSafeFloor(upperLanding) and safeBoundary then
                    local baseZ = roofZ - 1
                    while baseZ > -32 do
                        local below = cell:getGridSquare(x, y, baseZ - 1)
                        if not ladderOnSquare(below, key) then break end
                        baseZ = baseZ - 1
                    end

                    local bottom = cell:getGridSquare(x, y, baseZ)
                    if isSafeFloor(bottom) then
                        local candidate = {
                            ladder = { object = topObject, square = topSquare, key = key },
                            facing = facing,
                            startZ = player:getZ(),
                            topZ = baseZ,
                            landing = bottom,
                            cancelSquare = upperLanding,
                            cancelZ = roofZ,
                            descending = true,
                        }
                        if not bestDistance or landingDistance < bestDistance then
                            bestPlan, bestDistance = candidate, landingDistance
                        end
                    end
                end
            end
        end
    end
    return bestPlan
end

local function findClickedLadder(worldobjects, player)
    if type(worldobjects) ~= "table" or not player then return nil end
    local playerZ = player:getSquare() and player:getSquare():getZ() or math.floor(player:getZ())
    
    for _, object in ipairs(worldobjects) do
        local square = object and object.getSquare and object:getSquare() or nil
        local key = ladderKeyOf(object)
        if key and square and square:getZ() >= playerZ - 1 and square:getZ() <= playerZ then
            return { object = object, square = square, key = key }
        end
    end
    return nil
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

ICLNFadeTeleportAction = ISBaseTimedAction:derive("ICLNFadeTeleportAction")

function ICLNFadeTeleportAction:isValid()
    return self.character ~= nil and not self.character:isDead() and isSafeFloor(self.plan.landing)
end

function ICLNFadeTeleportAction:start()
    ISBaseTimedAction.start(self)
    
    if self.action then 
        self.action:setBlockMovementEtc(true) 
    end
    
    local playerNum = self.character:getPlayerNum()
    UIManager.FadeOut(playerNum, 0.01)
    
    self.teleported = false
end

function ICLNFadeTeleportAction:update()
    ISBaseTimedAction.update(self)
    
    local progress = self:getJobDelta()
    
    if progress >= 0.5 and not self.teleported then
        self.teleported = true
        
        local targetSquare = self.plan.landing
        local targetX = targetSquare:getX() + 0.5
        local targetY = targetSquare:getY() + 0.5
        local targetZ = targetSquare:getZ()
        
        placeCharacterOnSquare(self.character, targetSquare, targetX, targetY, targetZ)
    end
end

function ICLNFadeTeleportAction:stop()
    local playerNum = self.character:getPlayerNum()
    UIManager.FadeIn(playerNum, 0.33)
    ISBaseTimedAction.stop(self)
end

function ICLNFadeTeleportAction:perform()
    local playerNum = self.character:getPlayerNum()
    UIManager.FadeIn(playerNum, 0.33)
    ISBaseTimedAction.perform(self)
end

function ICLNFadeTeleportAction:new(character, plan)
    local o = ISBaseTimedAction.new(self, character)
    o.plan = plan
    o.stopOnWalk = false
    o.stopOnRun = false
    o.stopOnAim = false
    o.maxTime = 150
    return o
end

local function queueAuthorizedClimb(worldobjects, playerIndex, plan)
    local player = getSpecificPlayer(playerIndex)
    if not player or not plan then return end

    ISTimedActionQueue.clear(player)

    local primary = player:getPrimaryHandItem()
    local secondary = player:getSecondaryHandItem()

    if primary then
        ISTimedActionQueue.add(ISUnequipAction:new(player, primary, 20))
    end
    if secondary and secondary ~= primary then
        ISTimedActionQueue.add(ISUnequipAction:new(player, secondary, 20))
    end

    ISTimedActionQueue.add(ICLNFadeTeleportAction:new(player, plan))
end

local function beginClimb(worldobjects, playerIndex, plan)
    local player = getSpecificPlayer(playerIndex)
    if not player or not plan then return end
    queueAuthorizedClimb(worldobjects, playerIndex, plan)
end

local function addClimbOption(playerIndex, context, worldobjects)
    local player = getSpecificPlayer(playerIndex)
    local clickedLadder = findClickedLadder(worldobjects, player)
    
    local downPlan = resolveDownClimb(player, clickedLadder)
    local ladder = clickedLadder or findNearbyLadder(player)
    local upPlan = ladder and resolveClimb(player, ladder) or nil

    if upPlan then
        context:addOption(getText("UI_ServerSettings_ButtonMoveUp"), worldobjects, beginClimb, playerIndex, upPlan)
    end

    if downPlan then
        context:addOption(getText("UI_ServerSettings_ButtonMoveDown"), worldobjects, beginClimb, playerIndex, downPlan)
    end
end

Events.OnFillWorldObjectContextMenu.Add(addClimbOption)

local function onInteractKeyStarted(key)
    local core = getCore()
    if core:isKey("Interact", key) then
        local player = getPlayer()
        if not player or player:isDead() or player:getVehicle() or player:isAiming() then return end
        
        local queue = ISTimedActionQueue.getTimedActionQueue(player)
        if queue and queue.current then return end

        local plan = resolveDownClimb(player)
        if not plan then
            local nearbyLadder = findNearbyLadder(player)
            if nearbyLadder then plan = resolveClimb(player, nearbyLadder) end
        end
        
        if plan then
            GameKeyboard.eatKeyPress(key)
            beginClimb(nil, player:getPlayerNum(), plan)
            return
        end
    end
end

Events.OnKeyStartPressed.Add(onInteractKeyStarted)

if isClient() then
    ICLNClientNetwork = ICLNClientNetwork or {}
    ICLNClientNetwork.pending = ICLNClientNetwork.pending or {}
    ICLNClientNetwork.sequence = ICLNClientNetwork.sequence or 0
    ICLNClientNetwork.sessions = ICLNClientNetwork.sessions or {}
    ICLNClientNetwork.authorizations = ICLNClientNetwork.authorizations or {}
    ICLNClientNetwork.pendingMotion = ICLNClientNetwork.pendingMotion or {}

    function ICLNClientNetwork.cancel(player, sessionId, reason)
        if not player or not ICLNNetwork.isValidSessionId(sessionId) then return false end
        sendClientCommand(player, ICLNNetwork.MODULE, ICLNNetwork.CLIENT.CANCEL, {
            protocol = ICLNNetwork.PROTOCOL_VERSION,
            sessionId = sessionId,
            reason = tostring(reason or "client-action-stopped"),
        })
        return true
    end

    function ICLNClientNetwork.hasLocalSession(player)
        if not player then return false end
        local playerId = player:getOnlineID()
        for _, pending in pairs(ICLNClientNetwork.pending) do
            if pending.playerId == playerId then return true end
        end
        for _, authorization in pairs(ICLNClientNetwork.authorizations) do
            if authorization.playerId == playerId then return true end
        end
        for _, session in pairs(ICLNClientNetwork.sessions) do
            if session.playerId == playerId then return true end
        end
        return false
    end
end