local function RemoveWelcomeMessages()
    if WelcomeMessages and WelcomeMessages.doMsg then
        Events.OnGameStart.Remove(WelcomeMessages.doMsg)
    end
end

Events.OnGameStart.Add(RemoveWelcomeMessages)