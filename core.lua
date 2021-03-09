if GetLocale() ~= "deDE" then return end -- only for the German client..
if select(4, GetBuildInfo()) >= 90005 then return end -- Blizzard fixed it with 9.0.5

local ADDONNAME = ...
local function Print(...)
    print(string.format("|cFF3399FF%s|r: %s", ADDONNAME, tostringall(...)))
end

-- Used in the Level up display when entering new floor
if JAILERS_TOWER_SCENARIO_FLOOR:find("Ebene") then
    JAILERS_TOWER_SCENARIO_FLOOR = "Flur %d"
else
    Print("Blizzard(LOCALE) Übersetzt 'Floor' nicht mehr als 'Ebene'.")
end

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
                    Print("Blizzard(Widget) Übersetzt 'Floor' nicht mehr als 'Ebene'.")
                end
            end
        end
        return widgetInfo
    end
else
    Print("Blizzard_UIWidgets wurde nicht geladen..")
end
