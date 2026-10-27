-- Dreamaker GPS
local stateNOW = 1

local stateConfig = {
    font = UIFont.NewSmall,
    opacity1 = 0.5,
    opacity2 = 1.0
}

local function hasGPSItem(player)
    if not player then return false end
    
    local items = {player:getPrimaryHandItem(), player:getSecondaryHandItem()}
    for _, item in pairs(items) do
        if item then
            local type = item:getType()
            if type == "CompassDirectional" or type == "WristWatch_Left_ClassicMilitary" or type == "WristWatch_Right_ClassicMilitary" then
                return true
            end
        end
    end

    local wornItems = player:getWornItems()
    for i=0, wornItems:size()-1 do
        local item = wornItems:getItemByIndex(i)
        if item then
            local type = item:getType()
            if type == "WristWatch_Left_ClassicMilitary" or type == "WristWatch_Right_ClassicMilitary" then
                return true
            end
        end
    end

    local inv = player:getInventory()
    if inv then
        local invItems = inv:getItems()
        for i=0, invItems:size()-1 do
            local item = invItems:get(i)
            if item:getType() == "KeyRing" then
                local subInv = item:getInventory()
                if subInv then
                    local subItems = subInv:getItems()
                    for j=0, subItems:size()-1 do
                        if subItems:get(j):getType() == "CompassDirectional" then
                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

ISVersionWaterMark = {};
WaterMarkUI = ISPanel:derive("WaterMarkUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)

ISVersionWaterMark.doMsg = function()
    local panel = WaterMarkUI:new(0, 0, 100, FONT_HGT_SMALL + 5);
    panel:initialise();
    panel:addToUIManager();
    panel:setVisible(true);
    ISVersionWaterMark.watermarkPanel = panel
end

function WaterMarkUI:initialise()
    ISPanel.initialise(self);
end

function WaterMarkUI:createChildren()
    self.revButton = ISButton:new(0, 0, 10, FONT_HGT_SMALL, self.version, self, self.copyRev);
    self.revButton:initialise();
    self.revButton.borderColor.a = 0.0;
    self.revButton.backgroundColor.a = 0.0;
    self.revButton.backgroundColorMouseOver.a = 0.0;
    self.revButton.textColor.a = 0.0;
    self:addChild(self.revButton);
end

function WaterMarkUI:copyRev()
    Clipboard.setClipboard(getCore():getGitSha())
end

function WaterMarkUI:render()
    ISPanel.render(self);

    local plr = getSpecificPlayer(0)
    if not plr or stateNOW == 0 then return end

    if not hasGPSItem(plr) then 
        return 
    end

    local posX = math.floor(plr:getX())
    local posY = math.floor(plr:getY())
    
    local txt1 = "GPS: " .. posX .. ", " .. posY
    local width = getTextManager():MeasureStringX(stateConfig.font, txt1);
    
    self:setWidth(width + 20);
    self:setX(getCore():getScreenWidth() - self.width - 10);
    self:setY(getCore():getScreenHeight() - 30);

    self:drawTextRight(txt1, self.width - 5, 0, 1, 1, 1, stateConfig.opacity2, stateConfig.font);
end

function WaterMarkUI:new(x, y, width, height)
    local o = ISPanel.new(self, x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.refreshNeeded = true;
    o.borderColor = {r=0, g=0, b=0, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.version = getCore():getVersionNumber();
    return o;
end

Events.OnGameStart.Add(ISVersionWaterMark.doMsg);