local function DreamakerTraitClothingSelectionDefinitions()
TraitClothingSelectionDefinitions = {};

TraitClothingSelectionDefinitions = TraitClothingSelectionDefinitions or {};
	
-- Angler
TraitClothingSelectionDefinitions[CharacterTrait.FISHING] = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_BucketHatFishing"},
		},
	},
}

-- Fast Reader
TraitClothingSelectionDefinitions[CharacterTrait.FAST_READER] = {
	Female = {
		Eyes = {
            chance = 0,
	        items = {"Glasses_Reading"},
		},
	},
}
--[[
-- Hiker
TraitClothingSelectionDefinitions[CharacterTrait.HIKER] = {
	Female = {
		Shoes = {
			chance = 100,
			items = {"Shoes_HikingBoots"},
		},
	},
}
--]]
-- Hunter
TraitClothingSelectionDefinitions[CharacterTrait.HUNTER] = {
	Female = {
		TorsoExtraVest = {
			chance = 0,
			items = {"Vest_Hunting_Camo"},
		},
	},
}

-- Runner
TraitClothingSelectionDefinitions[CharacterTrait.JOGGER] = {
	Female = {
		Shoes = {
            chance = 0,
	        items = {"Shoes_TrainerTINT"},
		},
	},
}

-- Short Sighted
TraitClothingSelectionDefinitions[CharacterTrait.SHORT_SIGHTED] = {
	Female = {
		Eyes = {
            chance = 100,
	        items = {"Glasses_Normal"},
		},
	},
}

end

Events.OnGameBoot.Add(DreamakerTraitClothingSelectionDefinitions);