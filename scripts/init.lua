ENABLE_DEBUG_LOG = true

ScriptHost:LoadScript("scripts/logic.lua")
Tracker:AddItems("items/items.json")
Tracker:AddMaps("maps/maps.json")

Tracker:AddLocations("locations/noShotNoDifficulty.json")
Tracker:AddLocations("locations/noShotHasDifficulty.json")
Tracker:AddLocations("locations/hasShotNoDifficulty.json")
Tracker:AddLocations("locations/hasShotHasDifficulty.json")

Tracker:AddLayouts("layouts/resources.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/maps.json")

Tracker:AddLayouts("layouts/tracker.json")

if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end