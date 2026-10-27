local function checkStairSafety(player)
    if not player or player:isDead() then return end

    -- Interact Key Check to disable safety mode
    local interactKey = getCore():getKey("Interact")
    local isInteractHeld = interactKey and isKeyDown(interactKey)

    if isInteractHeld then
        player:setIgnoreAutoVault(false)
        return
    end
    
    local currentSquare = player:getCurrentSquare()
    if not currentSquare then return end

    local isNearStairs = false
    local cell = currentSquare:getCell()
    local x, y, z = currentSquare:getX(), currentSquare:getY(), currentSquare:getZ()

    -- Iterate through Z levels (Current Level and One Below)
    for dz = -1, 0 do
		for dx = -1, 1 do
			for dy = -1, 1 do
				local neighborSq = cell:getGridSquare(x + dx, y + dy, z + dz)
				
				if neighborSq and neighborSq:HasStairs() then
					isNearStairs = true
					break 
				end
			end
			if isNearStairs then break end
		end
        if isNearStairs then break end
    end

    local currentlyIgnoring = player:isIgnoreAutoVault()
    
    -- LOGIC
    if isNearStairs and not currentlyIgnoring then
        player:setIgnoreAutoVault(true)
        
        -- player:Say("Safe Mode: ON @ " .. x .. "," .. y .. "," .. z) 
        -- print("NoAutoVaultRun: Safety Enabled (Stairs Detected) @ " .. x .. "," .. y .. "," .. z)
        
    elseif not isNearStairs and currentlyIgnoring then
        player:setIgnoreAutoVault(false)
        
        -- player:Say("Safe Mode: OFF @ " .. x .. "," .. y .. "," .. z)
        -- print("NoAutoVaultRun: Safety Disabled @ " .. x .. "," .. y .. "," .. z)
    end
end

Events.OnPlayerUpdate.Add(checkStairSafety)