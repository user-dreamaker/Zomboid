local driverVehicleByChar = {}

local function onEnter(character)
    if not character then return end
    local vehicle = character:getVehicle()
    if not vehicle then return end
    if vehicle:getDriver() ~= character then return end
    if not character:hasTrait(CharacterTrait.SUNDAY_DRIVER) then return end
    local SD = vehicle:getModData()
    if not SD.OriginalMaxSpeed then
        local currentMaxSpeed = vehicle:getMaxSpeed()
        if currentMaxSpeed > 0 then
            SD.OriginalMaxSpeed = currentMaxSpeed
            vehicle:setMaxSpeed(currentMaxSpeed * 0.5)
        end
    end
    driverVehicleByChar[character] = vehicle
end

local function onExit(character)
    if not character then return end
    local vehicle = driverVehicleByChar[character] or character:getVehicle()
    if vehicle then
        local SD = vehicle:getModData()
        if SD.OriginalMaxSpeed then
            vehicle:setMaxSpeed(SD.OriginalMaxSpeed)
            SD.OriginalMaxSpeed = nil
        end
    end
    driverVehicleByChar[character] = nil
end

Events.OnEnterVehicle.Add(onEnter)
Events.OnExitVehicle.Add(onExit)