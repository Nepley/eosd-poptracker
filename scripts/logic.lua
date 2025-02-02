function canStage34()
    return Tracker:ProviderCountForCode('lives_3_4') <= Tracker:ProviderCountForCode('lives') and Tracker:ProviderCountForCode('bombs_3_4') <= Tracker:ProviderCountForCode('bombs') and Tracker:FindObjectForCode('lower_difficulty_3_4').CurrentStage <= Tracker:FindObjectForCode('lower_difficulty').CurrentStage
end

function canStage56()
    return Tracker:ProviderCountForCode('lives_5_6') <= Tracker:ProviderCountForCode('lives') and Tracker:ProviderCountForCode('bombs_5_6') <= Tracker:ProviderCountForCode('bombs') and Tracker:FindObjectForCode('lower_difficulty_5_6').CurrentStage <= Tracker:FindObjectForCode('lower_difficulty').CurrentStage
end

function canHard()
    return Tracker:FindObjectForCode('lower_difficulty').CurrentStage >= 1
end

function canNormal()
    return Tracker:FindObjectForCode('lower_difficulty').CurrentStage >= 2
end

function canEasy()
    return Tracker:FindObjectForCode('lower_difficulty').CurrentStage >= 3
end

function canExtra()
    return Tracker:ProviderCountForCode('lives_extra') <= Tracker:ProviderCountForCode('lives') and Tracker:ProviderCountForCode('bombs_extra') <= Tracker:ProviderCountForCode('bombs')
end

function noShotNoDifficulty()
    return not Tracker:FindObjectForCode('shot_type_check').Active and not Tracker:FindObjectForCode('difficulty_check').Active
end

function hasShotNoDifficulty()
    return Tracker:FindObjectForCode('shot_type_check').Active and not Tracker:FindObjectForCode('difficulty_check').Active
end

function noShotHasDifficulty()
    return not Tracker:FindObjectForCode('shot_type_check').Active and Tracker:FindObjectForCode('difficulty_check').Active
end

function hasShotHasDifficulty()
    return Tracker:FindObjectForCode('shot_type_check').Active and Tracker:FindObjectForCode('difficulty_check').Active
end

function extraStage()
    return Tracker:FindObjectForCode('extra_stage_included').CurrentStage >= 1
end