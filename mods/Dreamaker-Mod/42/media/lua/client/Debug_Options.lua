local function if_isDebugEnabled()
	if isDebugEnabled() then
		local debugOptions = getDebugOptions()
		if debugOptions then
			debugOptions:setBoolean("UI.uiShowContextMenuReportOptions", true)
			debugOptions:setBoolean("UI.DebugConsole.StartVisible", false)
			debugOptions:save()
		end
	end
end

Events.OnGameStart.Add(if_isDebugEnabled)

local function if_not_isDebugEnabled()
	if not isDebugEnabled() then
		local debugOptions = getDebugOptions()
		if debugOptions then
			debugOptions:setBoolean("UI.uiShowContextMenuReportOptions", false)
			debugOptions:setBoolean("UI.DebugConsole.StartVisible", false)
			debugOptions:save()
		end
	end
end

Events.OnGameStart.Add(if_not_isDebugEnabled)