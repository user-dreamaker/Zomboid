local SpawnItems = {}

local function cleanStarterKit(playerObj)
    local inv = playerObj:getInventory()
    local itemsToRemove = {"Base.Bag_Schoolbag", "Base.BaseballBat", "Base.Crisps", "Base.Hammer", "Base.WaterBottle"}
    for _, itemType in ipairs(itemsToRemove) do
        local item = inv:getItemFromType(itemType)
        if item then inv:DoRemoveItem(item) end
    end
end

function SpawnItems.OnNewGame(playerObj, square)
    if isClient() then return end

    local descriptor = playerObj:getDescriptor()
    local profession = descriptor:getCharacterProfession()
    local inv = playerObj:getInventory()
    local forename = descriptor:getForename()
    local surname = descriptor:getSurname()

--

        if profession == CharacterProfession.UNEMPLOYED and ((forename and forename:lower() == "ninja") or (surname and surname:lower() == "ninja")) then
            inv:clear()
            playerObj:getWornItems():clear()

            local weapon = inv:AddItem("Base.Katana")
            if weapon then
                weapon:setAttachedSlot(1)
                weapon:setAttachedSlotType("Back")
                weapon:setAttachedToModel("Blade On Back")
            end

			clothe = inv:AddItem("Base.HoodieUP_WhiteTINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Hat_BalaclavaFull")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Tshirt_WhiteLongSleeveTINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Trousers_DefaultTEXTURE_TINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Gloves_WhiteTINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shoes_TrainerTINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.ElbowPad_Left_TINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.ElbowPad_Right_TINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Left_TINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Right_TINT")
			local color = ImmutableColor.new(0.0, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)

			local Bag_FannyPackBack = inv:AddItem("Base.Bag_FannyPackBack")
            if Bag_FannyPackBack then
                Bag_FannyPackBack:getVisual():setTextureChoice(0)
                Bag_FannyPackBack:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackBack:getBodyLocation(), Bag_FannyPackBack)

                local container = Bag_FannyPackBack:getItemContainer()
                container:AddItem("Base.SmallKnife")
                container:AddItem("Base.Whetstone")
            end
		return

        elseif profession == CharacterProfession.UNEMPLOYED and (descriptor:isFemale()) and (forename:lower() == "claire") and (surname:lower() == "redfield") then
            inv:clear()
            playerObj:getWornItems():clear()

            local visualChar = playerObj:getHumanVisual()
            local hairColor = ImmutableColor.new(0.345, 0.207, 0.133, 1)
			visualChar:setSkinTextureIndex(2)
            visualChar:setHairModel("PonyTail")
            visualChar:setHairColor(hairColor)
			playerObj:resetModel()

			wpn = inv:AddItem("Base.Revolver_Short")
            wpn:setAttachedSlot(2)
            wpn:setAttachedSlotType("HolsterRight")
            wpn:setAttachedToModel("Holster Right")
			wpn:setCurrentAmmoCount(wpn:getMaxAmmo())

			clothe = inv:AddItem("Base.Jacket_WhiteTINT")
			local color = ImmutableColor.new(0.5, 0.0, 0.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Vest_DefaultTEXTURE_TINT")
			local color = ImmutableColor.new(0.166, 0.166, 0.166, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Necklace_SilverSapphire")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.WristWatch_Left_DigitalRed")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Trousers_DefaultTEXTURE")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Belt2")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.HolsterSimple_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Socks_Ankle_White")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shoes_BlackBoots")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)

			local Bag_FannyPackBack = inv:AddItem("Base.Bag_FannyPackBack")
            if Bag_FannyPackBack then
                Bag_FannyPackBack:getVisual():setTextureChoice(0)
                Bag_FannyPackBack:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackBack:getBodyLocation(), Bag_FannyPackBack)

                local container = Bag_FannyPackBack:getItemContainer()
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.Bullets38Box")
				container:AddItem("Base.HandTorch")
				IDcard = container:AddItem("Base.IDcard") if IDcard then IDcard:nameAfterDescriptor(playerObj:getDescriptor()) end
				Passport = container:AddItem("Base.Passport") if Passport then Passport:nameAfterDescriptor(playerObj:getDescriptor()) end
			end
		return

		elseif profession == CharacterProfession.POLICE_OFFICER and (not descriptor:isFemale()) and (forename:lower() == "chris") and (surname:lower() == "redfield") then
            inv:clear()
            playerObj:getWornItems():clear()

            local visualChar = playerObj:getHumanVisual()
            local hairColor = ImmutableColor.new(0.166, 0.166, 0.166, 1)
			visualChar:setSkinTextureIndex(2)
            visualChar:setHairModel("GreasedBack")
            visualChar:setHairColor(hairColor)
			visualChar:setBeardModel("")
            visualChar:setBeardColor(hairColor)
			playerObj:resetModel()

			wpn = inv:AddItem("Base.FightingKnife")
            wpn:setAttachedSlot(3)
            wpn:setAttachedSlotType("BeltLeft")
            wpn:setAttachedToModel("Belt Left")

			clothe = inv:AddItem("Base.Vest_BulletOliveDrab")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Tshirt_DefaultTEXTURE")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Trousers_ArmyService")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Belt2")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.HolsterSimple_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Gloves_FingerlessLeatherGloves_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.WristWatch_Left_ClassicMilitary")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Left_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Right_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Socks_Heavy")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shoes_ArmyBoots")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)

			local Bag_FannyPackFront = inv:AddItem("Base.Bag_FannyPackFront")
            if Bag_FannyPackFront then
                Bag_FannyPackFront:getVisual():setTextureChoice(0)
                Bag_FannyPackFront:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackFront:getBodyLocation(), Bag_FannyPackFront)

                local container = Bag_FannyPackFront:getItemContainer()
                container:AddItem("Base.Lighter")
				container:AddItem("Base.CigarettePack")
				container:AddItem("Base.KnifePocket")
			end

			local Bag_FannyPackBack = inv:AddItem("Base.Bag_FannyPackBack")
            if Bag_FannyPackBack then
                Bag_FannyPackBack:getVisual():setTextureChoice(0)
                Bag_FannyPackBack:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackBack:getBodyLocation(), Bag_FannyPackBack)

                local container = Bag_FannyPackBack:getItemContainer()
                container:AddItem("Base.Zipties")
				IDcard = container:AddItem("Base.IDcard") if IDcard then IDcard:nameAfterDescriptor(playerObj:getDescriptor()) end
				Passport = container:AddItem("Base.Badge") if Passport then Passport:nameAfterDescriptor(playerObj:getDescriptor()) end
			end
		return

        elseif profession == CharacterProfession.POLICE_OFFICER and (descriptor:isFemale()) and (forename:lower() == "jill") and (surname:lower() == "valentine") then
            inv:clear()
            playerObj:getWornItems():clear()

            local visualChar = playerObj:getHumanVisual()
            local hairColor = ImmutableColor.new(0.219, 0.160, 0.105, 1)
			visualChar:setSkinTextureIndex(2)
            visualChar:setHairModel("Grungey02")
            visualChar:setHairColor(hairColor)
			playerObj:resetModel()

			wpn = inv:AddItem("Base.Pistol")
            wpn:setAttachedSlot(2)
            wpn:setAttachedSlotType("HolsterRight")
            wpn:setAttachedToModel("Holster Right")
            wpn:setContainsClip(true)
			wpn:setCurrentAmmoCount(wpn:getMaxAmmo())

			inv:AddItem("Base.FightingKnife")

			clothe = inv:AddItem("Base.BoobTube")
			local color = ImmutableColor.new(1.0, 1.0, 1.0, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Vest_DefaultTEXTURE_TINT")
			local color = ImmutableColor.new(0.250, 0.250, 0.520, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Trousers_DefaultTEXTURE")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.HolsterShoulder")
			clothe:getVisual():setTextureChoice(0)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.HolsterSimple_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.ElbowPad_Left_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Gloves_FingerlessLeatherGloves_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.WristWatch_Left_ClassicMilitary")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Socks_Heavy")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shoes_ArmyBoots")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)

			local Bag_FannyPackFront = inv:AddItem("Base.Bag_FannyPackFront")
            if Bag_FannyPackFront then
                Bag_FannyPackFront:getVisual():setTextureChoice(0)
                Bag_FannyPackFront:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackFront:getBodyLocation(), Bag_FannyPackFront)

                local container = Bag_FannyPackFront:getItemContainer()
                container:AddItem("Base.Handiknife")
				container:AddItem("Base.Multitool")
				container:AddItem("Base.HandTorch")
				container:AddItem("Base.Sandwich")
			end

			local Bag_FannyPackBack = inv:AddItem("Base.Bag_FannyPackBack")
            if Bag_FannyPackBack then
                Bag_FannyPackBack:getVisual():setTextureChoice(0)
                Bag_FannyPackBack:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackBack:getBodyLocation(), Bag_FannyPackBack)

                local container = Bag_FannyPackBack:getItemContainer()
				container:AddItem("Base.Bullets9mmBox")
				container:AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
				container:AddItem("Base.Zipties")
				IDcard = container:AddItem("Base.IDcard") if IDcard then IDcard:nameAfterDescriptor(playerObj:getDescriptor()) end
				Passport = container:AddItem("Base.Badge") if Passport then Passport:nameAfterDescriptor(playerObj:getDescriptor()) end
			end
		return

		elseif profession == CharacterProfession.POLICE_OFFICER and (not descriptor:isFemale()) and (forename:lower() == "leon") and (surname:lower() == "kennedy") then
            inv:clear()
            playerObj:getWornItems():clear()

            local visualChar = playerObj:getHumanVisual()
            local hairColor = ImmutableColor.new(0.333, 0.266, 0.175, 1)
			visualChar:setSkinTextureIndex(2)
            visualChar:setHairModel("RightParting")
            visualChar:setHairColor(hairColor)
			playerObj:resetModel()

			wpn = inv:AddItem("Base.Pistol")
            wpn:setAttachedSlot(2)
            wpn:setAttachedSlotType("HolsterRight")
            wpn:setAttachedToModel("Holster Right")
            wpn:setContainsClip(true)
			wpn:setCurrentAmmoCount(wpn:getMaxAmmo())

			clothe = inv:AddItem("Base.Tshirt_WhiteLongSleeveTINT")
			local color = ImmutableColor.new(0.333, 0.333, 0.333, 1)
			clothe:getVisual():setTint(color)
			clothe:synchWithVisual()
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shirt_PoliceBlue")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Vest_BulletPolice")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Trousers_Police")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.HolsterSimple_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.ElbowPad_Left_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.ElbowPad_Right_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Gloves_FingerlessLeatherGloves_Black")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Left_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Kneepad_Right_Tactical")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Socks_Heavy")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)
			clothe = inv:AddItem("Base.Shoes_ArmyBoots")
			playerObj:setWornItem(clothe:getBodyLocation(), clothe)

			local Bag_FannyPackFront = inv:AddItem("Base.Bag_FannyPackFront")
            if Bag_FannyPackFront then
                Bag_FannyPackFront:getVisual():setTextureChoice(0)
                Bag_FannyPackFront:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackFront:getBodyLocation(), Bag_FannyPackFront)

                local container = Bag_FannyPackFront:getItemContainer()
				container:AddItem("Base.Bullets9mmBox")
				container:AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
				container:AddItem("Base.Zipties")
				container:AddItem("Base.HandTorch")
			end

			local Bag_FannyPackBack = inv:AddItem("Base.Bag_FannyPackBack")
            if Bag_FannyPackBack then
                Bag_FannyPackBack:getVisual():setTextureChoice(0)
                Bag_FannyPackBack:synchWithVisual()
                playerObj:setWornItem(Bag_FannyPackBack:getBodyLocation(), Bag_FannyPackBack)

                local container = Bag_FannyPackBack:getItemContainer()
				IDcard = container:AddItem("Base.IDcard") if IDcard then IDcard:nameAfterDescriptor(playerObj:getDescriptor()) end
				Passport = container:AddItem("Base.Badge") if Passport then Passport:nameAfterDescriptor(playerObj:getDescriptor()) end
			end
		return

