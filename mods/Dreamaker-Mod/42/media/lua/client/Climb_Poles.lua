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