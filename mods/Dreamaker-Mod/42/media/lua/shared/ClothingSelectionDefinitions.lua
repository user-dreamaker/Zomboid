-- define here all the clothing that'll be available for a specific profession.
-- the default will always been available

ClothingSelectionDefinitions = ClothingSelectionDefinitions or {};

-- default selection, always available
ClothingSelectionDefinitions.default = {
	-- if there's no difference between male/female outfit, just create the female one, here we can have skirt
	Female = {
		Hat = {
			chance = 0,
			items = {};
		};
	};
	Male = {
		Hat = {
			chance = 0,
			items = {};
		};
	};
}

ClothingSelectionDefinitions.unemployed = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_BaseballCapTINT", "Hat_Beany"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal", "Glasses_Sun"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		TankTop = {
			chance = 0,
			items = {"Vest_DefaultTEXTURE_TINT"};
		};
		Tshirt = {
			chance = 0,
			items = {"Tshirt_DefaultTEXTURE_TINT", "Tshirt_WhiteLongSleeveTINT"};
		};
		Shirt = {
			chance = 0,
			items = {"Shirt_Denim"};
		};
		Sweater = {
			chance = 0,
			items = {"HoodieDOWN_WhiteTINT", "HoodieUP_WhiteTINT"};
		};
		Pants = {
			chance = 0,
			items = {"Shorts_LongDenim", "Trousers_Denim", "Trousers_WhiteTINT"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 0,
			items = {"Socks_Ankle"};
		};
		Shoes = {
			chance = 0,
			items = {"Shoes_TrainerTINT"};
		};
	};
}

ClothingSelectionDefinitions.burglar = {
	Female = {
		Hat = {
			chance = 0,
			items = { "Hat_Beany"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Sun"};
		};
		MaskFull = {
			chance = 100,
			items = {"Hat_BalaclavaFull"};
		};
		Sweater = {
			chance = 100,
			items = {"HoodieUP_WhiteTINT"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_WhiteTINT"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_ClassicBlack"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_WhiteTINT"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_Black","Socks_Long_Black"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_TrainerTINT"};
		};
	};
}

ClothingSelectionDefinitions.burgerflipper = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_FastFood"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		TankTop = {
			chance = 100,
			items = {"Vest_DefaultTEXTURE"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		TorsoExtra = {
			chance = 100,
			items = {"Apron_White"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_WhiteTEXTURE", "Trousers_Black"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Random"};
		};
	};
}

ClothingSelectionDefinitions.carpenter = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Denim", "Shirt_Workman"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_Denim"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_WhiteTINT"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots", "Shoes_WorkBoots"};
		};
	};
}

ClothingSelectionDefinitions.chef = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_ChefHat"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Jacket = {
			chance = 100,
			items = {"Jacket_Chef"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Chef"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Black"};
		};
	};
}

ClothingSelectionDefinitions.constructionworker = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_HardHat"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Denim", "Shirt_Workman"};
		};
		TorsoExtra = {
			chance = 100,
			items = {"Vest_HighViz"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_Denim"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots", "Shoes_WorkBoots"};
		};
	};
}

ClothingSelectionDefinitions.doctor = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Neck = {
			chance = 100,
			items = {"Tie_Full"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_FormalWhite"};
		};
		Jacket = {
			chance = 100,
			items = {"JacketLong_Doctor"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_SuitTEXTURE"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Black"};
		};
	};
}

