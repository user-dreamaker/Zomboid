MyFPSCounter = {}
MyFPSCounter.lastSec = -1
MyFPSCounter.text = ""

local function renderMyFPS()
    if not MyFPSCounter.enabled then return end

    local second = getTimestamp()

    if MyFPSCounter.lastSec ~= second then
        MyFPSCounter.text = " " .. getAverageFPS()
        MyFPSCounter.lastSec = second
    end

    local x = 1
    local y = 1

    TextManager.instance:DrawString(
        UIFont.Small,
        x,
        y,
        MyFPSCounter.text,
        1, 1, 1, 1
    )
end

Events.OnPostUIDraw.Add(renderMyFPS)
MyFPSCounter.enabled = true