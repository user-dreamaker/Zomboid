local oldPointToSpend = CharacterCreationProfession.PointToSpend

function CharacterCreationProfession:PointToSpend()
    local points = oldPointToSpend(self)
    
    if SandboxVars and SandboxVars.CharacterFreePoints == 100 then
        local prof = self:getSelectedProf()
        
        if prof then
            local profType = prof:getType()
            local profName = profType:getName()
            
            if profName == "unemployed" then points = points + 86
			elseif profName == "smither" then points = points + 94
			elseif profName == "burgerflipper" then points = points + 89
			elseif profName == "burglar" then points = points + 100
			elseif profName == "carpenter" then points = points + 96
			elseif profName == "chef" then points = points + 93
			elseif profName == "constructionworker" then points = points + 96
			elseif profName == "repairman" then points = points + 94
			elseif profName == "doctor" then points = points + 94
			elseif profName == "electrician" then points = points + 96
			elseif profName == "engineer" then points = points + 98
			elseif profName == "farmer" then points = points + 94
			elseif profName == "fireofficer" then points = points + 94
            elseif profName == "fisherman" then points = points + 96
			elseif profName == "fitnessinstructor" then points = points + 98
			elseif profName == "lumberjack" then points = points + 94
			elseif profName == "mechanics" then points = points + 95
			elseif profName == "nurse" then points = points + 94
			elseif profName == "parkranger" then points = points + 94
			elseif profName == "policeofficer" then points = points + 98
			elseif profName == "rancher" then points = points + 94
			elseif profName == "securityguard" then points = points + 96
			elseif profName == "tailor" then points = points + 92
			elseif profName == "veteran" then points = points + 94
			elseif profName == "metalworker" then points = points + 98
			
            end
        end
    end return points
end