ClothingSelectionDefinitions.electrician = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_HardHat"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Denim"};
		};
		TorsoExtra = {
			chance = 100,
			items = {"Vest_HighViz"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Denim"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.engineer = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_HardHat"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Neck = {
			chance = 0,
			items = {"Tie_Full"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_FormalWhite"};
		};
		TorsoExtra = {
			chance = 0,
			items = {"Vest_HighViz"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_SuitTEXTURE"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.farmer = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_Cowboy"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 0,
			items = {"Shirt_Denim"};
		};
		Jacket = {
			chance = 0,
			items = {"Jacket_Leather"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_Denim", "Trousers_LeatherBlack"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_FingerlessLeatherGloves", "Gloves_LeatherGloves"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_RidingBoots", "Shoes_CowboyBoots"};
		};
	};
}

ClothingSelectionDefinitions.fireofficer = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_Fireman"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles"};
		};
		MaskEyes = {
			chance = 0,
			items = {"Hat_GasMask"};
		};
		Necklace = {
			chance = 100,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Jacket = {
			chance = 100,
			items = {"Jacket_Fireman"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Fireman"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_LeatherGloves"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Heavy"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.fisherman = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_BucketHatFishing"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_DefaultTEXTURE"};
		};
		Shirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Pants = {
			chance = 0,
			items = {"Shorts_LongDenim"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_WhiteTINT"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Wellies"};
		};
	};
}

ClothingSelectionDefinitions.fitnessinstructor = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_Sweatband", "Hat_BandanaTiedTINT"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_Sport"};
		};
		Pants = {
			chance = 100,
			items = {"Shorts_ShortSport", "Shorts_LongSport", "Trousers_Sport"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_FingerlessGloves"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_TrainerTINT"};
		};
	};
}

ClothingSelectionDefinitions.lumberjack = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_Beany", "Hat_BaseballCap", "Hat_HardHat"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Lumberjack"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_JeanBaggy"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_FingerlessLeatherGloves_Black", "Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.mechanics = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		FullSuit = {
			chance = 100,
			items = {"Boilersuit_BlueRed"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.metalworker = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_OldWeldingGoggles", "Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		MaskFull = {
			chance = 0,
			items = {"WeldingMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_DefaultTEXTURE"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Workman"};
		};
		TorsoExtra = {
			chance = 100,
			items = {"Apron_Leather"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_LeatherBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots", "Shoes_WorkBoots"};
		};
	};
}

ClothingSelectionDefinitions.nurse = {
	Female = {
		Hat = {
			chance = 0,
			items = {"Hat_SurgicalCap"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_SurgicalMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_Scrubs"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Scrubs"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Scrubs"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_Surgical"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_TrainerTINT"};
		};
	};
}

ClothingSelectionDefinitions.parkranger = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_Ranger"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
--		Tshirt = {
--			chance = 100,
--			items = {"Tshirt_Profession_RangerGreen", "Tshirt_Profession_RangerBrown"};
--		};
		Shirt = {
			chance = 100,
			items = {"Tshirt_Ranger", "Shirt_Ranger"};
		};
		Jacket = {
			chance = 100,
			items = {"Jacket_Ranger"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Ranger"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.policeofficer = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_BaseballCap_Police", "Hat_Police", "Hat_Police_Grey"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses", "Glasses_Aviators", "Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 100,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_PoliceBlue", "Tshirt_PoliceGrey"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_PoliceBlue", "Shirt_PoliceGrey"};
		};
		Jacket = {
			chance = 100,
			items = {"Jacket_Police"};
		};
		TorsoExtraVestBullet = {
			chance = 100,
			items = {"Vest_BulletPolice"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Police", "Trousers_PoliceGrey"};
		};
		BeltExtra = {
			chance = 100,
			items = {"HolsterSimple_Black"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack", "Gloves_FingerlessLeatherGloves_Black"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Heavy"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots"};
		};
	};
}

ClothingSelectionDefinitions.rancher = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_Cowboy"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 0,
			items = {"Shirt_Denim"};
		};
		Jacket = {
			chance = 0,
			items = {"Jacket_Leather"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_Denim", "Trousers_LeatherBlack"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_FingerlessLeatherGloves", "Gloves_LeatherGloves"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_RidingBoots", "Shoes_CowboyBoots"};
		};
	};
}

ClothingSelectionDefinitions.repairman = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Mask = {
			chance = 0,
			items = {"Hat_DustMask"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Denim", "Shirt_Workman"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_Denim"};
		};
		PantsExtra = {
			chance = 100,
			items = {"Dungarees"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 0,
			items = {"Gloves_WhiteTINT"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_WorkBoots"};
		};
	};
}

