if GetLocale() ~= "deDE" then return end -- only for the German client..

local ADDONNAME = ...

-- Used in the Level up display when entering new floor
JAILERS_TOWER_SCENARIO_FLOOR = "Flur %d"

-- Change the floor text in the ObjectTracker widget for Torghast
if IsAddOnLoaded("Blizzard_UIWidgets") then
    local data = UIWidgetManager.widgetVisTypeInfo[Enum.UIWidgetVisualizationType.ScenarioHeaderCurrenciesAndBackground]
    local func = data.visInfoDataFunction

    local isFixed = false
    data.visInfoDataFunction = function(widgetID, ...)
        local widgetInfo = func(widgetID, ...)
        if widgetID == 2319 and widgetInfo then -- the Torghast info widget
            local headerText = widgetInfo.headerText
            if type(headerText) == "string" then
                if headerText:find("Ebene") then
                    widgetInfo.headerText = headerText:gsub("Ebene", "Flur")
                elseif not isFixed then
                    isFixed = true
                    local addonDisplayName = GetAddOnMetadata(ADDONNAME, "Title")
                    print(string.format("|cFF3399FF%s|r: %s",
                        addonDisplayName, "Blizzard Übersetzt 'Floor' nicht mehr als 'Ebene'."
                    ))
                end
            end
        end
        return widgetInfo
    end
else
    local addonDisplayName = GetAddOnMetadata(ADDONNAME, "Title")
    print(string.format("|cFF3399FF%s|r: %s", addonDisplayName, "Blizzard_UIWidgets wurde nicht geladen.."))
end
