ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CURRENT_INDEX = -1

function onClear(slotData)
    CURRENT_INDEX = -1

    -- Reset Locations
    for _, layoutLocationPath in pairs(LOCATION_MAPPING) do
        if layoutLocationPath[1] then
            local layoutLocationObject = Tracker:FindObjectForCode(layoutLocationPath[1])

            if layoutLocationObject then
                if layoutLocationPath[1]:sub(1, 1) == "@" then
                    layoutLocationObject.AvailableChestCount = layoutLocationObject.ChestCount
                else
                    layoutLocationObject.Active = false
                end
            end
        end
    end

    -- Reset Items
    for _, layoutItemData in pairs(ITEM_MAPPING) do
        if layoutItemData[1] and layoutItemData[2] then
            local layoutItemObject = Tracker:FindObjectForCode(layoutItemData[1])

            if layoutItemObject then
                if layoutItemData[2] == "toggle" then
                    layoutItemObject.Active = false
                elseif layoutItemData[2] == "progressive" then
                    layoutItemObject.CurrentStage = 0
                    layoutItemObject.Active = false
                elseif layoutItemData[2] == "consumable" then
                    layoutItemObject.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: Unknown item type %s for code %s", layoutItemData[2], layoutItemData[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: Could not find object for code %s", layoutItemData[1]))
            end
        end
    end

    -- Reset Logic
    Tracker:FindObjectForCode("lives_3_4").AcquiredCount = slotData['number_life_mid']
    Tracker:FindObjectForCode("bombs_3_4").AcquiredCount = slotData['number_bomb_mid']
    Tracker:FindObjectForCode("lower_difficulty_3_4").CurrentStage = slotData['difficulty_mid']
    Tracker:FindObjectForCode("lives_5_6").AcquiredCount = slotData['number_life_end']
    Tracker:FindObjectForCode("bombs_5_6").AcquiredCount = slotData['number_bomb_end']
    Tracker:FindObjectForCode("lower_difficulty_5_6").CurrentStage = slotData['difficulty_end']
    Tracker:FindObjectForCode("lives_extra").AcquiredCount = slotData['number_life_extra']
    Tracker:FindObjectForCode("bombs_extra").AcquiredCount = slotData['number_bomb_extra']
    Tracker:FindObjectForCode("extra_stage_included").CurrentStage = slotData['extra_stage']
    Tracker:FindObjectForCode("shot_type_check").Active = slotData['shot_type']
    Tracker:FindObjectForCode("difficulty_check").Active = slotData['difficulty_check']
end

function onItem(index, itemId, itemName, playerNumber)
    if index <= CURRENT_INDEX then
        return
    end

    CURRENT_INDEX = index

    --- Special case for the extra stage when it's in progressive mode
    if(itemId == 60013 and Tracker:FindObjectForCode("stage_unlocked").CurrentStage >= 5) then
        itemId = 60017
    end

    local itemObject = ITEM_MAPPING[itemId]

    if not itemObject or not itemObject[1] then
        return
    end

    local trackerItemObject = Tracker:FindObjectForCode(itemObject[1])

    if trackerItemObject then
        if itemObject[2] == "toggle" then
            trackerItemObject.Active = true
        elseif itemObject[2] == "progressive" then
            trackerItemObject.CurrentStage = trackerItemObject.CurrentStage + 1
        elseif itemObject[2] == "consumable" then
            trackerItemObject.AcquiredCount = trackerItemObject.AcquiredCount + ITEM_MAPPING[itemId][3]
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: Unknown item type %s for code %s", itemObject[2], itemObject[1]))
        end
    else
        print(string.format("onItem: Could not find object for code %s", itemObject[1]))
    end
end

function onLocation(locationId, locationName)
    local locationObject = LOCATION_MAPPING[locationId]

    if not locationObject or not locationObject[1] then
        return
    end

    for _, location in ipairs(locationObject) do
        local trackerLocationObject = Tracker:FindObjectForCode(location)

        if trackerLocationObject then
            if location:sub(1, 1) == "@" then
                trackerLocationObject.AvailableChestCount = trackerLocationObject.AvailableChestCount - 1
            else
                trackerLocationObject.Active = false
            end
        else
            print(string.format("onLocation: Could not find object for code %s", location))
        end
    end
end

Archipelago:AddClearHandler("Clear", onClear)
Archipelago:AddItemHandler("Item", onItem)
Archipelago:AddLocationHandler("Location", onLocation)