ClothingSelectionDefinitions.securityguard = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_FormalWhite"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_Black"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_DigitalBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots", "Shoes_Black"};
		};
	};
}

ClothingSelectionDefinitions.smither = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_SafetyGoggles", "Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_DefaultTEXTURE"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Workman"};
		};
		TorsoExtra = {
			chance = 100,
			items = {"Apron_Leather"};
		};
		Pants = {
			chance = 100,
			items = {"Trousers_LeatherBlack"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Hands = {
			chance = 100,
			items = {"Gloves_LeatherGlovesBlack"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White","Socks_Long_White"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_BlackBoots", "Shoes_WorkBoots"};
		};
	};
}

ClothingSelectionDefinitions.tailor = {
	Female = {
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		UnderwearTop = {
			chance = 0,
			items = {"Corset_Black"};
		};
		UnderwearExtra1= {
			chance = 0,
			items = {"StockingsBlack", "StockingsBlackSemiTrans", "StockingsBlackTrans", "StockingsWhite", "TightsBlack", "TightsFishnets", "TightsBlackSemiTrans", "TightsBlackTrans"};
		};
		Dress = {
			chance = 100,
			items = {"Dress_Normal", "Dress_Knees", "DressKnees_Straps", "Dress_Long", "Dress_long_Straps", "Dress_SatinNegligee", "Dress_Short", "Dress_SmallBlackStraps", "Dress_SmallStraps", "Dress_SmallBlackStrapless", "Dress_Straps"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Fancy", "Shoes_Strapped"};
		};
	};
	Male = {
		Eyes = {
			chance = 0,
			items = {"Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 0,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 0,
			items = {"Tshirt_DefaultTEXTURE", "Tshirt_WhiteLongSleeve"};
		};
		Shirt = {
			chance = 100,
			items = {"Shirt_Denim"};
		};
		Jacket = {
			chance = 0,
			items = {"Jacket_Leather"};
		};
		Pants = {
			chance = 100,
			items = {"Shorts_ShortDenim", "Shorts_LongDenim", "Trousers_Denim", "Trousers_JeanBaggy"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_Random"};
		};
	};
}

ClothingSelectionDefinitions.veteran = {
	Female = {
		Hat = {
			chance = 100,
			items = {"Hat_BaseballCapArmy", "Hat_BeretArmy"};
		};
		Eyes = {
			chance = 0,
			items = {"Glasses_Eyepatch_Left", "Glasses_Eyepatch_Right", "Glasses_Shooting", "Glasses_Cosmetic_Normal"};
		};
		Necklace = {
			chance = 100,
			items = {"Necklace_Crucifix", "Necklace_SilverCrucifix"};
		};
		Tshirt = {
			chance = 100,
			items = {"Tshirt_ArmyGreen", "Tshirt_Profession_VeterenGreen", "Tshirt_Profession_VeterenRed"};
		};
		Jacket = {
			chance = 0,
			items = {"Jacket_CoatArmy"};
		};
		TorsoExtraVest = {
			chance = 100,
			items = {"Vest_Leather_Veteran"};
		};
		ShortPants = {
			chance = 100,
			items = {"Shorts_LongDenim"};
		};
		Pants = {
			chance = 0,
			items = {"Trousers_ArmyService"};
		};
		LeftWrist = {
			chance = 100,
			items = {"WristWatch_Left_ClassicMilitary"};
		};
		Left_MiddleFinger = {
			chance = 0,
			items = {"Ring_Left_RingFinger_Gold", "Ring_Left_MiddleFinger_Silver"};
		};
		Socks = {
			chance = 100,
			items = {"Socks_Ankle_White", "Socks_Ankle_Black"};
		};
		Shoes = {
			chance = 100,
			items = {"Shoes_ArmyBoots"};
		};
	};
}