--

		end

--

    if SandboxVars.StarterKit then
        cleanStarterKit(playerObj)
        playerObj:setClothingItem_Back(nil)

		-- Custom Occupation
        if profession == CharacterProfession.UNEMPLOYED then
            local bag = inv:AddItem("Base.Bag_Schoolbag") bag:getVisual():setTextureChoice(0) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Crisps")
                container:AddItem("Base.BaseballBat")
                container:AddItem("Base.Hammer")
                playerObj:setClothingItem_Back(bag)
            end

		-- Blacksmith
        elseif profession == CharacterProfession.SMITHER then
            local bag = inv:AddItem("Base.Bag_Satchel_Leather")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.MetalworkingChisel")
                container:AddItem("Base.MetalworkingPliers")
                container:AddItem("Base.MetalworkingPunch")
                container:AddItem("Base.SmithingHammer")
                playerObj:setClothingItem_Back(bag)
            end

		-- Burger Flipper
        elseif profession == CharacterProfession.BURGER_FLIPPER then
            local bag = inv:AddItem("Base.Bag_BirthdayBasket")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Burger")
                container:AddItem("Base.Pop")
                container:AddItem("Base.KitchenKnife")
                container:AddItem("Base.MeatCleaver")
                container:AddItem("Base.Spatula")
                container:AddItem("Base.Whetstone")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Burglar
        elseif profession == CharacterProfession.BURGLAR then
            local bag = inv:AddItem("Base.Bag_Schoolbag") bag:getVisual():setTextureChoice(0) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.Crowbar")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.KnifePocket")
                playerObj:setClothingItem_Back(bag)
            end

		-- Carpenter
        elseif profession == CharacterProfession.CARPENTER then
            local bag = inv:AddItem("Base.Toolbox_Wooden")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.Hammer")
                container:AddItem("Base.KnifePocket")
                container:AddItem("Base.GardenSaw")
                container:AddItem("Base.NailsBox")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Chef
        elseif profession == CharacterProfession.CHEF then
            local bag = inv:AddItem("Base.Bag_Satchel_Leather")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.KitchenKnife")
				container:AddItem("Base.KnifeSushi")
                container:AddItem("Base.MeatCleaver")
                container:AddItem("Base.Whetstone")
                local box = container:AddItem("Base.TakeoutBox_Chinese")
                if box then
                    local c = box:getItemContainer()
                    c:AddItem("Base.MeatDumpling")
                    c:AddItem("Base.MeatSteamBun")
                    c:AddItem("Base.ShrimpDumpling")
                    c:AddItem("Base.ShrimpFried")
                    c:AddItem("Base.Springroll")
                    c:AddItem("Base.SushiEgg")
                    c:AddItem("Base.SushiFish")
                    c:AddItem("Base.TofuFried")
                end
                playerObj:setClothingItem_Back(bag)
            end

		-- Construction Worker
        elseif profession == CharacterProfession.CONSTRUCTION_WORKER then
            local bag = inv:AddItem("Base.Toolbox")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.ClubHammer")
                container:AddItem("Base.Hammer")
                container:AddItem("Base.MasonsChisel")
                container:AddItem("Base.MasonsTrowel")
                playerObj:setSecondaryHandItem(bag)
            end

		-- DIY Expert
        elseif profession == CharacterProfession.REPAIRMAN then
            local bag = inv:AddItem("Base.Toolbox")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.DuctTape")
                container:AddItem("Base.Epoxy")
                container:AddItem("Base.FiberglassTape")
                container:AddItem("Base.Glue")
                container:AddItem("Base.Hammer")
                container:AddItem("Base.KnifePocket")
                container:AddItem("Base.PipeWrench")
                container:AddItem("Base.Ratchet")
                container:AddItem("Base.Scotchtape")
                container:AddItem("Base.Screwdriver")
                container:AddItem("Base.Woodglue")
                container:AddItem("Base.Wrench")
                container:AddItem("Base.Zipties")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Doctor
        elseif profession == CharacterProfession.DOCTOR then
            local bag = inv:AddItem("Base.Bag_DoctorBag")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Lollipop")
                container:AddItem("Base.Antibiotics")
                container:AddItem("Base.Bandaid")
                container:AddItem("Base.PenLight")
                container:AddItem("Base.Pills")
                container:AddItem("Base.PillsAntiDep")
                container:AddItem("Base.PillsBeta")
                container:AddItem("Base.PillsSleepingTablets")
                container:AddItem("Base.PillsVitamins")
                container:AddItem("Base.Stethoscope")
                container:AddItem("Base.TongueDepressor")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Electrician
        elseif profession == CharacterProfession.ELECTRICIAN then
            local bag = inv:AddItem("Base.Bag_ProtectiveCaseSmall_Electronics")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.DuctTape")
                container:AddItem("Base.ElectricWire")
                container:AddItem("Base.ElectronicsMag1")
                container:AddItem("Base.ElectronicsMag2")
                container:AddItem("Base.ElectronicsMag3")
                container:AddItem("Base.ElectronicsMag4")
                container:AddItem("Base.ElectronicsMag5")
                container:AddItem("Base.ElectronicsScrap")
                container:AddItem("Base.Multitool")
                container:AddItem("Base.Pliers")
                container:AddItem("Base.Screwdriver")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Engineer
        elseif profession == CharacterProfession.ENGINEER then
            local bag = inv:AddItem("Base.Briefcase")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.BluePen")
                container:AddItem("Base.EngineerMagazine1")
                container:AddItem("Base.EngineerMagazine2")
                container:AddItem("Base.EngineerMagazine3")
                container:AddItem("Base.Eraser")
                container:AddItem("Base.GreenPen")
                container:AddItem("Base.MarkerBlack")
                container:AddItem("Base.MarkerBlue")
                container:AddItem("Base.MarkerGreen")
                container:AddItem("Base.MarkerRed")
                container:AddItem("Base.Notebook")
                container:AddItem("Base.Pen")
                container:AddItem("Base.Pencil")
                container:AddItem("Base.PenMultiColor")
                container:AddItem("Base.RedPen")
                playerObj:setSecondaryHandItem(bag)
            end

		-- Farmer
        elseif profession == CharacterProfession.FARMER then
            local bag = inv:AddItem("Base.Bag_Satchel_Leather")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Corn")
                container:AddItem("Base.GardeningSprayEmpty")
                container:AddItem("Base.HandFork")
                container:AddItem("Base.HandScythe")
                container:AddItem("Base.HandShovel")
                playerObj:setClothingItem_Back(bag)
            end

		-- Firefighter
        elseif profession == CharacterProfession.FIRE_OFFICER then
            local bag = inv:AddItem("Base.Bag_MedicalBag")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.GranolaBar")
                container:AddItem("Base.Axe")
                container:AddItem("Base.Extinguisher")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.Rope")
                playerObj:setClothingItem_Back(bag)
            end
			
		-- Fisherman
        elseif profession == CharacterProfession.FISHERMAN then
            local bag = inv:AddItem("Base.Bag_Satchel_Fishing")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.FishFried")
                container:AddItem("Base.SushiFish")
                container:AddItem("Base.FishingHookBox")
                container:AddItem("Base.FishingMag1")
                container:AddItem("Base.FishingMag2")
                container:AddItem("Base.FishingRod")
                container:AddItem("Base.HuntingKnife")
                container:AddItem("Base.JigLure")
                container:AddItem("Base.KnifeSushi")
                container:AddItem("Base.MinnowLure")
                container:AddItem("Base.Whetstone")
                playerObj:setClothingItem_Back(bag)
            end

		-- Fitness Instructor
        elseif profession == CharacterProfession.FITNESS_INSTRUCTOR then
            local bag = inv:AddItem("Base.Bag_DuffelBagTINT") color = ImmutableColor.new(0.333, 0.333, 0.333, 1) bag:getVisual():setTint(color) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.GranolaBar")
                container:AddItem("Base.BarBell")
                container:AddItem("Base.BathTowel")
                container:AddItem("Base.DumbBell")
                container:AddItem("Base.Sportsbottle")
                playerObj:setClothingItem_Back(bag)
            end

		-- Lumberjack
        elseif profession == CharacterProfession.LUMBERJACK then
            local bag = inv:AddItem("Base.Bag_DuffelBagTINT") color = ImmutableColor.new(0.333, 0.333, 0.333, 1) bag:getVisual():setTint(color) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.BeerBottle")
                container:AddItem("Base.BeerCan")
                container:AddItem("Base.BeerImported")
                container:AddItem("Base.GardenSaw")
                container:AddItem("Base.Rope")
                container:AddItem("Base.Whetstone")
                container:AddItem("Base.WoodAxe")
                playerObj:setClothingItem_Back(bag)
            end

		-- Mechanic
        elseif profession == CharacterProfession.MECHANICS then
            local bag = inv:AddItem("Base.Toolbox_Mechanic")
            local PetrolCan = inv:AddItem("Base.PetrolCan")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.CarBatteryCharger")
                container:AddItem("Base.Jack")
                container:AddItem("Base.LugWrench")
                container:AddItem("Base.MechanicMag1")
                container:AddItem("Base.MechanicMag2")
                container:AddItem("Base.MechanicMag3")
                container:AddItem("Base.Ratchet")
                container:AddItem("Base.RubberHose")
                container:AddItem("Base.Screwdriver")
                container:AddItem("Base.TireIron")
                container:AddItem("Base.TirePump")
                container:AddItem("Base.Wrench")
                playerObj:setPrimaryHandItem(PetrolCan)
                playerObj:setSecondaryHandItem(bag)
            end

		-- Nurse
        elseif profession == CharacterProfession.NURSE then
			local bag = inv:AddItem("Base.Bag_Schoolbag_Medical") bag:getVisual():setTextureChoice(0) bag:synchWithVisual() --local bag = inv:AddItem("Base.Bag_Satchel_Medical")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Lollipop")
                container:AddItem("Base.AlcoholBandage")
                container:AddItem("Base.AlcoholedCottonBalls")
                container:AddItem("Base.AlcoholWipes")
                container:AddItem("Base.Antibiotics")
                container:AddItem("Base.Bandage")
                container:AddItem("Base.CottonBalls")
                container:AddItem("Base.Disinfectant")
                container:AddItem("Base.Pills")
                container:AddItem("Base.Scalpel")
                container:AddItem("Base.ScissorsBluntMedical")
                container:AddItem("Base.Splint")
                container:AddItem("Base.SutureNeedle")
                container:AddItem("Base.SutureNeedleHolder")
                container:AddItem("Base.Tissue")
                container:AddItem("Base.Tweezers")
                playerObj:setClothingItem_Back(bag)
            end

		-- Park Ranger
        elseif profession == CharacterProfession.PARK_RANGER then
            local bag = inv:AddItem("Base.Bag_Satchel_Leather")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.BeefJerky")
                container:AddItem("Base.DehydratedMeatStick")
				container:AddItem("Base.ScoutCookies")
                container:AddItem("Base.CompassDirectional")
                container:AddItem("Base.HandAxe")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.HerbalistMag")
                container:AddItem("Base.HuntingKnife")
                container:AddItem("Base.KnifePocket")
                container:AddItem("Base.MagnesiumFirestarter")
                container:AddItem("Base.Whetstone")
                playerObj:setClothingItem_Back(bag)
            end

		-- Police Officer
        elseif profession == CharacterProfession.POLICE_OFFICER then
            local bag = inv:AddItem("Base.Bag_Police")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.DoughnutChocolate")
                container:AddItem("Base.Pistol")
                container:AddItem("Base.Nightstick")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.Bullets9mmBox")
                container:AddItem("Base.9mmClip")
                playerObj:setClothingItem_Back(bag)
            end

		-- Rancher
        elseif profession == CharacterProfession.RANCHER then
            local bag = inv:AddItem("Base.Bag_Satchel_Leather")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.BeefJerky")
                container:AddItem("Base.DehydratedMeatStick")
                container:AddItem("Base.Machete")
                container:AddItem("Base.Rope")
                playerObj:setClothingItem_Back(bag)
            end

		-- Security Guard
        elseif profession == CharacterProfession.SECURITY_GUARD then
            local bag = inv:AddItem("Base.Bag_Schoolbag") bag:getVisual():setTextureChoice(0) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.Nightstick")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.WalkieTalkieMakeShift")
                playerObj:setClothingItem_Back(bag)
            end

		-- Tailor
        elseif profession == CharacterProfession.TAILOR then
            local bag = inv:AddItem("Base.Bag_HideSatchel")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.Scissors")
                container:AddItem("Base.TailoringMag1")
                container:AddItem("Base.TailoringMag2")
                container:AddItem("Base.TailoringMag3")
                container:AddItem("Base.TailoringMag4")
                container:AddItem("Base.TailoringMag5")
                container:AddItem("Base.TailoringMag6")
                container:AddItem("Base.TailoringMag7")
                container:AddItem("Base.TailoringMag8")
                container:AddItem("Base.TailoringMag9")
                container:AddItem("Base.TailoringMag10")
                local sk = container:AddItem("Base.SewingKit")
                if sk then
                    local sc = sk:getItemContainer()
                    sc:AddItem("Base.Needle")
                    sc:AddItem("Base.Thread")
                    sc:AddItem("Base.Awl")
                    sc:AddItem("Base.Buckle")
                    sc:AddItem("Base.Button")
                    sc:AddItem("Base.MeasuringTape")
                    sc:AddItem("Base.Thimble")
                end
                playerObj:setClothingItem_Back(bag)
            end

		-- Veteran
        elseif profession == CharacterProfession.VETERAN then
            local bag = inv:AddItem("Base.Bag_Military")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.BeefJerky")
                container:AddItem("Base.DehydratedMeatStick")
                container:AddItem("Base.Revolver_Long")
                container:AddItem("Base.Bullets44Box")
                container:AddItem("Base.Shotgun")
                container:AddItem("Base.ShotgunShellsBox")
                container:AddItem("Base.CanteenMilitaryFull")
                container:AddItem("Base.FightingKnife")
                container:AddItem("Base.HandTorch")
                container:AddItem("Base.Hat_ArmyWWII")
                container:AddItem("Base.Holster_Brown")
                container:AddItem("Base.KnifePocket")
                container:AddItem("Base.MagnesiumFirestarter")
                container:AddItem("Base.Whetstone")
                playerObj:setClothingItem_Back(bag)
            end

		-- Welder
        elseif profession == CharacterProfession.METALWORKER then
            local bag = inv:AddItem("Base.Toolbox")
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Chocolate")
                container:AddItem("Base.BallPeenHammer")
                container:AddItem("Base.BlowTorch")
                container:AddItem("Base.Glasses_OldWeldingGoggles")
                container:AddItem("Base.MetalworkingChisel")
                container:AddItem("Base.MetalworkingPliers")
                container:AddItem("Base.MetalworkingPunch")
                container:AddItem("Base.WeldingMask")
                container:AddItem("Base.WeldingRods")
                playerObj:setSecondaryHandItem(bag)
            end

        else
            local bag = inv:AddItem("Base.Bag_Schoolbag") bag:getVisual():setTextureChoice(0) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.WaterBottle")
                container:AddItem("Base.Crisps")
                container:AddItem("Base.BaseballBat")
                container:AddItem("Base.Hammer")
                playerObj:setClothingItem_Back(bag)
            end
        end
    end

	if not SandboxVars.StarterKit then
		if playerObj:hasTrait(CharacterTrait.HIKER) then
			local bag = inv:AddItem("Base.Bag_NormalHikingBag") bag:getVisual():setTextureChoice(3) bag:synchWithVisual()
            if bag then
                local container = bag:getItemContainer()
                container:AddItem("Base.Shoes_HikingBoots")
                playerObj:setClothingItem_Back(bag)
            end
        end
    end
end

Events.OnNewGame.Add(SpawnItems.OnNewGame)