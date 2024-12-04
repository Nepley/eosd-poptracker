function canStage34()
    return Tracker:ProviderCountForCode('lives_3_4') <= Tracker:ProviderCountForCode('lives') and Tracker:ProviderCountForCode('bombs_3_4') <= Tracker:ProviderCountForCode('bombs') and Tracker:FindObjectForCode('lower_difficulty_3_4').CurrentStage <= Tracker:FindObjectForCode('lower_difficulty').CurrentStage
end

function canStage56()
    return Tracker:ProviderCountForCode('lives_5_6') <= Tracker:ProviderCountForCode('lives') and Tracker:ProviderCountForCode('bombs_5_6') <= Tracker:ProviderCountForCode('bombs') and Tracker:FindObjectForCode('lower_difficulty_5_6').CurrentStage <= Tracker:FindObjectForCode('lower_difficulty').CurrentStage
end
