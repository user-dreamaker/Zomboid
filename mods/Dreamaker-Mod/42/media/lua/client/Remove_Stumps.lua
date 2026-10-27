require('TimedActions/ISBaseTimedAction');
require('TimedActions/ISWalkToTimedAction');

local ByCustomName = {
--	["Log"] = "Log",
--	["TreeBranch2"] = {"TreeBranch2", "TreeBranch2"},
--	["Twigs"] = {"Twigs", "Twigs", "Twigs"},
--	["Small Stump"] = false,
};

local BySpriteName = {
    ["d_generic_1_9"] = "Log",
    ["d_generic_1_10"] = "Log",
    ["d_generic_1_28"] = {"MushroomGeneric1", "MushroomGeneric7"},
};

local BySpritePrefix = {
    ["e_stumps"] = "Log",
};

local requiredTools = {
    "HandAxe_Old",
    "HandAxe",
    "HandAxeForged",
    "HandScythe",
    "HandScytheForged",
    "Hatchet_Bone",
    "Machete",
    "MacheteForged",
    "PrimitiveScythe",
};

local function hasAllowedItem(player)
    local inv = player:getInventory();
    for _, itemType in ipairs(requiredTools) do
        if inv:containsTypeRecurse(itemType) then
            return true;
        end
    end
    return false;
end

RemoveDebrisAction = ISBaseTimedAction:derive("RemoveDebrisAction");

function RemoveDebrisAction:isValid()
    local dist = self.character:DistTo(self.square:getX(), self.square:getY());
    return dist <= 1.5 and hasAllowedItem(self.character);
end

function RemoveDebrisAction:waitToStart()
    self.character:faceLocation(self.square:getX(), self.square:getY());
    return self.character:shouldBeTurning();
end

function RemoveDebrisAction:update()
    self.character:faceLocation(self.square:getX(), self.square:getY());
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function RemoveDebrisAction:start()
    local currentItem = self.character:getPrimaryHandItem();
    local alreadyValid = false;

    if currentItem then
        local fullType = currentItem:getFullType();
        for _, itemType in ipairs(requiredTools) do
            if fullType == itemType then
                alreadyValid = true;
                break;
            end
        end
    end

    if not alreadyValid then
        for _, itemType in ipairs(requiredTools) do
            local item = self.character:getInventory():getFirstTypeRecurse(itemType);
            if item then
                self.character:setPrimaryHandItem(item);
                break;
            end
        end
    end

    self:setActionAnim("RemoveGrass");
    self.sound = self.character:getEmitter():playSound("RemoveGrass");
end

function RemoveDebrisAction:stop()
    if self.sound ~= 0 and self.character:getEmitter():isPlaying(self.sound) then
        self.character:getEmitter():stopSound(self.sound);
    end
    ISBaseTimedAction.stop(self);
end

function RemoveDebrisAction:perform()
    if self.sound ~= 0 and self.character:getEmitter():isPlaying(self.sound) then
        self.character:getEmitter():stopSound(self.sound);
    end
    
    if self.target then
        self.square:transmitRemoveItemFromSquare(self.target);
        
        local function spawnAndFresh(itemType)
            local item = self.square:AddWorldInventoryItem(itemType, 0.5, 0.5, 0);
            if item and instanceof(item, "Food") then
                item:setAge(0);
            end
        end
        
        if self.spawnItem then
            if type(self.spawnItem) == "table" then
                for _, itemType in ipairs(self.spawnItem) do
                    spawnAndFresh(itemType);
                end
            else
                spawnAndFresh(self.spawnItem);
            end
        end
    end
        
    ISBaseTimedAction.perform(self);
end

function RemoveDebrisAction:new(character, target, square, spawnItem)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = character;
    o.target = target;
    o.square = square;
    o.spawnItem = spawnItem;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 100;
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
    return o;
end

local function onRemoveDebris(player, target, square, spawnItem)
    ISTimedActionQueue.add(ISWalkToTimedAction:new(player, square));
    ISTimedActionQueue.add(RemoveDebrisAction:new(player, target, square, spawnItem));
end

local function addRemoveDebrisMenu(playerIndex, context, worldobjects)
    local player = getSpecificPlayer(playerIndex);
    if player:getVehicle() then return end
    if not hasAllowedItem(player) then return end

    local square = nil;
    local target = nil;
    local spawnItem = nil;

    for _, v in ipairs(worldobjects) do
        square = v:getSquare();
        if square then
            for i = 0, square:getObjects():size() - 1 do
                local object = square:getObjects():get(i);
                
                if object and object:getSprite() then
                    local sprite = object:getSprite();
                    
                    local props = sprite:getProperties();
                    local customName = props:has("CustomName") and props:get("CustomName") or nil;
                    
                    if customName and ByCustomName[customName] ~= nil then
                        target = object;
                        spawnItem = ByCustomName[customName];
                        break;
                    end
                    
                    local spriteName = sprite:getName();
                    if spriteName then
                        if BySpriteName[spriteName] ~= nil then
                            target = object;
                            spawnItem = BySpriteName[spriteName];
                            break;
                        end
                        
                        for prefix, loot in pairs(BySpritePrefix) do
                            if luautils.stringStarts(spriteName, prefix) then
                                target = object;
                                spawnItem = loot;
                                break;
                            end
                        end
                        if target then break end
                    end
                end
            end
        end
        if target then break end
    end

    if target then
        context:addOption(getText("ContextMenu_Remove"), player, onRemoveDebris, target, square, spawnItem);
    end
end

Events.OnFillWorldObjectContextMenu.Add(addRemoveDebrisMenu);