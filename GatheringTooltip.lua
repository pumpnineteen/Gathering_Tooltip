local addonName, addonTable = ...
local GT = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

-- Initialize localization
local L = LibStub("AceLocale-3.0"):GetLocale("GatheringTooltip")
local NL = LibStub("AceLocale-3.0"):GetLocale("GatheringTooltipNodes")

-- Expansion determination code from LibBagUtils.lua
local WOW_PROJECT_ID = _G.WOW_PROJECT_ID
local WOW_PROJECT_CLASSIC = _G.WOW_PROJECT_CLASSIC
local WOW_PROJECT_BURNING_CRUSADE_CLASSIC = _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local WOW_PROJECT_WRATH_CLASSIC = _G.WOW_PROJECT_WRATH_CLASSIC
local WOW_PROJECT_CATACLYSM_CLASSIC = _G.WOW_PROJECT_CATACLYSM_CLASSIC
local WOW_PROJECT_MISTS_CLASSIC = _G.WOW_PROJECT_MISTS_CLASSIC
local WOW_PROJECT_MAINLINE = _G.WOW_PROJECT_MAINLINE
local LE_EXPANSION_LEVEL_CURRENT = _G.LE_EXPANSION_LEVEL_CURRENT
local LE_EXPANSION_BURNING_CRUSADE =_G.LE_EXPANSION_BURNING_CRUSADE
local LE_EXPANSION_WRATH_OF_THE_LICH_KING = _G.LE_EXPANSION_WRATH_OF_THE_LICH_KING
local LE_EXPANSION_CATACLYSM = _G.LE_EXPANSION_CATACLYSM
local LE_EXPANSION_MISTS = _G.LE_EXPANSION_MISTS_OF_PANDARIA

local function IsClassicWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

local function IsTBCWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE
end

local function IsWrathWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING
end

local function IsCataWow() --luacheck: ignore 212
    return WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CATACLYSM
end

local function IsMopWow()
    return WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC and LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_MISTS
end

local format                = format
local tonumber              = tonumber
local tostring              = tostring
local pairs                 = pairs
local ipairs                = ipairs
local floor                 = math.floor
local table                 = table
local select                = select
local print                 = print
local type                  = type

local IsResting             = IsResting
local GetTime               = GetTime
local UIErrorsFrame         = UIErrorsFrame
local GetNumSkillLines      = GetNumSkillLines
local GetSkillLineInfo      = GetSkillLineInfo
local UnitGUID              = UnitGUID
local UnitLevel             = UnitLevel
local GetSkillLevel         = GetSkillLevel
local GetMaxSkillLevel      = GetMaxSkillLevel
local EnumerateTooltipLines = EnumerateTooltipLines
local GetSkillColor         = GetSkillColor
local GetRealZoneText       = GetRealZoneText
local GetZoneText           = GetZoneText
local GetChatTypeIndex      = GetChatTypeIndex

local nodeNameList = {
    -- Classic Mining Nodes --
    NL["Ooze Covered Gold Vein"],
    NL["Ooze Covered Mithril Deposit"],
    NL["Ooze Covered Rich Thorium Vein"],
    NL["Ooze Covered Silver Vein"],
    NL["Ooze Covered Thorium Vein"],
    NL["Ooze Covered Truesilver Deposit"],
    NL["Copper Vein"],
    NL["Dark Iron Deposit"],
    NL["Iron Deposit"],
    NL["Gold Vein"],
    NL["Mithril Deposit"],
    NL["Tin Vein"],
    NL["Rich Thorium Vein"],
    NL["Silver Vein"],
    NL["Small Thorium Vein"],
    NL["Tin Vein"],
    NL["Truesilver Deposit"],
    -- TBC Mining Nodes --
    NL["Fel Iron Deposit"],
    NL["Adamantite Deposit"],
    NL["Rich Adamantite Deposit"],
    NL["Khorium Vein"],
    -- WOTLK Mining Nodes --
    NL["Cobalt Deposit"],
    NL["Rich Cobalt Deposit"],
    NL["Rich Saronite Deposit"],
    NL["Saronite Deposit"],
    NL["Titanium Vein"],
    -- Cataclysm Mining Nodes --
    NL["Obsidium Deposit"],
    NL["Rich Obsidium Deposit"],
    NL["Elementium Vein"],
    NL["Rich Elementium Vein"],
    NL["Pyrite Deposit"],
    NL["Rich Pyrite Deposit"],
    -- MOP Mining Nodes --
    NL["Ghost Iron Deposit"],
    NL["Rich Ghost Iron Deposit"],
    NL["Kyparite Deposit"],
    NL["Rich Kyparite Deposit"],
    NL["Trillium Vein"],
    NL["Rich Trillium Vein"],

    -- Classic Ores --
    NL["Copper Ore"],
    NL["Tin Ore"],
    NL["Silver Ore"],
    NL["Dark Iron Ore"],
    NL["Iron Ore"],
    NL["Gold Ore"],
    NL["Mithril Ore"],
    NL["Truesilver Ore"],
    NL["Thorium Ore"],
    -- TBC Ores --
    NL["Fel Iron Ore"],
    NL["Adamantite Ore"],
    NL["Khorium Ore"],
    -- WOTLK Ores --
    NL["Cobalt Ore"],
    NL["Saronite Ore"],
    NL["Titanium Ore"],
    -- Cataclysm Ores --
    NL["Obsidium Ore"],
    NL["Elementium Ore"],
    NL["Pyrite Ore"],
    -- MOP Ores --
    NL["Ghost Iron Ore"],
    NL["Kyparite"],
    NL["Black Trillium Ore"],
    NL["White Trillium Ore"],

    -- Classic Herbalism Nodes --
    NL["Peacebloom"],
    NL["Silverleaf"],
    NL["Earthroot"],
    NL["Mageroyal"],
    NL["Briarthorn"],
    NL["Stranglekelp"],
    NL["Bruiseweed"],
    NL["Wild Steelbloom"],
    NL["Grave Moss"],
    NL["Kingsblood"],
    NL["Liferoot"],
    NL["Fadeleaf"],
    NL["Goldthorn"],
    NL["Khadgar's Whisker"],
    NL["Wintersbite"],
    NL["Firebloom"],
    NL["Purple Lotus"],
    NL["Arthas' Tears"],
    NL["Sungrass"],
    NL["Blindweed"],
    NL["Ghost Mushroom"],
    NL["Gromsblood"],
    NL["Golden Sansam"],
    NL["Dreamfoil"],
    NL["Mountain Silversage"],
    NL["Plaguebloom"],
    NL["Icecap"],
    NL["Black Lotus"],

    -- TBC Herbalism Nodes --
    NL["Felweed"],
    NL["Ragveil"],
    NL["Terocone"],
    NL["Ancient Lichen"],
    NL["Netherbloom"],
    NL["Nightmare Vine"],
    NL["Mana Thistle"],

    -- WOTLK Herbalism Nodes --
    NL["Goldclover"],
    NL["Firethorn"],
    NL["Tiger Lily"],
    NL["Talandra's Rose"],
    NL["Adder's Tongue"],
    NL["Frozen Herb-Wintergrasp"],
    NL["Frozen Herb"],
    NL["Lichbloom"],
    NL["Icethorn"],
    NL["Frost Lotus"],

    -- Cataclysm Herbalism Nodes --
    NL["Azshara's Veil"],
    NL["Cinderbloom"],
    NL["Heartblossom"],
    NL["Stormvine"],
    NL["Twilight Jasmine"],
    NL["Whiptail"],

    -- MOP Herbalism Nodes --
    NL["Green Tea Leaf"],
    NL["Silkweed"],
    NL["Golden Lotus"],
    NL["Rain Poppy"],
    NL["Sha-Touched Herb"],
    NL["Snow Lily"],
    NL["Fool's Cap"],

}

local nodeInfo = {
    -- Classic Mining Nodes --
    [NL["Copper Vein"]] = { skill = L["Mining"], thresholds = { grey = 100, green = 25, yellow = 50 }, requiredSkill = 1 },
    [NL["Tin Vein"]] = { skill = L["Mining"], thresholds = { grey = 165, green = 90, yellow = 115 }, requiredSkill = 65 },
    [NL["Silver Vein"]] = { skill = L["Mining"], thresholds = { grey = 175, green = 100, yellow = 125 }, requiredSkill = 75 },
    [NL["Ooze Covered Silver Vein"]] = { skill = L["Mining"], thresholds = { grey = 175, green = 100, yellow = 125 }, requiredSkill = 75 },
    [NL["Iron Deposit"]] = { skill = L["Mining"], thresholds = { grey = 225, green = 150, yellow = 175 }, requiredSkill = 125 },
    [NL["Gold Vein"]] = { skill = L["Mining"], thresholds = { grey = 255, green = 180, yellow = 205 }, requiredSkill = 155 },
    [NL["Ooze Covered Gold Vein"]] = { skill = L["Mining"], thresholds = { grey = 255, green = 180, yellow = 205 }, requiredSkill = 155 },
    [NL["Mithril Deposit"]] = { skill = L["Mining"], thresholds = { grey = 275, green = 200, yellow = 225 }, requiredSkill = 175 },
    [NL["Ooze Covered Mithril Deposit"]] = { skill = L["Mining"], thresholds = { grey = 275, green = 200, yellow = 225 }, requiredSkill = 175 },
    [NL["Dark Iron Deposit"]] = { skill = L["Mining"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Truesilver Deposit"]] = { skill = L["Mining"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Ooze Covered Truesilver Deposit"]] = { skill = L["Mining"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Small Thorium Vein"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 245 },
    [NL["Rich Thorium Vein"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 275 },
    [NL["Ooze Covered Thorium Vein"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 245 },
    [NL["Ooze Covered Rich Thorium Vein"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 275 },

    -- TBC Mining Nodes --
    [NL["Fel Iron Deposit"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 325 }, requiredSkill = 300 },
    [NL["Adamantite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 375, green = 300, yellow = 350 }, requiredSkill = 325 },
    [NL["Rich Adamantite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 400, green = 325, yellow = 375 }, requiredSkill = 350 },
    [NL["Khorium Vein"]] = { skill = L["Mining"], thresholds = { grey = 400, green = 375, yellow = 375 }, requiredSkill = 375 },

    -- WOTLK Mining Nodes --
    [NL["Cobalt Deposit"]] = { skill = L["Mining"], thresholds = { grey = 450, green = 400, yellow = 375 }, requiredSkill = 350 },
    [NL["Rich Cobalt Deposit"]] = { skill = L["Mining"], thresholds = { grey = 475, green = 425, yellow = 400 }, requiredSkill = 375 },
    [NL["Rich Saronite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 525, green = 475, yellow = 450 }, requiredSkill = 425 },
    [NL["Saronite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 500, green = 450, yellow = 425 }, requiredSkill = 400 },
    [NL["Titanium Vein"]] = { skill = L["Mining"], thresholds = { grey = 550, green = 500, yellow = 475 }, requiredSkill = 450 },

    -- Cataclysm Mining Nodes --
    [NL["Obsidium Deposit"]] = { skill = L["Mining"], thresholds = { grey = 525, green = 475, yellow = 425 }, requiredSkill = 425 },
    [NL["Rich Obsidium Deposit"]] = { skill = L["Mining"], thresholds = { grey = 575, green = 525, yellow = 475 }, requiredSkill = 450 },
    [NL["Elementium Vein"]] = { skill = L["Mining"], thresholds = { grey = 575, green = 525, yellow = 475 }, requiredSkill = 475 },
    [NL["Rich Elementium Vein"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 500 },
    [NL["Pyrite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 525 },
    [NL["Rich Pyrite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 525 },

    -- MOP Mining Nodes --
    [NL["Ghost Iron Deposit"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 500 },
    [NL["Rich Ghost Iron Deposit"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 575, yellow = 550 }, requiredSkill = 550 },
    [NL["Kyparite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 575, yellow = 550 }, requiredSkill = 550 },
    [NL["Rich Kyparite Deposit"]] = { skill = L["Mining"], thresholds = { grey = 625, green = 600, yellow = 575 }, requiredSkill = 575 },
    [NL["Trillium Vein"]] = { skill = L["Mining"], thresholds = { grey = 625, green = 600, yellow = 600 }, requiredSkill = 600 },
    [NL["Rich Trillium Vein"]] = { skill = L["Mining"], thresholds = { grey = 625, green = 600, yellow = 600 }, requiredSkill = 600 },

    -- Classic Ores --
    [NL["Copper Ore"]] = { skill = L["Mining"], thresholds = { grey = 100, green = 25, yellow = 50 }, requiredSkill = 1 },
    [NL["Tin Ore"]] = { skill = L["Mining"], thresholds = { grey = 165, green = 90, yellow = 115 }, requiredSkill = 65 },
    [NL["Silver Ore"]] = { skill = L["Mining"], thresholds = { grey = 175, green = 100, yellow = 125 }, requiredSkill = 75 },
    [NL["Iron Ore"]] = { skill = L["Mining"], thresholds = { grey = 225, green = 150, yellow = 175 }, requiredSkill = 125 },
    [NL["Gold Ore"]] = { skill = L["Mining"], thresholds = { grey = 255, green = 180, yellow = 205 }, requiredSkill = 155 },
    [NL["Mithril Ore"]] = { skill = L["Mining"], thresholds = { grey = 275, green = 200, yellow = 225 }, requiredSkill = 175 },
    [NL["Dark Iron Ore"]] = { skill = L["Mining"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Truesilver Ore"]] = { skill = L["Mining"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Thorium Ore"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 250 },

    -- TBC Ores --
    [NL["Fel Iron Ore"]] = { skill = L["Mining"], thresholds = { grey = 350, green = 275, yellow = 325 }, requiredSkill = 300 },
    [NL["Adamantite Ore"]] = { skill = L["Mining"], thresholds = { grey = 375, green = 300, yellow = 350 }, requiredSkill = 325 },
    [NL["Khorium Ore"]] = { skill = L["Mining"], thresholds = { grey = 400, green = 375, yellow = 375 }, requiredSkill = 375 },

    -- WOTLK Ores --
    [NL["Cobalt Ore"]] = { skill = L["Mining"], thresholds = { grey = 450, green = 400, yellow = 375 }, requiredSkill = 350 },
    [NL["Saronite Ore"]] = { skill = L["Mining"], thresholds = { grey = 500, green = 450, yellow = 425 }, requiredSkill = 400 },
    [NL["Titanium Ore"]] = { skill = L["Mining"], thresholds = { grey = 550, green = 500, yellow = 475 }, requiredSkill = 450 },

    -- Cataclysm Ores --
    [NL["Obsidium Ore"]] = { skill = L["Mining"], thresholds = { grey = 525, green = 475, yellow = 425 }, requiredSkill = 425 },
    [NL["Elementium Ore"]] = { skill = L["Mining"], thresholds = { grey = 575, green = 525, yellow = 475 }, requiredSkill = 475 },
    [NL["Pyrite Ore"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 525 },
    
    -- MOP Ores --
    [NL["Ghost Iron Ore"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 550, yellow = 525 }, requiredSkill = 500 },
    [NL["Kyparite"]] = { skill = L["Mining"], thresholds = { grey = 600, green = 575, yellow = 550 }, requiredSkill = 550 },
    [NL["Black Trillium Ore"]] = { skill = L["Mining"], thresholds = { grey = 625, green = 600, yellow = 600 }, requiredSkill = 600 },
    [NL["White Trillium Ore"]] = { skill = L["Mining"], thresholds = { grey = 625, green = 600, yellow = 600 }, requiredSkill = 600 },

    -- Classic Herbalism Nodes --
    [NL["Peacebloom"]] = { skill = L["Herbalism"], thresholds = { grey = 100, green = 25, yellow = 50 }, requiredSkill = 1 },
    [NL["Silverleaf"]] = { skill = L["Herbalism"], thresholds = { grey = 100, green = 25, yellow = 50 }, requiredSkill = 1 },
    [NL["Earthroot"]] = { skill = L["Herbalism"], thresholds = { grey = 115, green = 40, yellow = 65 }, requiredSkill = 15 },
    [NL["Mageroyal"]] = { skill = L["Herbalism"], thresholds = { grey = 150, green = 75, yellow = 100 }, requiredSkill = 50 },
    [NL["Briarthorn"]] = { skill = L["Herbalism"], thresholds = { grey = 170, green = 95, yellow = 120 }, requiredSkill = 70 },
    [NL["Stranglekelp"]] = { skill = L["Herbalism"], thresholds = { grey = 185, green = 110, yellow = 135 }, requiredSkill = 85 },
    [NL["Bruiseweed"]] = { skill = L["Herbalism"], thresholds = { grey = 200, green = 125, yellow = 150 }, requiredSkill = 100 },
    [NL["Wild Steelbloom"]] = { skill = L["Herbalism"], thresholds = { grey = 215, green = 140, yellow = 165 }, requiredSkill = 115 },
    [NL["Grave Moss"]] = { skill = L["Herbalism"], thresholds = { grey = 220, green = 145, yellow = 170 }, requiredSkill = 120 },
    [NL["Kingsblood"]] = { skill = L["Herbalism"], thresholds = { grey = 225, green = 150, yellow = 175 }, requiredSkill = 125 },
    [NL["Liferoot"]] = { skill = L["Herbalism"], thresholds = { grey = 250, green = 175, yellow = 200 }, requiredSkill = 150 },
    [NL["Fadeleaf"]] = { skill = L["Herbalism"], thresholds = { grey = 260, green = 185, yellow = 210 }, requiredSkill = 160 },
    [NL["Goldthorn"]] = { skill = L["Herbalism"], thresholds = { grey = 270, green = 195, yellow = 220 }, requiredSkill = 170 },
    [NL["Khadgar's Whisker"]] = { skill = L["Herbalism"], thresholds = { grey = 285, green = 210, yellow = 235 }, requiredSkill = 185 },
    [NL["Wintersbite"]] = { skill = L["Herbalism"], thresholds = { grey = 295, green = 220, yellow = 245 }, requiredSkill = 195 },
    [NL["Firebloom"]] = { skill = L["Herbalism"], thresholds = { grey = 305, green = 230, yellow = 255 }, requiredSkill = 205 },
    [NL["Purple Lotus"]] = { skill = L["Herbalism"], thresholds = { grey = 305, green = 235, yellow = 255 }, requiredSkill = 210},
    [NL["Arthas' Tears"]] = { skill = L["Herbalism"], thresholds = { grey = 320, green = 245, yellow = 270 }, requiredSkill = 220 },
    [NL["Sungrass"]] = { skill = L["Herbalism"], thresholds = { grey = 330, green = 255, yellow = 280 }, requiredSkill = 230 },
    [NL["Blindweed"]] = { skill = L["Herbalism"], thresholds = { grey = 335, green = 260, yellow = 285 }, requiredSkill = 235 },
    [NL["Ghost Mushroom"]] = { skill = L["Herbalism"], thresholds = { grey = 345, green = 270, yellow = 295 }, requiredSkill = 245 },
    [NL["Gromsblood"]] = { skill = L["Herbalism"], thresholds = { grey = 350, green = 275, yellow = 300 }, requiredSkill = 250 },
    [NL["Golden Sansam"]] = { skill = L["Herbalism"], thresholds = { grey = 360, green = 285, yellow = 310 }, requiredSkill = 260 },
    [NL["Dreamfoil"]] = { skill = L["Herbalism"], thresholds = { grey = 370, green = 295, yellow = 320 }, requiredSkill = 270 },
    [NL["Mountain Silversage"]] = { skill = L["Herbalism"], thresholds = { grey = 380, green = 305, yellow = 330 }, requiredSkill = 280 },
    [NL["Plaguebloom"]] = { skill = L["Herbalism"], thresholds = { grey = 385, green = 310, yellow = 335 }, requiredSkill = 285 },
    [NL["Icecap"]] = { skill = L["Herbalism"], thresholds = { grey = 390, green = 315, yellow = 340 }, requiredSkill = 290 },
    [NL["Black Lotus"]] = { skill = L["Herbalism"], thresholds = { grey = 400, green = 325, yellow = 350}, requiredSkill = 300 },

    -- TBC Herbalism Nodes --
    [NL["Felweed"]] = { skill = L["Herbalism"], thresholds = { grey = 375, green = 355, yellow = 325 }, requiredSkill = 300 },
    [NL["Dreaming Glory"]] = { skill = L["Herbalism"], thresholds = { grey = 390, green = 365, yellow = 330 }, requiredSkill = 315 },
    [NL["Ragveil"]] = { skill = L["Herbalism"], thresholds = { grey = 400, green = 375, yellow = 350 }, requiredSkill = 325 },
    [NL["Terocone"]] = { skill = L["Herbalism"], thresholds = { grey = 400, green = 375, yellow = 350 }, requiredSkill = 325 },
    [NL["Ancient Lichen"]] = { skill = L["Herbalism"], thresholds = { grey = 415, green = 390, yellow = 365 }, requiredSkill = 340 },
    [NL["Netherbloom"]] = { skill = L["Herbalism"], thresholds = { grey = 435, green = 410, yellow = 385 }, requiredSkill = 350 },
    [NL["Nightmare Vine"]] = { skill = L["Herbalism"], thresholds = { grey = 435, green = 410, yellow = 365 }, requiredSkill = 365 },
    [NL["Mana Thistle"]] = { skill = L["Herbalism"], thresholds = { grey = 415, green = 390, yellow = 375 }, requiredSkill = 375 },

    -- WOTLK Herbalism Nodes --
    [NL["Goldclover"]] = { skill = L["Herbalism"], thresholds = { grey = 450, green = 400, yellow = 375 }, requiredSkill = 350 },
    [NL["Firethorn"]] = { skill = L["Herbalism"], thresholds = { grey = 460, green = 410, yellow = 385 }, requiredSkill = 360 },
    [NL["Tiger Lily"]] = { skill = L["Herbalism"], thresholds = { grey = 475, green = 425, yellow = 400 }, requiredSkill = 375 },
    [NL["Talandra's Rose"]] = { skill = L["Herbalism"], thresholds = { grey = 485, green = 435, yellow = 410 }, requiredSkill = 385 },
    [NL["Adder's Tongue"]] = { skill = L["Herbalism"], thresholds = { grey = 500, green = 450, yellow = 425 }, requiredSkill = 400 },
    [NL["Frozen Herb"]] = {
                            [L["Wintergrasp"]] = { skill = L["Herbalism"], thresholds = { grey = 515, green = 465, yellow = 440 }, requiredSkill = 415 },
                            ["any"] = { skill = L["Herbalism"], thresholds = { grey = 500, green = 450, yellow = 425 }, requiredSkill = 400 },
                            },
    [NL["Lichbloom"]] = { skill = L["Herbalism"], thresholds = { grey = 525, green = 475, yellow = 450 }, requiredSkill = 425 },
    [NL["Icethorn"]] = { skill = L["Herbalism"], thresholds = { grey = 535, green = 485, yellow = 460 }, requiredSkill = 435 },
    [NL["Frost Lotus"]] = { skill = L["Herbalism"], thresholds = { grey = 550, green = 500, yellow = 475 }, requiredSkill = 450 },

    -- Cataclysm Herbalism Nodes --
    [NL["Azshara's Veil"]] = { skill = L["Herbalism"], thresholds = { grey = 550, green = 500, yellow = 425 }, requiredSkill = 425 },
    [NL["Cinderbloom"]] = { skill = L["Herbalism"], thresholds = { grey = 525, green = 475, yellow = 425 }, requiredSkill = 425 },
    [NL["Heartblossom"]] = { skill = L["Herbalism"], thresholds = { grey = 575, green = 525, yellow = 475 }, requiredSkill = 475 },
    [NL["Stormvine"]] = { skill = L["Herbalism"], thresholds = { grey = 525, green = 475, yellow = 425 }, requiredSkill = 425 },
    [NL["Twilight Jasmine"]] = { skill = L["Herbalism"], thresholds = { grey = 625, green = 575, yellow = 525 }, requiredSkill = 525 },
    [NL["Whiptail"]] = { skill = L["Herbalism"], thresholds = { grey = 600, green = 550, yellow = 500 }, requiredSkill = 500 },

    -- MOP Herbalism Nodes --
    [NL["Green Tea Leaf"]] = { skill = L["Herbalism"], thresholds = { grey = 600, green = 550, yellow = 500 }, requiredSkill = 500 },
    [NL["Silkweed"]] = { skill = L["Herbalism"], thresholds = { grey = 645, green = 595, yellow = 545 }, requiredSkill = 545 },
    [NL["Golden Lotus"]] = { skill = L["Herbalism"], thresholds = { grey = 650, green = 600, yellow = 550 }, requiredSkill = 550 },
    [NL["Rain Poppy"]] = { skill = L["Herbalism"], thresholds = { grey = 625, green = 575, yellow = 525 }, requiredSkill = 525 },
    [NL["Sha-Touched Herb"]] = { skill = L["Herbalism"], thresholds = { grey = 675, green = 625, yellow = 575 }, requiredSkill = 575 },
    [NL["Snow Lily"]] = { skill = L["Herbalism"], thresholds = { grey = 675, green = 625, yellow = 575 }, requiredSkill = 575 },
    [NL["Fool's Cap"]] = { skill = L["Herbalism"], thresholds = { grey = 700, green = 650, yellow = 600 }, requiredSkill = 600 },

    -- Classic Fishing Nodes --
    
}

local skinnable_npcs = {
    [524] = true, -- Rockhide Boar > classic/tbc
    [5287] = true, -- Longtooth Howler > classic/tbc
    [8961] = true, -- Felpaw Ravager > classic/tbc
    [3810] = true, -- Elder Ashenvale Bear > classic/tbc
    [5349] = true, -- Arash-ethis > classic/tbc
    [731] = true, -- King Bangalash > classic/tbc
    [12677] = true, -- Shadumbra > classic/tbc
    [4512] = true, -- Rotting Agam'ar > classic/tbc
    [17199] = true, -- Ravager Specimen > classic/tbc
    [2522] = true, -- Jaguero Stalker > classic/tbc
    [3472] = true, -- Washte Pawne > classic/tbc
    [5708] = true, -- Spawn of Hakkar > classic/tbc
    [4356] = true, -- Bloodfen Razormaw > classic/tbc
    [4422] = true, -- Agathelos the Raging > classic/tbc
    [4425] = true, -- Blind Hunter > classic/tbc
    [16117] = true, -- Plagued Swine > classic/tbc
    [16932] = true, -- Razorfang Hatchling > classic/tbc
    [2753] = true, -- Barnabus > classic/tbc
    [4341] = true, -- Drywallow Crocolisk > classic/tbc
    [17527] = true, -- Enraged Ravager > classic/tbc
    [9696] = true, -- Bloodaxe Worg > classic/tbc
    [5424] = true, -- Scorpid Dunestalker > classic/tbc
    [10882] = true, -- Arikara > classic/tbc
    [4355] = true, -- Bloodfen Scytheclaw > classic/tbc
    [14234] = true, -- Hayoc > classic/tbc
    [2658] = true, -- Razorbeak Gryphon > classic/tbc
    [2734] = true, -- Ridge Stalker Patriarch > classic/tbc
    [767] = true, -- Swamp Jaguar > classic/tbc
    [5053] = true, -- Deviate Crocolisk > classic/tbc
    [8336] = true, -- Hakkari Sapper > classic/tbc
    [2351] = true, -- Gray Bear > classic/tbc
    [976] = true, -- Kurzen War Tiger > classic/tbc
    [4347] = true, -- Noxious Reaver > classic/tbc
    [2960] = true, -- Prairie Wolf Alpha > classic/tbc
    [4548] = true, -- Steelsnap > classic/tbc
    [7445] = true, -- Elder Shardtooth > classic/tbc
    [1188] = true, -- Grizzled Black Bear > classic/tbc
    [1514] = true, -- Mokk the Savage > classic/tbc
    [13323] = true, -- Subterranean Diemetradon > classic/tbc
    [10806] = true, -- Ursius > classic/tbc
    [8301] = true, -- Clack the Reaver > classic/tbc
    [1817] = true, -- Diseased Wolf > classic/tbc
    [5305] = true, -- Frayfeather Skystormer > classic/tbc
    [5935] = true, -- Ironeye the Invincible > classic/tbc
    [16355] = true, -- Lesser Scourgebat > classic/tbc
    [3581] = true, -- Sewer Beast > classic/tbc
    [7443] = true, -- Shardtooth Mauler > classic/tbc
    [2850] = true, -- Broken Tooth > classic/tbc
    [3641] = true, -- Deviate Lurker > classic/tbc
    [9684] = true, -- Lar'korwi > classic/tbc
    [7446] = true, -- Rabid Shardtooth > classic/tbc
    [14233] = true, -- Ripscale > classic/tbc
    [5988] = true, -- Scorpok Stinger > classic/tbc
    [5425] = true, -- Starving Blisterpaw > classic/tbc
    [12678] = true, -- Ursangous > classic/tbc
    [2681] = true, -- Vilebranch Raiding Wolf > classic/tbc
    [345] = true, -- Bellygrub > classic/tbc
    [10221] = true, -- Bloodaxe Worg Pup > classic/tbc
    [10077] = true, -- Deathmaw > classic/tbc
    [3099] = true, -- Dire Mottled Boar > classic/tbc
    [16348] = true, -- Ghostclaw Lynx > classic/tbc
    [3823] = true, -- Ghostpaw Runner > classic/tbc
    [1020] = true, -- Mottled Raptor > classic/tbc
    [4142] = true, -- Sparkleshell Tortoise > classic/tbc
    [15651] = true, -- Springpaw Stalker > classic/tbc
    [5431] = true, -- Surf Glider > classic/tbc
    [14222] = true, -- Araga > classic/tbc
    [728] = true, -- Bhag'thera > classic/tbc
    [1557] = true, -- Elder Mistvale Gorilla > classic/tbc
    [3100] = true, -- Elder Mottled Boar > classic/tbc
    [3056] = true, -- Ghost Howl > classic/tbc
    [16349] = true, -- Ghostclaw Ravager > classic/tbc
    [8303] = true, -- Grunter > classic/tbc
    [1126] = true, -- Large Crag Boar > classic/tbc
    [2071] = true, -- Moonstalker Matriarch > classic/tbc
    [8761] = true, -- Mosshoof Courser > classic/tbc
    [3674] = true, -- Skum > classic/tbc
    [1130] = true, -- Bjarn > classic/tbc
    [4250] = true, -- Galak Packhound > classic/tbc
    [13036] = true, -- Gordok Mastiff > classic/tbc
    [5828] = true, -- Humar the Pridelord > classic/tbc
    [1199] = true, -- Juvenile Snow Leopard > classic/tbc
    [4697] = true, -- Scorpashi Lasher > classic/tbc
    [4143] = true, -- Sparkleshell Snapper > classic/tbc
    [6516] = true, -- Un'Goro Thunderer > classic/tbc
    [8956] = true, -- Angerclaw Bear > classic/tbc
    [5992] = true, -- Ashmane Boar > classic/tbc
    [833] = true, -- Coyote Packleader > classic/tbc
    [3631] = true, -- Deviate Stinglash > classic/tbc
    [6498] = true, -- Devilsaur > classic/tbc
    [1815] = true, -- Diseased Black Bear > classic/tbc
    [1816] = true, -- Diseased Grizzly > classic/tbc
    [9164] = true, -- Elder Diemetradon > classic/tbc
    [15652] = true, -- Elder Springpaw > classic/tbc
    [2089] = true, -- Giant Wetlands Crocolisk > classic/tbc
    [5291] = true, -- Hakkari Frostwing > classic/tbc
    [2407] = true, -- Hulking Mountain Lion > classic/tbc
    [1551] = true, -- Ironjaw Basilisk > classic/tbc
    [687] = true, -- Jungle Stalker > classic/tbc
    [3474] = true, -- Lakota'mani > classic/tbc
    [1108] = true, -- Mistvale Gorilla > classic/tbc
    [736] = true, -- Panther > classic/tbc
    [2958] = true, -- Prairie Wolf > classic/tbc
    [5427] = true, -- Rabid Blisterpaw > classic/tbc
    [565] = true, -- Rabid Dire Wolf > classic/tbc
    [5990] = true, -- Redstone Basilisk > classic/tbc
    [6503] = true, -- Spiked Stegodon > classic/tbc
    [1765] = true, -- Worg > classic/tbc
    [20387] = true, -- Young Sporebat > classic/tbc
    [10268] = true, -- Gizrul the Slavener > classic/tbc
    [5834] = true, -- Azzere the Skyblade > classic/tbc
    [4357] = true, -- Bloodfen Lashtail > classic/tbc
    [4352] = true, -- Bloodfen Screecher > classic/tbc
    [3122] = true, -- Bloodtalon Taillasher > classic/tbc
    [20797] = true, -- Deviate Coiler Hatchling > classic/tbc
    [5056] = true, -- Deviate Dreadfang > classic/tbc
    [8960] = true, -- Felpaw Scavenger > classic/tbc
    [23873] = true, -- Goreclaw the Ravenous > classic/tbc
    [1196] = true, -- Ice Claw Bear > classic/tbc
    [5274] = true, -- Ironfur Patriarch > classic/tbc
    [12676] = true, -- Sharptalon > classic/tbc
    [729] = true, -- Sin'Dall > classic/tbc
    [11737] = true, -- Stonelash Flayer > classic/tbc
    [683] = true, -- Young Panther > classic/tbc
    [13596] = true, -- Rotgrip > classic/tbc
    [3236] = true, -- Barrens Kodo > classic/tbc
    [1189] = true, -- Black Bear Patriarch > classic/tbc
    [3123] = true, -- Bloodtalon Scythemaw > classic/tbc
    [10807] = true, -- Brumeran > classic/tbc
    [7405] = true, -- Deadly Cleft Scorpid > classic/tbc
    [5865] = true, -- Dishu > classic/tbc
    [1085] = true, -- Elder Stranglethorn Tiger > classic/tbc
    [3864] = true, -- Fel Steed > classic/tbc
    [3824] = true, -- Ghostpaw Howler > classic/tbc
    [5421] = true, -- Glasshide Petrifier > classic/tbc
    [6499] = true, -- Ironhide Devilsaur > classic/tbc
    [1559] = true, -- King Mukla > classic/tbc
    [2974] = true, -- Kodo Matriarch > classic/tbc
    [2474] = true, -- Kurdros > classic/tbc
    [3068] = true, -- Mazzranache > classic/tbc
    [17201] = true, -- Moongraze Buck > classic/tbc
    [14821] = true, -- Razzashi Raptor > classic/tbc
    [3425] = true, -- Savannah Prowler > classic/tbc
    [2408] = true, -- Snapjaw > classic/tbc
    [5928] = true, -- Sorrow Wing > classic/tbc
    [4067] = true, -- Twilight Runner > classic/tbc
    [2347] = true, -- Wild Gryphon > classic/tbc
    [856] = true, -- Young Lashtail Raptor > classic/tbc
    [1417] = true, -- Young Wetlands Crocolisk > classic/tbc
    [10220] = true, -- Halycon > classic/tbc
    [3126] = true, -- Armored Scorpid > classic/tbc
    [7055] = true, -- Blackrock Worg > classic/tbc
    [3861] = true, -- Bleak Worg > classic/tbc
    [12800] = true, -- Chimaerok > classic/tbc
    [4117] = true, -- Cloud Serpent > classic/tbc
    [3818] = true, -- Elder Shadowhorn Stag > classic/tbc
    [1713] = true, -- Elder Shadowmaw Panther > classic/tbc
    [9690] = true, -- Ember Worg > classic/tbc
    [1778] = true, -- Ferocious Grizzled Bear > classic/tbc
    [7977] = true, -- Gammerita > classic/tbc
    [3825] = true, -- Ghostpaw Alpha > classic/tbc
    [6583] = true, -- Gruff > classic/tbc
    [4316] = true, -- Kolkar Packhound > classic/tbc
    [4398] = true, -- Mudrock Burrower > classic/tbc
    [3473] = true, -- Owatanka > classic/tbc
    [2164] = true, -- Rabid Thistle Bear > classic/tbc
    [4514] = true, -- Raging Agam'ar > classic/tbc
    [2732] = true, -- Ridge Huntress > classic/tbc
    [4150] = true, -- Saltstone Gazer > classic/tbc
    [17280] = true, -- Shattered Hand Warhound > classic/tbc
    [10737] = true, -- Shy-Rotam > classic/tbc
    [3255] = true, -- Sunscale Screecher > classic/tbc
    [6379] = true, -- Thunderhead Patriarch > classic/tbc
    [6500] = true, -- Tyrant Devilsaur > classic/tbc
    [9622] = true, -- U'cha > classic/tbc
    [3816] = true, -- Wild Buck > classic/tbc
    [454] = true, -- Young Goretusk > classic/tbc
    [1084] = true, -- Young Sawtooth Crocolisk > classic/tbc
    [4274] = true, -- Fenrus the Devourer > classic/tbc
    [4824] = true, -- Aku'mai Fisher > classic/tbc
    [10990] = true, -- Alterac Ram > classic/tbc
    [3058] = true, -- Arra'chea > classic/tbc
    [19423] = true, -- Bleeding Hollow Worg > classic/tbc
    [3227] = true, -- Corrupted Bloodtalon Scythemaw > classic/tbc
    [7433] = true, -- Frostsaber Huntress > classic/tbc
    [3619] = true, -- Ghost Saber > classic/tbc
    [521] = true, -- Lupos > classic/tbc
    [10644] = true, -- Mist Howler > classic/tbc
    [16353] = true, -- Mistbat > classic/tbc
    [8602] = true, -- Monstrous Plaguebat > classic/tbc
    [4344] = true, -- Mottled Drywallow Crocolisk > classic/tbc
    [2406] = true, -- Mountain Lion > classic/tbc
    [4399] = true, -- Mudrock Borer > classic/tbc
    [4396] = true, -- Mudrock Tortoise > classic/tbc
    [8211] = true, -- Old Cliff Jumper > classic/tbc
    [8300] = true, -- Ravage > classic/tbc
    [6507] = true, -- Ravasaur Hunter > classic/tbc
    [3817] = true, -- Shadowhorn Stag > classic/tbc
    [684] = true, -- Shadowmaw Panther > classic/tbc
    [7444] = true, -- Shardtooth Bear > classic/tbc
    [3250] = true, -- Silithid Creeper > classic/tbc
    [3252] = true, -- Silithid Swarmer > classic/tbc
    [11357] = true, -- Son of Hakkar > classic/tbc
    [13599] = true, -- Stolid Snapjaw > classic/tbc
    [688] = true, -- Stone Maw Basilisk > classic/tbc
    [5807] = true, -- The Rake > classic/tbc
    [3424] = true, -- Thunderhawk Cloudscraper > classic/tbc
    [1554] = true, -- Vampiric Duskbat > classic/tbc
    [3127] = true, -- Venomtail Scorpid > classic/tbc
    [1128] = true, -- Young Black Bear > classic/tbc
    [3653] = true, -- Kresh > classic/tbc
    [4044] = true, -- Blackened Basilisk > classic/tbc
    [11368] = true, -- Bloodseeker Bat > classic/tbc
    [7448] = true, -- Chillwind Chimaera > classic/tbc
    [3225] = true, -- Corrupted Mottled Boar > classic/tbc
    [15650] = true, -- Crazed Dragonhawk > classic/tbc
    [689] = true, -- Crystal Spine Basilisk > classic/tbc
    [5048] = true, -- Deviate Adder > classic/tbc
    [3633] = true, -- Deviate Slayer > classic/tbc
    [4343] = true, -- Drywallow Snapper > classic/tbc
    [4342] = true, -- Drywallow Vicejaw > classic/tbc
    [3121] = true, -- Durotar Tiger > classic/tbc
    [2187] = true, -- Elder Darkshore Thresher > classic/tbc
    [2356] = true, -- Elder Gray Bear > classic/tbc
    [1192] = true, -- Elder Mountain Boar > classic/tbc
    [4727] = true, -- Elder Thunder Lizard > classic/tbc
    [19459] = true, -- Feng > classic/tbc
    [2728] = true, -- Feral Crag Coyote > classic/tbc
    [7447] = true, -- Fledgling Chillwind > classic/tbc
    [9165] = true, -- Fledgling Pterrordax > classic/tbc
    [5304] = true, -- Frayfeather Stagwing > classic/tbc
    [7431] = true, -- Frostsaber > classic/tbc
    [7434] = true, -- Frostsaber Pride Watcher > classic/tbc
    [7432] = true, -- Frostsaber Stalker > classic/tbc
    [2323] = true, -- Giant Foreststrider > classic/tbc
    [157] = true, -- Goretusk > classic/tbc
    [4539] = true, -- Greater Kraul Bat > classic/tbc
    [4128] = true, -- Hecklefang Stalker > classic/tbc
    [17202] = true, -- Infected Nightstalker Runt > classic/tbc
    [1114] = true, -- Jungle Thunderer > classic/tbc
    [2476] = true, -- Large Loch Crocolisk > classic/tbc
    [5286] = true, -- Longtooth Runner > classic/tbc
    [4662] = true, -- Magram Bonepaw > classic/tbc
    [1961] = true, -- Mangeclaw > classic/tbc
    [8763] = true, -- Mistwing Rogue > classic/tbc
    [2069] = true, -- Moonstalker > classic/tbc
    [2070] = true, -- Moonstalker Runt > classic/tbc
    [8236] = true, -- Muck Frenzy > classic/tbc
    [4397] = true, -- Mudrock Spikeshell > classic/tbc
    [5226] = true, -- Murk Worm > classic/tbc
    [3461] = true, -- Oasis Snapjaw > classic/tbc
    [4830] = true, -- Old Serra'kis > classic/tbc
    [4012] = true, -- Pridewing Wyvern > classic/tbc
    [118] = true, -- Prowler > classic/tbc
    [10200] = true, -- Rak'shiri > classic/tbc
    [11371] = true, -- Razzashi Serpent > classic/tbc
    [4151] = true, -- Saltstone Crystalhide > classic/tbc
    [1353] = true, -- Sarltooth > classic/tbc
    [2926] = true, -- Silvermane Stalker > classic/tbc
    [1201] = true, -- Snow Leopard > classic/tbc
    [6501] = true, -- Stegodon > classic/tbc
    [772] = true, -- Stranglethorn Tigress > classic/tbc
    [2172] = true, -- Strider Clutchmother > classic/tbc
    [730] = true, -- Tethis > classic/tbc
    [3247] = true, -- Thunderhawk Hatchling > classic/tbc
    [1132] = true, -- Timber > classic/tbc
    [6585] = true, -- Uhk'loc > classic/tbc
    [16354] = true, -- Vampiric Mistbat > classic/tbc
    [6508] = true, -- Venomhide Ravasaur > classic/tbc
    [4118] = true, -- Venomous Cloud Serpent > classic/tbc
    [1400] = true, -- Wetlands Crocolisk > classic/tbc
    [1131] = true, -- Winter Wolf > classic/tbc
    [3237] = true, -- Wooly Kodo > classic/tbc
    [854] = true, -- Young Jungle Stalker > classic/tbc
    [1224] = true, -- Young Threshadon > classic/tbc
    [14308] = true, -- Ferra > classic/tbc
    [4351] = true, -- Bloodfen Raptor > classic/tbc
    [20058] = true, -- Bloodmaul Dire Wolf > classic/tbc
    [1923] = true, -- Bloodsnout Worg > classic/tbc
    [6215] = true, -- Chomper > classic/tbc
    [7078] = true, -- Cleft Scorpid > classic/tbc
    [4126] = true, -- Crag Stalker > classic/tbc
    [14223] = true, -- Cranky Benj > classic/tbc
    [17661] = true, -- Deathclaw > classic/tbc
    [3634] = true, -- Deviate Stalker > classic/tbc
    [5755] = true, -- Deviate Viper > classic/tbc
    [14430] = true, -- Duskstalker > classic/tbc
    [4701] = true, -- Dying Kodo > classic/tbc
    [2957] = true, -- Elder Plainstrider > classic/tbc
    [15649] = true, -- Feral Dragonhawk Hatchling > classic/tbc
    [2385] = true, -- Feral Mountain Lion > classic/tbc
    [9698] = true, -- Firetail Scorpid > classic/tbc
    [12418] = true, -- Gordok Hyena > classic/tbc
    [2473] = true, -- Granistad > classic/tbc
    [547] = true, -- Great Goretusk > classic/tbc
    [3249] = true, -- Greater Thunderhawk > classic/tbc
    [5272] = true, -- Grizzled Ironfur Bear > classic/tbc
    [2165] = true, -- Grizzled Thistle Bear > classic/tbc
    [5262] = true, -- Groddoc Thunderer > classic/tbc
    [2561] = true, -- Highland Fleshstalker > classic/tbc
    [1016] = true, -- Highland Lashtail > classic/tbc
    [5268] = true, -- Ironfur Bear > classic/tbc
    [4863] = true, -- Jadespine Basilisk > classic/tbc
    [2972] = true, -- Kodo Calf > classic/tbc
    [4538] = true, -- Kraul Bat > classic/tbc
    [119] = true, -- Longsnout > classic/tbc
    [4660] = true, -- Maraudine Bonepaw > classic/tbc
    [5833] = true, -- Margol the Rager > classic/tbc
    [18213] = true, -- Mire Hydra > classic/tbc
    [5225] = true, -- Murk Spitter > classic/tbc
    [8601] = true, -- Noxious Plaguebat > classic/tbc
    [4348] = true, -- Noxious Shredder > classic/tbc
    [5352] = true, -- Old Grizzlegut > classic/tbc
    [8600] = true, -- Plaguebat > classic/tbc
    [4013] = true, -- Pridewing Skyhunter > classic/tbc
    [9166] = true, -- Pterrordax > classic/tbc
    [4690] = true, -- Rabid Bonepaw > classic/tbc
    [2659] = true, -- Razorbeak Skylord > classic/tbc
    [1140] = true, -- Razormaw Matriarch > classic/tbc
    [11372] = true, -- Razzashi Adder > classic/tbc
    [1150] = true, -- River Crocolisk > classic/tbc
    [5308] = true, -- Rogue Vale Screecher > classic/tbc
    [1151] = true, -- Saltwater Crocolisk > classic/tbc
    [7268] = true, -- Sandfury Guardian > classic/tbc
    [3243] = true, -- Savannah Highmane > classic/tbc
    [13896] = true, -- Scalebeard > classic/tbc
    [5422] = true, -- Scorpid Hunter > classic/tbc
    [905] = true, -- Sharptooth Frenzy > classic/tbc
    [10741] = true, -- Sian-Rotam > classic/tbc
    [2925] = true, -- Silvermane Howler > classic/tbc
    [2521] = true, -- Skymane Gorilla > classic/tbc
    [4144] = true, -- Sparkleshell Borer > classic/tbc
    [4689] = true, -- Starving Bonepaw > classic/tbc
    [11736] = true, -- Stonelash Pincer > classic/tbc
    [11735] = true, -- Stonelash Scorpid > classic/tbc
    [682] = true, -- Stranglethorn Tiger > classic/tbc
    [5842] = true, -- Takk the Leaper > classic/tbc
    [8660] = true, -- The Evalcharr > classic/tbc
    [1550] = true, -- Thrashtail Basilisk > classic/tbc
    [6375] = true, -- Thunderhead Hippogryph > classic/tbc
    [6377] = true, -- Thunderhead Stagwing > classic/tbc
    [7022] = true, -- Venomlash Scorpid > classic/tbc
    [855] = true, -- Young Stranglethorn Raptor > classic/tbc
    [15043] = true, -- Zulian Crocolisk > classic/tbc
    [11497] = true, -- The Razza > classic/tbc
    [4511] = true, -- Agam'ar > classic/tbc
    [4700] = true, -- Aged Kodo > classic/tbc
    [4702] = true, -- Ancient Kodo > classic/tbc
    [3809] = true, -- Ashenvale Bear > classic/tbc
    [1258] = true, -- Black Ravager Mastiff > classic/tbc
    [11885] = true, -- Blighthound > classic/tbc
    [5827] = true, -- Brontus > classic/tbc
    [17345] = true, -- Brown Bear > classic/tbc
    [3125] = true, -- Clattering Scorpid > classic/tbc
    [6352] = true, -- Coralshell Lurker > classic/tbc
    [3226] = true, -- Corrupted Scorpid > classic/tbc
    [2727] = true, -- Crag Coyote > classic/tbc
    [8927] = true, -- Dark Screecher > classic/tbc
    [15196] = true, -- Deathclasp > classic/tbc
    [8302] = true, -- Deatheye > classic/tbc
    [3630] = true, -- Deviate Coiler > classic/tbc
    [5762] = true, -- Deviate Moccasin > classic/tbc
    [3636] = true, -- Deviate Ravager > classic/tbc
    [3110] = true, -- Dreadmaw Crocolisk > classic/tbc
    [17348] = true, -- Elder Brown Bear > classic/tbc
    [4119] = true, -- Elder Cloud Serpent > classic/tbc
    [1127] = true, -- Elder Crag Boar > classic/tbc
    [2729] = true, -- Elder Crag Coyote > classic/tbc
    [2033] = true, -- Elder Nightsaber > classic/tbc
    [1019] = true, -- Elder Razormaw > classic/tbc
    [2635] = true, -- Elder Saltwater Crocolisk > classic/tbc
    [10992] = true, -- Enraged Panther > classic/tbc
    [1511] = true, -- Enraged Silverback Gorilla > classic/tbc
    [8959] = true, -- Felpaw Wolf > classic/tbc
    [3035] = true, -- Flatland Cougar > classic/tbc
    [3566] = true, -- Flatland Prowler > classic/tbc
    [3246] = true, -- Fleeting Plainstrider > classic/tbc
    [5300] = true, -- Frayfeather Hippogryph > classic/tbc
    [9167] = true, -- Frenzied Pterrordax > classic/tbc
    [7430] = true, -- Frostsaber Cub > classic/tbc
    [4887] = true, -- Ghamoo-ra > classic/tbc
    [3811] = true, -- Giant Ashenvale Bear > classic/tbc
    [5419] = true, -- Glasshide Basilisk > classic/tbc
    [12431] = true, -- Gorefang > classic/tbc
    [6349] = true, -- Great Wavethrasher > classic/tbc
    [1553] = true, -- Greater Duskbat > classic/tbc
    [2559] = true, -- Highland Strider > classic/tbc
    [2560] = true, -- Highland Thrasher > classic/tbc
    [4110] = true, -- Highperch Patriarch > classic/tbc
    [2973] = true, -- Kodo Bull > classic/tbc
    [977] = true, -- Kurzen War Panther > classic/tbc
    [9683] = true, -- Lar'korwi Mate > classic/tbc
    [1191] = true, -- Mangy Mountain Boar > classic/tbc
    [2923] = true, -- Mangy Silvermane > classic/tbc
    [18130] = true, -- Marshfang Ripper > classic/tbc
    [1023] = true, -- Mottled Razormaw > classic/tbc
    [1766] = true, -- Mottled Worg > classic/tbc
    [4400] = true, -- Mudrock Snapjaw > classic/tbc
    [5224] = true, -- Murk Slitherer > classic/tbc
    [12432] = true, -- Old Vicejaw > classic/tbc
    [6502] = true, -- Plated Stegodon > classic/tbc
    [2959] = true, -- Prairie Stalker > classic/tbc
    [330] = true, -- Princess > classic/tbc
    [2730] = true, -- Rabid Crag Coyote > classic/tbc
    [6581] = true, -- Ravasaur Matriarch > classic/tbc
    [11373] = true, -- Razzashi Cobra > classic/tbc
    [5991] = true, -- Redstone Crystalhide > classic/tbc
    [2731] = true, -- Ridge Stalker > classic/tbc
    [4147] = true, -- Saltstone Basilisk > classic/tbc
    [3416] = true, -- Savannah Matriarch > classic/tbc
    [3241] = true, -- Savannah Patriarch > classic/tbc
    [1552] = true, -- Scale Belly > classic/tbc
    [4304] = true, -- Scarlet Tracking Hound > classic/tbc
    [1689] = true, -- Scarred Crag Boar > classic/tbc
    [4696] = true, -- Scorpashi Snapper > classic/tbc
    [7803] = true, -- Scorpid Duneburrower > classic/tbc
    [4140] = true, -- Scorpid Reaver > classic/tbc
    [4139] = true, -- Scorpid Terror > classic/tbc
    [2175] = true, -- Shadowclaw > classic/tbc
    [4861] = true, -- Shrike Bat > classic/tbc
    [2924] = true, -- Silvermane Wolf > classic/tbc
    [5356] = true, -- Snarler > classic/tbc
    [2274] = true, -- Stanley > classic/tbc
    [2384] = true, -- Starving Mountain Lion > classic/tbc
    [5984] = true, -- Starving Snickerfang > classic/tbc
    [113] = true, -- Stonetusk Boar > classic/tbc
    [3238] = true, -- Stormhide > classic/tbc
    [3240] = true, -- Stormsnout > classic/tbc
    [3130] = true, -- Thunder Lizard > classic/tbc
    [3239] = true, -- Thunderhead > classic/tbc
    [6504] = true, -- Thunderstomp Stegodon > classic/tbc
    [5307] = true, -- Vale Screecher > classic/tbc
    [5937] = true, -- Vile Sting > classic/tbc
    [681] = true, -- Young Stranglethorn Tiger > classic/tbc
    [3426] = true, -- Zhevra Charger > classic/tbc
    [3466] = true, -- Zhevra Courser > classic/tbc
    [11361] = true, -- Zulian Tiger > classic/tbc
    [166359] = true, -- Zulian Tiger > classic/tbc
    [2956] = true, -- Adult Plainstrider > classic/tbc
    [4825] = true, -- Aku'mai Snapjaw > classic/tbc
    [11785] = true, -- Ambereye Basilisk > classic/tbc
    [8957] = true, -- Angerclaw Grizzly > classic/tbc
    [6648] = true, -- Antilos > classic/tbc
    [12801] = true, -- Arcane Chimaerok > classic/tbc
    [14280] = true, -- Big Samras > classic/tbc
    [628] = true, -- Black Ravager > classic/tbc
    [5426] = true, -- Blisterpaw Hyena > classic/tbc
    [4688] = true, -- Bonepaw Hyena > classic/tbc
    [7449] = true, -- Chillwind Ravager > classic/tbc
    [4008] = true, -- Cliff Stormer > classic/tbc
    [2174] = true, -- Coastal Frenzy > classic/tbc
    [6369] = true, -- Coralshell Tortoise > classic/tbc
    [1125] = true, -- Crag Boar > classic/tbc
    [2185] = true, -- Darkshore Thresher > classic/tbc
    [14232] = true, -- Dart > classic/tbc
    [4841] = true, -- Deadmire > classic/tbc
    [9695] = true, -- Deathlash Scorpid > classic/tbc
    [6788] = true, -- Den Mother > classic/tbc
    [9163] = true, -- Diemetradon > classic/tbc
    [12121] = true, -- Drakan > classic/tbc
    [1186] = true, -- Elder Black Bear > classic/tbc
    [4390] = true, -- Elder Murk Thresher > classic/tbc
    [2034] = true, -- Feral Nightsaber > classic/tbc
    [4031] = true, -- Fledgling Chimaera > classic/tbc
    [2321] = true, -- Foreststrider Fledgling > classic/tbc
    [5306] = true, -- Frayfeather Patriarch > classic/tbc
    [10981] = true, -- Frostwolf > classic/tbc
    [14282] = true, -- Frostwolf Bloodhound > classic/tbc
    [9697] = true, -- Giant Ember Worg > classic/tbc
    [14228] = true, -- Giggler > classic/tbc
    [1922] = true, -- Gray Forest Wolf > classic/tbc
    [4019] = true, -- Great Courser > classic/tbc
    [3235] = true, -- Greater Barrens Kodo > classic/tbc
    [17347] = true, -- Grizzled Brown Bear > classic/tbc
    [5934] = true, -- Heartrazor > classic/tbc
    [1018] = true, -- Highland Razormaw > classic/tbc
    [1017] = true, -- Highland Scytheclaw > classic/tbc
    [14227] = true, -- Hissperak > classic/tbc
    [9318] = true, -- Incendosaur > classic/tbc
    [8213] = true, -- Ironback > classic/tbc
    [3476] = true, -- Isha Awak > classic/tbc
    [3257] = true, -- Ishamuhale > classic/tbc
    [14357] = true, -- Lake Thresher > classic/tbc
    [3131] = true, -- Lightning Hide > classic/tbc
    [1693] = true, -- Loch Crocolisk > classic/tbc
    [3234] = true, -- Lost Barrens Kodo > classic/tbc
    [525] = true, -- Mangy Wolf > classic/tbc
    [17200] = true, -- Moongraze Stag > classic/tbc
    [2237] = true, -- Moonstalker Sire > classic/tbc
    [1021] = true, -- Mottled Screecher > classic/tbc
    [1022] = true, -- Mottled Scytheclaw > classic/tbc
    [1190] = true, -- Mountain Boar > classic/tbc
    [8208] = true, -- Murderous Blisterpaw > classic/tbc
    [4124] = true, -- Needles Cougar > classic/tbc
    [2043] = true, -- Nightsaber Stalker > classic/tbc
    [4346] = true, -- Noxious Flayer > classic/tbc
    [1225] = true, -- Ol' Sooty > classic/tbc
    [3245] = true, -- Ornery Plainstrider > classic/tbc
    [4249] = true, -- Pesterhide Snarler > classic/tbc
    [390] = true, -- Porcine Entourage > classic/tbc
    [4014] = true, -- Pridewing Consort > classic/tbc
    [4015] = true, -- Pridewing Patriarch > classic/tbc
    [5288] = true, -- Rabid Longtooth > classic/tbc
    [9416] = true, -- Scarshield Worg > classic/tbc
    [4699] = true, -- Scorpashi Venomlash > classic/tbc
    [5423] = true, -- Scorpid Tail Lasher > classic/tbc
    [3862] = true, -- Slavering Worg > classic/tbc
    [1152] = true, -- Snapjaw Crocolisk > classic/tbc
    [5985] = true, -- Snickerfang Hyena > classic/tbc
    [16347] = true, -- Starving Ghostclaw > classic/tbc
    [14123] = true, -- Steeljaw Snapper > classic/tbc
    [3254] = true, -- Sunscale Lashtail > classic/tbc
    [6378] = true, -- Thunderhead Skystormer > classic/tbc
    [5832] = true, -- Thunderstomp > classic/tbc
    [17372] = true, -- Timberstrider Fledgling > classic/tbc
    [9691] = true, -- Venomtip Scorpid > classic/tbc
    [2354] = true, -- Vicious Gray Bear > classic/tbc
    [2680] = true, -- Vilebranch Wolf Pup > classic/tbc
    [3463] = true, -- Wandering Barrens Giraffe > classic/tbc
    [6348] = true, -- Wavethrasher > classic/tbc
    [923] = true, -- Young Black Ravager > classic/tbc
    [4388] = true, -- Young Murk Thresher > classic/tbc
    [6347] = true, -- Young Wavethrasher > classic/tbc
    [11360] = true, -- Zulian Cub > classic/tbc
    [11365] = true, -- Zulian Panther > classic/tbc
    [11786] = true, -- Ambereye Reaver > classic/tbc
    [8958] = true, -- Angerclaw Mauler > classic/tbc
    [4018] = true, -- Antlered Courser > classic/tbc
    [3248] = true, -- Barrens Giraffe > classic/tbc
    [3868] = true, -- Blood Seeker > classic/tbc
    [17525] = true, -- Bloodmyst Hatchling > classic/tbc
    [8928] = true, -- Burrowing Thundersnout > classic/tbc
    [6167] = true, -- Chimaera Matriarch > classic/tbc
    [690] = true, -- Cold Eye Basilisk > classic/tbc
    [3231] = true, -- Corrupted Dreadmaw Crocolisk > classic/tbc
    [834] = true, -- Coyote > classic/tbc
    [4827] = true, -- Deep Pool Threshfin > classic/tbc
    [8926] = true, -- Deep Stinger > classic/tbc
    [3632] = true, -- Deviate Creeper > classic/tbc
    [3637] = true, -- Deviate Guardian > classic/tbc
    [8886] = true, -- Deviate Python > classic/tbc
    [5756] = true, -- Deviate Venomwing > classic/tbc
    [4345] = true, -- Drywallow Daggermaw > classic/tbc
    [12122] = true, -- Duros > classic/tbc
    [3475] = true, -- Echeyakee > classic/tbc
    [2322] = true, -- Foreststrider > classic/tbc
    [1797] = true, -- Giant Grizzled Bear > classic/tbc
    [5420] = true, -- Glasshide Gazer > classic/tbc
    [16095] = true, -- Gnashjaw > classic/tbc
    [3244] = true, -- Greater Plainstrider > classic/tbc
    [17374] = true, -- Greater Timberstrider > classic/tbc
    [4728] = true, -- Gritjaw Basilisk > classic/tbc
    [5260] = true, -- Groddoc Ape > classic/tbc
    [4127] = true, -- Hecklefang Hyena > classic/tbc
    [4129] = true, -- Hecklefang Snarler > classic/tbc
    [1015] = true, -- Highland Raptor > classic/tbc
    [4109] = true, -- Highperch Consort > classic/tbc
    [4107] = true, -- Highperch Wyvern > classic/tbc
    [4729] = true, -- Hulking Gritjaw Basilisk > classic/tbc
    [1516] = true, -- Konda > classic/tbc
    [14491] = true, -- Kurmokk > classic/tbc
    [686] = true, -- Lashtail Raptor > classic/tbc
    [1193] = true, -- Loch Frenzy > classic/tbc
    [8764] = true, -- Mistwing Ravager > classic/tbc
    [8759] = true, -- Mosshoof Runner > classic/tbc
    [8760] = true, -- Mosshoof Stag > classic/tbc
    [4389] = true, -- Murk Thresher > classic/tbc
    [2042] = true, -- Nightsaber > classic/tbc
    [17203] = true, -- Nightstalker > classic/tbc
    [4248] = true, -- Pesterhide Hyena > classic/tbc
    [4009] = true, -- Raging Cliff Stormer > classic/tbc
    [4726] = true, -- Raging Thunder Lizard > classic/tbc
    [6505] = true, -- Ravasaur > classic/tbc
    [6506] = true, -- Ravasaur Runner > classic/tbc
    [2173] = true, -- Reef Frenzy > classic/tbc
    [10357] = true, -- Ressan the Needler > classic/tbc
    [19458] = true, -- Ripp > classic/tbc
    [2505] = true, -- Saltwater Snapjaw > classic/tbc
    [3415] = true, -- Savannah Huntress > classic/tbc
    [1082] = true, -- Sawtooth Crocolisk > classic/tbc
    [1087] = true, -- Sawtooth Snapper > classic/tbc
    [4041] = true, -- Scorched Basilisk > classic/tbc
    [3865] = true, -- Shadow Charger > classic/tbc
    [768] = true, -- Shadow Panther > classic/tbc
    [1558] = true, -- Silverback Patriarch > classic/tbc
    [4042] = true, -- Singed Basilisk > classic/tbc
    [9694] = true, -- Slavering Ember Worg > classic/tbc
    [5829] = true, -- Snort the Heckler > classic/tbc
    [1138] = true, -- Snow Tracker Wolf > classic/tbc
    [9701] = true, -- Spire Scorpid > classic/tbc
    [213] = true, -- Starving Dire Wolf > classic/tbc
    [1133] = true, -- Starving Winter Wolf > classic/tbc
    [685] = true, -- Stranglethorn Raptor > classic/tbc
    [8095] = true, -- Sul'lithuz Sandcrawler > classic/tbc
    [3256] = true, -- Sunscale Scytheclaw > classic/tbc
    [5831] = true, -- Swiftmane > classic/tbc
    [13602] = true, -- The Abominable Greench > classic/tbc
    [2163] = true, -- Thistle Bear > classic/tbc
    [6789] = true, -- Thistle Cub > classic/tbc
    [6380] = true, -- Thunderhead Consort > classic/tbc
    [17373] = true, -- Timberstrider > classic/tbc
    [2657] = true, -- Trained Razorbeak > classic/tbc
    [6514] = true, -- Un'Goro Gorilla > classic/tbc
    [6513] = true, -- Un'Goro Stomper > classic/tbc
    [12037] = true, -- Ursol'lok > classic/tbc
    [3866] = true, -- Vile Bat > classic/tbc
    [5058] = true, -- Wolfguard Worg > classic/tbc
    [4032] = true, -- Young Chimaera > classic/tbc
    [9162] = true, -- Young Diemetradon > classic/tbc
    [822] = true, -- Young Forest Bear > classic/tbc
    [4011] = true, -- Young Pridewing > classic/tbc
    [3242] = true, -- Zhevra Runner > classic/tbc
    [20749] = true, -- Scalewing Serpent > classic/tbc
    [21864] = true, -- Scorchshell Pincer > classic/tbc
    [19784] = true, -- Coilskar Cobra > classic/tbc
    [23163] = true, -- Gezzarak the Huntress > classic/tbc
    [18670] = true, -- Ironjaw > classic/tbc
    [22123] = true, -- Rip-Blade Ravager > classic/tbc
    [18334] = true, -- Wild Elekk > classic/tbc
    [23219] = true, -- Blackwind Warp Chaser > classic/tbc
    [18648] = true, -- Stonegazer > classic/tbc
    [20502] = true, -- Eclipsion Dragonhawk > classic/tbc
    [23326] = true, -- Nethermine Ravager > classic/tbc
    [18884] = true, -- Warp Chaser > classic/tbc
    [16933] = true, -- Razorfang Ravager > classic/tbc
    [22181] = true, -- Aether Ray > classic/tbc
    [23026] = true, -- Twilight Serpent > classic/tbc
    [23267] = true, -- Arvoar the Rapacious > classic/tbc
    [20729] = true, -- Bladespire Ravager > classic/tbc
    [21123] = true, -- Felsworn Scalewing > classic/tbc
    [20673] = true, -- Swiftwing Shredder > classic/tbc
    [16934] = true, -- Quillfang Ravager > classic/tbc
    [20931] = true, -- Tyrantus > classic/tbc
    [18465] = true, -- Warp Hunter > classic/tbc
    [19350] = true, -- Thornfang Venomspitter > classic/tbc
    [20634] = true, -- Scythetooth Raptor > classic/tbc
    [18105] = true, -- Ghaz'an > classic/tbc
    [20748] = true, -- Thunderlord Dire Wolf > classic/tbc
    [19349] = true, -- Thornfang Ravager > classic/tbc
    [18280] = true, -- Sporewing > classic/tbc
    [18461] = true, -- Dampscale Basilisk > classic/tbc
    [22052] = true, -- Daggermaw Blackhide > classic/tbc
    [19729] = true, -- Ironspine Threshalisk > classic/tbc
    [21108] = true, -- Spawn of Uvuros > classic/tbc
    [19189] = true, -- Quillfang Skitterer > classic/tbc
    [18259] = true, -- Banthar > classic/tbc
    [21102] = true, -- Uvuros > classic/tbc
    [18258] = true, -- Bach'lor > classic/tbc
    [17132] = true, -- Clefthoof Bull > classic/tbc
    [18128] = true, -- Sporebat > classic/tbc
    [18464] = true, -- Warp Stalker > classic/tbc
    [20773] = true, -- Barbscale Crocolisk > classic/tbc
    [18205] = true, -- Clefthoof > classic/tbc
    [18463] = true, -- Dampscale Devourer > classic/tbc
    [20283] = true, -- Marshrock Stomper > classic/tbc
    [11359] = true, -- Soulflayer > classic/tbc
    [21124] = true, -- Felsworn Daggermaw > classic/tbc
    [16175] = true, -- Vampiric Shadowbat > classic/tbc
    [16180] = true, -- Shadikith the Glider > classic/tbc
    [21802] = true, -- Elekk Demolisher > classic/tbc
    [18880] = true, -- Nether Ray > classic/tbc
    [10430] = true, -- The Beast > classic/tbc
    [20671] = true, -- Ripfang Lynx > classic/tbc
    [23020] = true, -- Shadow Serpent > classic/tbc
    [20324] = true, -- Parched Hydra > classic/tbc
    [21956] = true, -- Rema > classic/tbc
    [20728] = true, -- Bladespire Raptor > classic/tbc
    [23501] = true, -- Netherwing Ray > classic/tbc
    [17133] = true, -- Aged Clefthoof > classic/tbc
    [21723] = true, -- Blackwind Sabercat > classic/tbc
    [18285] = true, -- "Count" Ungula > classic/tbc
    [18290] = true, -- Tusker > classic/tbc
    [20607] = true, -- Craghide Basilisk > classic/tbc
    [21854] = true, -- Ironspine Petrifier > classic/tbc
    [22807] = true, -- Lost Torranche > classic/tbc
    [20751] = true, -- Daggermaw Lashtail > classic/tbc
    [18214] = true, -- Fenclaw Thrasher > classic/tbc
    [19730] = true, -- Ironspine Gazer > classic/tbc
    [18131] = true, -- Marshfang Slicer > classic/tbc
    [19706] = true, -- Marshrock Threshalisk > classic/tbc
    [17131] = true, -- Talbuk Thorngrazer > classic/tbc
    [23169] = true, -- Nethermine Flayer > classic/tbc
    [20925] = true, -- Scalded Basilisk > classic/tbc
    [18398] = true, -- Brokentoe > classic/tbc
    [23264] = true, -- Overmine Flayer > classic/tbc
    [18879] = true, -- Phase Hunter > classic/tbc
    [18982] = true, -- Sable Jaguar > classic/tbc
    [18289] = true, -- Bull Elekk > classic/tbc
    [19183] = true, -- Clefthoof Calf > classic/tbc
    [18286] = true, -- Mragesh > classic/tbc
    [16173] = true, -- Shadowbat > classic/tbc
    [11982] = true, -- Magmadar > classic/tbc
    [23269] = true, -- Barash the Den Mother > classic/tbc
    [18129] = true, -- Greater Sporebat > classic/tbc
    [20775] = true, -- Markaru > classic/tbc
    [20039] = true, -- Phoenix-Hawk > classic/tbc
    [20038] = true, -- Phoenix-Hawk Hatchling > classic/tbc
    [17724] = true, -- Underbat > classic/tbc
    [21897] = true, -- Felspine the Greater > classic/tbc
    [20924] = true, -- Grishnath Basilisk > classic/tbc
    [17669] = true, -- Rabid Warhound > classic/tbc
    [19428] = true, -- Cobalt Serpent > classic/tbc
    [17840] = true, -- Durnholde Tracking Hound > classic/tbc
    [21816] = true, -- Ironspine Chomper > classic/tbc
    [20610] = true, -- Talbuk Doe > classic/tbc
    [17130] = true, -- Talbuk Stag > classic/tbc
    [21879] = true, -- Vilewing Chimaera > classic/tbc
    [24064] = true, -- Amani Lynx Cub > classic/tbc
    [17952] = true, -- Darkwater Crocolisk > classic/tbc
    [21462] = true, -- Greater Felfire Diemetradon > classic/tbc
    [21022] = true, -- Grovestalker Lynx > classic/tbc
    [22884] = true, -- Leviathan > classic/tbc
    [20906] = true, -- Phase-Hunter > classic/tbc
    [20280] = true, -- Ragestone Trampler > classic/tbc
    [20987] = true, -- Ruuan Weald Basilisk > classic/tbc
    [20777] = true, -- Talbuk Sire > classic/tbc
    [20330] = true, -- Bloodmaul Battle Worg > classic/tbc
    [20196] = true, -- Bloodthirsty Marshfang > classic/tbc
    [18033] = true, -- Dark Worg > classic/tbc
    [21408] = true, -- Felfire Diemetradon > classic/tbc
    [23232] = true, -- Mutant War Hound > classic/tbc
    [22100] = true, -- Scorpid Bonecrawler > classic/tbc
    [22946] = true, -- Shadowmoon War Hound > classic/tbc
    [18476] = true, -- Timber Worg > classic/tbc
    [24043] = true, -- Amani Lynx > classic/tbc
    [11673] = true, -- Ancient Core Hound > classic/tbc
    [21033] = true, -- Bladewing Bloodletter > classic/tbc
    [12802] = true, -- Chimaerok Devourer > classic/tbc
    [17731] = true, -- Fen Ray > classic/tbc
    [16174] = true, -- Greater Shadowbat > classic/tbc
    [18964] = true, -- Injured Talbuk > classic/tbc
    [21901] = true, -- Netherskate > classic/tbc
    [15554] = true, -- Number Two > classic/tbc
    [20279] = true, -- Ragestone Threshalisk > classic/tbc
    [18477] = true, -- Timber Worg Alpha > classic/tbc
    [22105] = true, -- Decrepit Clefthoof > classic/tbc
    [22885] = true, -- Dragon Turtle > classic/tbc
    [12803] = true, -- Lord Lakmaeran > classic/tbc
    [17521] = true, -- The Big Bad Wolf > classic/tbc
    [1972] = true, -- Grimson the Pale > classic/tbc
    [18093] = true, -- Tarren Mill Protector > classic/tbc
    [2250] = true, -- Mountain Yeti > classic/tbc
    [7458] = true, -- Ice Thistle Yeti > classic/tbc
    [3886] = true, -- Razorclaw the Butcher > classic/tbc
    [1782] = true, -- Moonrage Darksoul > classic/tbc
    [2452] = true, -- Skhowl > classic/tbc
    [206] = true, -- Nightbane Vile Fang > classic/tbc
    [1271] = true, -- Old Icebeard > classic/tbc
    [6170] = true, -- Gutspill > classic/tbc
    [18092] = true, -- Tarren Mill Guardsman > classic/tbc
    [5292] = true, -- Feral Scar Yeti > classic/tbc
    [3857] = true, -- Shadowfang Glutton > classic/tbc
    [3914] = true, -- Rethilgore > classic/tbc
    [5346] = true, -- Bloodroar the Stalker > classic/tbc
    [7459] = true, -- Ice Thistle Matriarch > classic/tbc
    [7457] = true, -- Rogue Ice Thistle > classic/tbc
    [3855] = true, -- Shadowfang Darksoul > classic/tbc
    [3791] = true, -- Terrowulf Shadow Weaver > classic/tbc
    [1388] = true, -- Vagash > classic/tbc
    [4279] = true, -- Odo the Blindwatcher > classic/tbc
    [2248] = true, -- Cave Yeti > classic/tbc
    [2251] = true, -- Giant Yeti > classic/tbc
    [3531] = true, -- Moonrage Tailor > classic/tbc
    [920] = true, -- Nightbane Tainted One > classic/tbc
    [3530] = true, -- Pyrewood Tailor > classic/tbc
    [18094] = true, -- Tarren Mill Lookout > classic/tbc
    [5297] = true, -- Elder Rage Scar > classic/tbc
    [5295] = true, -- Enraged Feral Scar > classic/tbc
    [3854] = true, -- Shadowfang Wolfguard > classic/tbc
    [9029] = true, -- Eviscerator > classic/tbc
    [3927] = true, -- Wolf Master Nandos > classic/tbc
    [507] = true, -- Fenros > classic/tbc
    [5293] = true, -- Hulking Feral Scar > classic/tbc
    [3529] = true, -- Moonrage Armorer > classic/tbc
    [1779] = true, -- Moonrage Glutton > classic/tbc
    [533] = true, -- Nightbane Shadow Weaver > classic/tbc
    [898] = true, -- Nightbane Worgen > classic/tbc
    [3789] = true, -- Terrowulf Fleshripper > classic/tbc
    [3792] = true, -- Terrowulf Packlord > classic/tbc
    [1134] = true, -- Young Wendigo > classic/tbc
    [1137] = true, -- Edan the Howler > classic/tbc
    [5299] = true, -- Ferocious Rage Scar > classic/tbc
    [4504] = true, -- Frostmaw > classic/tbc
    [7460] = true, -- Ice Thistle Patriarch > classic/tbc
    [10197] = true, -- Mezzir the Howler > classic/tbc
    [1770] = true, -- Moonrage Darkrunner > classic/tbc
    [1893] = true, -- Moonrage Sentry > classic/tbc
    [1892] = true, -- Moonrage Watcher > classic/tbc
    [534] = true, -- Nefaru > classic/tbc
    [1895] = true, -- Pyrewood Elder > classic/tbc
    [1891] = true, -- Pyrewood Watcher > classic/tbc
    [3853] = true, -- Shadowfang Moonwalker > classic/tbc
    [2529] = true, -- Son of Arugal > classic/tbc
    [1756] = true, -- Stormwind Royal Guard > classic/tbc
    [1135] = true, -- Wendigo > classic/tbc
    [12461] = true, -- Death Talon Overseer > classic/tbc
    [2249] = true, -- Ferocious Yeti > classic/tbc
    [7848] = true, -- Lurking Feral Scar > classic/tbc
    [1924] = true, -- Moonrage Bloodhowler > classic/tbc
    [1896] = true, -- Moonrage Elder > classic/tbc
    [1769] = true, -- Moonrage Whitescalp > classic/tbc
    [205] = true, -- Nightbane Dark Runner > classic/tbc
    [1894] = true, -- Pyrewood Sentry > classic/tbc
    [5296] = true, -- Rage Scar Yeti > classic/tbc
    [3859] = true, -- Shadowfang Ragetooth > classic/tbc
    [3851] = true, -- Shadowfang Whitescalp > classic/tbc
    [23353] = true, -- Braxxus > classic/tbc
    [16181] = true, -- Rokad the Ravager > classic/tbc
    [19852] = true, -- Artifact Seeker > classic/tbc
    [20557] = true, -- Wrath Hound > classic/tbc
    [22180] = true, -- Shard-Hide Boar > classic/tbc
    [4678] = true, -- Mana Eater > classic/tbc
    [21195] = true, -- Domesticated Felboar > classic/tbc
    [16178] = true, -- Phase Hound > classic/tbc
    [19980] = true, -- Void Terror > classic/tbc
    [22394] = true, -- Deathshadow Hound > classic/tbc
    [16950] = true, -- Netherhound > classic/tbc
    [20866] = true, -- Soul Devourer > classic/tbc
    [11496] = true, -- Immol'thar > classic/tbc
    [16863] = true, -- Deranged Helboar > classic/tbc
    [16177] = true, -- Dreadbeast > classic/tbc
    [3774] = true, -- Felslayer > classic/tbc
    [5993] = true, -- Helboar > classic/tbc
    [16879] = true, -- Starving Helboar > classic/tbc
    [17401] = true, -- Felhound Manastalker > classic/tbc
    [7126] = true, -- Jaedenar Hunter > classic/tbc
    [8921] = true, -- Bloodhound > classic/tbc
    [18642] = true, -- Fel Guardhound > classic/tbc
    [8280] = true, -- Shleipnarr > classic/tbc
    [1547] = true, -- Decrepit Darkhound > classic/tbc
    [16880] = true, -- Hulking Helboar > classic/tbc
    [10356] = true, -- Bayne > classic/tbc
    [21878] = true, -- Felboar > classic/tbc
    [7125] = true, -- Jaedenar Hound > classic/tbc
    [16176] = true, -- Shadowbeast > classic/tbc
    [1548] = true, -- Cursed Darkhound > classic/tbc
    [8598] = true, -- Frenzied Plaguehound > classic/tbc
    [4681] = true, -- Mage Hunter > classic/tbc
    [8596] = true, -- Plaguehound Runt > classic/tbc
    [14502] = true, -- Xorothian Dreadsteed > classic/tbc
    [8922] = true, -- Bloodhound Mastiff > classic/tbc
    [6071] = true, -- Legion Hound > classic/tbc
    [819] = true, -- Servant of Ilgalar > classic/tbc
    [9042] = true, -- Verek > classic/tbc
    [8675] = true, -- Felbeast > classic/tbc
    [6010] = true, -- Felhound > classic/tbc
    [7462] = true, -- Hederine Manastalker > classic/tbc
    [4685] = true, -- Ley Hunter > classic/tbc
    [8718] = true, -- Manahound > classic/tbc
    [8597] = true, -- Plaguehound > classic/tbc
    [1549] = true, -- Ravenous Darkhound > classic/tbc
    [21801] = true, -- Vhel'kur > classic/tbc
    [17589] = true, -- Veridian Broodling > classic/tbc
    [17588] = true, -- Veridian Whelp > classic/tbc
    [7334] = true, -- Battle Boar Horror > classic/tbc
    [17592] = true, -- Razormaw > classic/tbc
    [7333] = true, -- Withered Battle Boar > classic/tbc
    [15689] = true, -- Netherspite > classic/tbc
    [17881] = true, -- Aeonus > classic/tbc
    [18096] = true, -- Epoch Hunter > classic/tbc
    [7040] = true, -- Black Dragonspawn > classic/tbc
    [21387] = true, -- Wyrmcult Blackwhelp > classic/tbc
    [17880] = true, -- Temporus > classic/tbc
    [21004] = true, -- Lesser Nether Drake > classic/tbc
    [23281] = true, -- Insidion > classic/tbc
    [18877] = true, -- Nether Drake > classic/tbc
    [2447] = true, -- Narillasanz > classic/tbc
    [7041] = true, -- Black Wyrmkin > classic/tbc
    [23261] = true, -- Furywing > classic/tbc
    [17879] = true, -- Chrono Lord Deja > classic/tbc
    [7846] = true, -- Teremus the Devourer > classic/tbc
    [23282] = true, -- Obsidia > classic/tbc
    [23061] = true, -- Rivendark > classic/tbc
    [7044] = true, -- Black Drake > classic/tbc
    [6131] = true, -- Draconic Mageweaver > classic/tbc
    [2725] = true, -- Scalding Whelp > classic/tbc
    [11583] = true, -- Nefarian > classic/tbc
    [20332] = true, -- Nether Dragon > classic/tbc
    [20021] = true, -- Nether Whelp > classic/tbc
    [10363] = true, -- General Drakkisath > classic/tbc
    [17307] = true, -- Vazruden the Herald > classic/tbc
    [5709] = true, -- Shade of Eranikus > classic/tbc
    [14020] = true, -- Chromaggus > classic/tbc
    [21032] = true, -- Dreadwing > classic/tbc
    [741] = true, -- Dreaming Whelp > classic/tbc
    [4328] = true, -- Firemane Scalebane > classic/tbc
    [2726] = true, -- Scorched Guardian > classic/tbc
    [12497] = true, -- Dreamroarer > classic/tbc
    [6109] = true, -- Azuregos > classic/tbc
    [742] = true, -- Green Wyrmkin > classic/tbc
    [11981] = true, -- Flamegor > classic/tbc
    [10184] = true, -- Onyxia > classic/tbc
    [7042] = true, -- Flamescale Dragonspawn > classic/tbc
    [21389] = true, -- Maxnar the Ashmaw > classic/tbc
    [14888] = true, -- Lethon > classic/tbc
    [5912] = true, -- Deviate Faerie Dragon > classic/tbc
    [12460] = true, -- Death Talon Wyrmguard > classic/tbc
    [5280] = true, -- Nightmare Wyrmkin > classic/tbc
    [7436] = true, -- Cobalt Scalebane > classic/tbc
    [7043] = true, -- Flamescale Wyrmkin > classic/tbc
    [5722] = true, -- Hazzas > classic/tbc
    [441] = true, -- Black Dragon Whelp > classic/tbc
    [21697] = true, -- Infinite Chrono-Lord > classic/tbc
    [4066] = true, -- Nal'taszar > classic/tbc
    [21148] = true, -- Rift Keeper > classic/tbc
    [335] = true, -- Singe > classic/tbc
    [14272] = true, -- Snarlflare > classic/tbc
    [10442] = true, -- Chromatic Whelp > classic/tbc
    [1042] = true, -- Red Whelp > classic/tbc
    [10683] = true, -- Rookery Hatcher > classic/tbc
    [10662] = true, -- Spellmaw > classic/tbc
    [5719] = true, -- Morphaz > classic/tbc
    [5720] = true, -- Weaver > classic/tbc
    [3815] = true, -- Blink Dragon > classic/tbc
    [193] = true, -- Blue Dragonspawn > classic/tbc
    [6130] = true, -- Blue Scalebane > classic/tbc
    [21722] = true, -- Enslaved Netherwing Drake > classic/tbc
    [4329] = true, -- Firemane Scout > classic/tbc
    [7049] = true, -- Flamescale Broodling > classic/tbc
    [5320] = true, -- Jademir Boughguard > classic/tbc
    [5312] = true, -- Lethlas > classic/tbc
    [14445] = true, -- Lord Captain Wyrmak > classic/tbc
    [8319] = true, -- Nightmare Whelp > classic/tbc
    [1047] = true, -- Red Scalebane > classic/tbc
    [5718] = true, -- Rothos > classic/tbc
    [10661] = true, -- Spell Eater > classic/tbc
    [5278] = true, -- Sprite Darter > classic/tbc
    [14601] = true, -- Ebonroc > classic/tbc
    [9568] = true, -- Overlord Wyrmthalak > classic/tbc
    [740] = true, -- Adolescent Whelp > classic/tbc
    [10202] = true, -- Azurous > classic/tbc
    [7047] = true, -- Black Broodling > classic/tbc
    [10660] = true, -- Cobalt Broodling > classic/tbc
    [4016] = true, -- Fey Dragon > classic/tbc
    [4331] = true, -- Firemane Ash Tail > classic/tbc
    [10366] = true, -- Rage Talon Dragon Guard > classic/tbc
    [17839] = true, -- Rift Lord > classic/tbc
    [10664] = true, -- Scryer > classic/tbc
    [4324] = true, -- Searing Whelp > classic/tbc
    [10264] = true, -- Solakar Flamewreath > classic/tbc
    [5276] = true, -- Sprite Dragon > classic/tbc
    [11983] = true, -- Firemaw > classic/tbc
    [4339] = true, -- Brimgore > classic/tbc
    [10447] = true, -- Chromatic Dragonspawn > classic/tbc
    [12463] = true, -- Death Talon Flamescale > classic/tbc
    [10196] = true, -- General Colbatann > classic/tbc
    [8976] = true, -- Hematos > classic/tbc
    [18171] = true, -- Infinite Defiler > classic/tbc
    [8198] = true, -- Tick > classic/tbc
    [14887] = true, -- Ysondre > classic/tbc
    [10814] = true, -- Chromatic Elite Guard > classic/tbc
    [7437] = true, -- Cobalt Mageweaver > classic/tbc
    [6129] = true, -- Draconic Magelord > classic/tbc
    [746] = true, -- Elder Dragonkin > classic/tbc
    [10321] = true, -- Emberstrife > classic/tbc
    [9461] = true, -- Frenzied Black Drake > classic/tbc
    [10339] = true, -- Gyth > classic/tbc
    [5317] = true, -- Jademir Oracle > classic/tbc
    [1043] = true, -- Lost Whelp > classic/tbc
    [5283] = true, -- Nightmare Wanderer > classic/tbc
    [1046] = true, -- Red Wyrmkin > classic/tbc
    [745] = true, -- Scalebane Captain > classic/tbc
    [743] = true, -- Wyrmkin Dreamwalker > classic/tbc
    [5721] = true, -- Dreamscythe > classic/tbc
    [2757] = true, -- Blacklash > classic/tbc
    [7997] = true, -- Captured Sprite Darter > classic/tbc
    [10659] = true, -- Cobalt Whelp > classic/tbc
    [7435] = true, -- Cobalt Wyrmkin > classic/tbc
    [12464] = true, -- Death Talon Seether > classic/tbc
    [12474] = true, -- Emeraldon Boughguard > classic/tbc
    [12476] = true, -- Emeraldon Oracle > classic/tbc
    [14889] = true, -- Emeriss > classic/tbc
    [20713] = true, -- Fey Drake > classic/tbc
    [4334] = true, -- Firemane Flamecaller > classic/tbc
    [1063] = true, -- Jade > classic/tbc
    [5319] = true, -- Jademir Tree Warder > classic/tbc
    [10663] = true, -- Manaclaw > classic/tbc
    [5277] = true, -- Nightmare Scalebane > classic/tbc
    [8497] = true, -- Nightmare Suppressor > classic/tbc
    [8196] = true, -- Occulus > classic/tbc
    [12129] = true, -- Onyxian Warder > classic/tbc
    [10372] = true, -- Rage Talon Fire Tongue > classic/tbc
    [10083] = true, -- Rage Talon Flamescale > classic/tbc
    [21104] = true, -- Rift Keeper > classic/tbc
    [21140] = true, -- Rift Lord > classic/tbc
    [7048] = true, -- Scalding Broodling > classic/tbc
    [7046] = true, -- Searscale Drake > classic/tbc
    [14890] = true, -- Taerar > classic/tbc
    [12477] = true, -- Verdantine Boughguard > classic/tbc
    [1069] = true, -- Crimson Whelp > classic/tbc
    [12467] = true, -- Death Talon Captain > classic/tbc
    [12468] = true, -- Death Talon Hatcher > classic/tbc
    [12465] = true, -- Death Talon Wyrmkin > classic/tbc
    [12498] = true, -- Dreamstalker > classic/tbc
    [12496] = true, -- Dreamtracker > classic/tbc
    [14398] = true, -- Eldreth Darter > classic/tbc
    [12475] = true, -- Emeraldon Tree Warder > classic/tbc
    [21721] = true, -- Enslaved Netherwing Whelp > classic/tbc
    [1044] = true, -- Flamesnorting Whelp > classic/tbc
    [744] = true, -- Green Scalebane > classic/tbc
    [2759] = true, -- Hematus > classic/tbc
    [18172] = true, -- Infinite Saboteur > classic/tbc
    [18170] = true, -- Infinite Slayer > classic/tbc
    [5314] = true, -- Phantim > classic/tbc
    [10678] = true, -- Plagued Hatchling > classic/tbc
    [10371] = true, -- Rage Talon Captain > classic/tbc
    [9096] = true, -- Rage Talon Dragonspawn > classic/tbc
    [1045] = true, -- Red Dragonspawn > classic/tbc
    [10258] = true, -- Rookery Guardian > classic/tbc
    [7045] = true, -- Scalding Drake > classic/tbc
    [1048] = true, -- Scalebane Lieutenant > classic/tbc
    [1050] = true, -- Scalebane Royal Guard > classic/tbc
    [4323] = true, -- Searing Hatchling > classic/tbc
    [12478] = true, -- Verdantine Oracle > classic/tbc
    [12479] = true, -- Verdantine Tree Warder > classic/tbc
    [4017] = true, -- Wily Fey Dragon > classic/tbc
    [1049] = true, -- Wyrmkin Firebrand > classic/tbc
    [20520] = true, -- Ethereum Prisoner > classic/tbc
    [18678] = true, -- Fulgorge > classic/tbc
    [11731] = true, -- Hive'Regal Burrower > classic/tbc
    [3398] = true, -- Gesharahan > classic/tbc
    [4829] = true, -- Aku'mai > classic/tbc
    [8437] = true, -- Hakkari Minion > classic/tbc
    [7273] = true, -- Gahz'rilla > classic/tbc
    [11724] = true, -- Hive'Ashi Swarmer > classic/tbc
    [11721] = true, -- Hive'Ashi Worker > classic/tbc
    [8438] = true, -- Hakkari Bloodkeeper > classic/tbc
    [23285] = true, -- Nethermine Burster > classic/tbc
    [12940] = true, -- Vorsha the Lasher > classic/tbc
    [6140] = true, -- Hetaera > classic/tbc
    [11730] = true, -- Hive'Regal Ambusher > classic/tbc
    [11732] = true, -- Hive'Regal Spitfire > classic/tbc
    [11722] = true, -- Hive'Ashi Defender > classic/tbc
    [11723] = true, -- Hive'Ashi Sandstalker > classic/tbc
    [11698] = true, -- Hive'Ashi Stinger > classic/tbc
    [11734] = true, -- Hive'Regal Hive Lord > classic/tbc
    [11733] = true, -- Hive'Regal Slavemaker > classic/tbc
    [11729] = true, -- Hive'Zora Hive Sister > classic/tbc
    [11726] = true, -- Hive'Zora Tunneler > classic/tbc
    [4374] = true, -- Strashaz Hydra > classic/tbc
    [15286] = true, -- Xil'xix > classic/tbc
    [3652] = true, -- Trigore the Lasher > classic/tbc
    [13301] = true, -- Hive'Ashi Ambusher > classic/tbc
    [13136] = true, -- Hive'Ashi Drone > classic/tbc
    [11728] = true, -- Hive'Zora Reaver > classic/tbc
    [11727] = true, -- Hive'Zora Wasp > classic/tbc
    [11725] = true, -- Hive'Zora Waywatcher > classic/tbc
    [6033] = true, -- Lake Frenzy > classic/tbc
    [14475] = true, -- Rex Ashil > classic/tbc
    [8138] = true, -- Sul'lithuz Broodling > classic/tbc
    [12207] = true, -- Thessala Hydra > classic/tbc
    [14474] = true, -- Zora > classic/tbc
    [15288] = true, -- Aluntir > classic/tbc
    [15290] = true, -- Arakis > classic/tbc
    [15327] = true, -- Hive'Zara Stinger > classic/tbc
    [15325] = true, -- Hive'Zara Wasp > classic/tbc
    [14473] = true, -- Lapress > classic/tbc
    [3721] = true, -- Mystlash Hydra > classic/tbc
    [8120] = true, -- Sul'lithuz Abomination > classic/tbc
    [14339] = true, -- Death Howl > wotlk
    [28847] = true, -- Siltslither Eel > wotlk
    [23690] = true, -- Shoveltusk > wotlk
    [29334] = true, -- Gundrak Raptor > wotlk
    [28009] = true, -- Shardhorn Rhino > wotlk
    [29452] = true, -- Vargul Blighthound > wotlk
    [25968] = true, -- "Lunchbox" > wotlk
    [25454] = true, -- Tundra Crawler > wotlk
    [34797] = true, -- Icehowl > wotlk
    [30445] = true, -- Ice Steppe Bull > wotlk
    [30148] = true, -- Infesting Jormungar > wotlk
    [25488] = true, -- Wooly Rhino Calf > wotlk
    [28379] = true, -- Shattertusk Mammoth > wotlk
    [27578] = true, -- Goremaw > wotlk
    [29958] = true, -- Tundra Ram > wotlk
    [29411] = true, -- Crystalweb Weaver > wotlk
    [24277] = true, -- Garwal > wotlk
    [28921] = true, -- Hadronox > wotlk
    [26586] = true, -- Hungry Worg > wotlk
    [30422] = true, -- Roaming Jormungar > wotlk
    [28097] = true, -- Pitch > wotlk
    [26271] = true, -- Emaciated Mammoth Bull > wotlk
    [29469] = true, -- Ice Steppe Rhino > wotlk
    [26293] = true, -- Hulking Jormungar > wotlk
    [26644] = true, -- Ursus Mauler > wotlk
    [25487] = true, -- Wooly Rhino Matriarch > wotlk
    [29590] = true, -- Blighted Proto-Drake > wotlk
    [29402] = true, -- Ironwool Mammoth > wotlk
    [25489] = true, -- Wooly Rhino Bull > wotlk
    [25791] = true, -- Oil-stained Wolf > wotlk
    [24673] = true, -- Frostwing Chimaera > wotlk
    [28297] = true, -- Shango > wotlk
    [28001] = true, -- Dreadsaber > wotlk
    [27483] = true, -- King Dred > wotlk
    [30430] = true, -- Sentry Worg > wotlk
    [24785] = true, -- Big Roy > wotlk
    [28221] = true, -- Trapdoor Crawler > wotlk
    [24517] = true, -- Varg > wotlk
    [25743] = true, -- Wooly Mammoth Bull > wotlk
    [28851] = true, -- Enraged Mammoth > wotlk
    [29390] = true, -- Snowdrift Jormungar > wotlk
    [30164] = true, -- Cavedweller Worg > wotlk
    [30291] = true, -- Ravenous Jormungar > wotlk
    [28477] = true, -- Scion of Quetz'lun > wotlk
    [28002] = true, -- Mangal Crocolisk > wotlk
    [25482] = true, -- Sand Turtle > wotlk
    [30260] = true, -- Stoic Mammoth > wotlk
    [28098] = true, -- Hardknuckle Forager > wotlk
    [26358] = true, -- Ice Heart Jormungar Feeder > wotlk
    [26359] = true, -- Ice Heart Jormungar Spawn > wotlk
    [30447] = true, -- Romping Rhino > wotlk
    [29479] = true, -- Shoveltusk Forager > wotlk
    [25675] = true, -- Tundra Wolf > wotlk
    [24614] = true, -- Wooly Mammoth > wotlk
    [23740] = true, -- Frosthorn Ram > wotlk
    [26418] = true, -- Longhoof Grazer > wotlk
    [29312] = true, -- Lavanthor > wotlk
    [24516] = true, -- Bjomolf > wotlk
    [26592] = true, -- Graymist Hunter > wotlk
    [24637] = true, -- Great Reef Shark > wotlk
    [28096] = true, -- Hardknuckle Charger > wotlk
    [29562] = true, -- Icemaw Bear > wotlk
    [26521] = true, -- Kili'ua > wotlk
    [26672] = true, -- Bloodthirsty Tundra Wolf > wotlk
    [29931] = true, -- Drakkari Rhino > wotlk
    [24547] = true, -- Hozzer > wotlk
    [26467] = true, -- Jormungar Tunneler > wotlk
    [28145] = true, -- Lurking Basilisk > wotlk
    [26360] = true, -- Rattlebore > wotlk
    [29412] = true, -- Crystalweb Spitter > wotlk
    [28213] = true, -- Hardknuckle Matriarch > wotlk
    [29392] = true, -- Ravenous Jaws > wotlk
    [30206] = true, -- Carrion Fleshstripper > wotlk
    [29327] = true, -- Frost Leopard > wotlk
    [28325] = true, -- Ravenous Mangal Crocolisk > wotlk
    [26482] = true, -- Arctic Grizzly > wotlk
    [26446] = true, -- Ice Serpent > wotlk
    [29605] = true, -- Ravenous Jormungar > wotlk
    [24922] = true, -- Razorthorn Ravager > wotlk
    [23691] = true, -- Shoveltusk Stag > wotlk
    [29319] = true, -- Icepaw Bear > wotlk
    [24128] = true, -- Wild Worg > wotlk
    [24076] = true, -- Winterskorn Worg > wotlk
    [28399] = true, -- Zeptek the Destroyer > wotlk
    [29461] = true, -- Icetip Crawler > wotlk
    [26706] = true, -- Infected Grizzly Bear > wotlk
    [28380] = true, -- Shattertusk Bull > wotlk
    [27230] = true, -- Silvercoat Stag > wotlk
    [28003] = true, -- Bittertide Hydra > wotlk
    [24026] = true, -- Fanggore Worg > wotlk
    [28288] = true, -- Farunn > wotlk
    [27645] = true, -- Phantasmal Cloudscraper > wotlk
    [29774] = true, -- Spitting Cobra > wotlk
    [28233] = true, -- Zul'Drak Bat > wotlk
    [26272] = true, -- Emaciated Mammoth > wotlk
    [29710] = true, -- Onslaught Destrier > wotlk
    [24786] = true, -- Reef Bull > wotlk
    [31265] = true, -- Savage Proto-Drake > wotlk
    [29768] = true, -- Unyielding Constrictor > wotlk
    [26613] = true, -- Arctic Grizzly Cub > wotlk
    [24475] = true, -- Bloodthirsty Worg > wotlk
    [29664] = true, -- Ragemane > wotlk
    [28358] = true, -- Venomtip > wotlk
    [29838] = true, -- Drakkari Rhino > wotlk
    [28011] = true, -- Emperor Cobra > wotlk
    [26806] = true, -- Guardian Serpent > wotlk
    [24206] = true, -- Prowling Worg > wotlk
    [29693] = true, -- Serpent Defender > wotlk
    [24899] = true, -- "Scoodles" > wotlk
    [28404] = true, -- Cursed Offspring of Har'koa > wotlk
    [26273] = true, -- Emaciated Mammoth Calf > wotlk
    [27131] = true, -- Grizzly Bear > wotlk
    [26472] = true, -- Highland Mustang > wotlk
    [25481] = true, -- Landing Crawler > wotlk
    [30448] = true, -- Plains Mammoth > wotlk
    [31233] = true, -- Sinewy Wolf > wotlk
    [24530] = true, -- Amani Elder Lynx > wotlk
    [23959] = true, -- Darkclaw Bat > wotlk
    [26622] = true, -- Drakkari Bat > wotlk
    [29698] = true, -- Drakuru Raptor > wotlk
    [30167] = true, -- Gimorak > wotlk
    [25203] = true, -- Glrggl > wotlk
    [29735] = true, -- Savage Worg > wotlk
    [23772] = true, -- Spotted Hippogryph > wotlk
    [34137] = true, -- Winter Jormungar > wotlk
    [26616] = true, -- Blighted Elk > wotlk
    [26363] = true, -- Tallhorn Stag > wotlk
    [27294] = true, -- Tundra Scavenger > wotlk
    [23994] = true, -- Dragonflayer Hunting Hound > wotlk
    [24613] = true, -- Mammoth Calf > wotlk
    [25750] = true, -- Oil-soaked Caribou > wotlk
    [27642] = true, -- Phantasmal Mammoth > wotlk
    [24047] = true, -- Amani Crocolisk > wotlk
    [26628] = true, -- Drakkari Scytheclaw > wotlk
    [24681] = true, -- Island Shoveltusk > wotlk
    [28129] = true, -- Longneck Grazer > wotlk
    [24791] = true, -- Shoveltusk Calf > wotlk
    [23584] = true, -- Amani Bear > wotlk
    [24478] = true, -- Fjord Crawler > wotlk
    [25204] = true, -- Glimmer Bay Orca > wotlk
    [36891] = true, -- Iceborn Proto-Drake > wotlk
    [23887] = true, -- Lion Seal > wotlk
    [25680] = true, -- Marsh Caribou > wotlk
    [28381] = true, -- Shattertusk Calf > wotlk
    [26633] = true, -- Ursoc > wotlk
    [23886] = true, -- Bull Lion Seal > wotlk
    [23785] = true, -- Daggercap Hammerhead > wotlk
    [29559] = true, -- Lion Seal Whelp > wotlk
    [31236] = true, -- Dappled Stag > wotlk
    [27408] = true, -- Duskhowl Prowler > wotlk
    [24901] = true, -- Maddened Frosthorn > wotlk
    [24633] = true, -- Rabid Brown Bear > wotlk
    [26643] = true, -- Rabid Grizzly > wotlk
    [26615] = true, -- Snowfall Elk > wotlk
    [28010] = true, -- Stranded Thresher > wotlk
    [26522] = true, -- Subterranean Thresher > wotlk
    [26641] = true, -- Drakkari Gutripper > wotlk
    [24863] = true, -- Frosthorn Kid > wotlk
    [26511] = true, -- Moa'ki Bottom Thresher > wotlk
    [5936] = true, -- Orca > wotlk
    [24677] = true, -- Spearfang Worg > wotlk
    [23834] = true, -- Amani Dragonhawk > wotlk
    [26824] = true, -- Drakkari Raptor Mount > wotlk
    [27329] = true, -- Onslaught Bloodhound > wotlk
    [27644] = true, -- Phantasmal Wolf > wotlk
    [27617] = true, -- River Thresher > wotlk
    [29875] = true, -- Icemane Yeti > wotlk
    [27020] = true, -- Bloodmoon Worgen > wotlk
    [24173] = true, -- Frostgore > wotlk
    [23744] = true, -- Icehollow Behemoth > wotlk
    [3532] = true, -- Pyrewood Leatherworker > wotlk
    [31404] = true, -- Azure Manabeast > wotlk
    [26281] = true, -- Moonrest Stalker > wotlk
    [25355] = true, -- Beryl Hound > wotlk
    [26730] = true, -- Mage Slayer > wotlk
    [25599] = true, -- Cataclysm Hound > wotlk
    [25718] = true, -- Coldarra Mage Slayer > wotlk
    [34564] = true, -- Anub'arak > wotlk
    [29120] = true, -- Anub'arak > wotlk
    [24566] = true, -- Nerub'ar Skitterer > wotlk
    [30204] = true, -- Forgotten Depths Ambusher > wotlk
    [29128] = true, -- Anub'ar Prime Guard > wotlk
    [26402] = true, -- Anub'ar Ambusher > wotlk
    [30541] = true, -- Forgotten Depths Underking > wotlk
    [26606] = true, -- Anub'ar Slayer > wotlk
    [30952] = true, -- Hungering Plaguehound > wotlk
    [28684] = true, -- Krik'thir the Gatewatcher > wotlk
    [31037] = true, -- Forgotten Depths High Priest > wotlk
    [37217] = true, -- Precious > wotlk
    [30831] = true, -- High Priest Yath'amon > wotlk
    [30205] = true, -- Forgotten Depths Acolyte > wotlk
    [25452] = true, -- Scourged Mammoth > wotlk
    [28258] = true, -- Hath'ar Skimmer > wotlk
    [30333] = true, -- Forgotten Depths Slayer > wotlk
    [25294] = true, -- Nerub'ar Web Lord > wotlk
    [37025] = true, -- Stinky > wotlk
    [30278] = true, -- Ahn'kahar Spell Flinger > wotlk
    [31039] = true, -- Forgotten Depths Underking > wotlk
    [30543] = true, -- Forgotten Depths High Priest > wotlk
    [26413] = true, -- Anub'ar Dreadweaver > wotlk
    [30276] = true, -- Ahn'kahar Web Winder > wotlk
    [29335] = true, -- Anub'ar Webspinner > wotlk
    [28199] = true, -- Tomb Stalker > wotlk
    [36725] = true, -- Nerub'ar Broodkeeper > wotlk
    [30277] = true, -- Ahn'kahar Slasher > wotlk
    [25622] = true, -- Nerub'ar Tunneler > wotlk
    [25619] = true, -- Nerub'ar Warrior > wotlk
    [25582] = true, -- Scourged Flamespitter > wotlk
    [32280] = true, -- Corp'rethar Guardian > wotlk
    [24563] = true, -- Nerub'ar Venomspitter > wotlk
    [37502] = true, -- Nerub'ar Webweaver > wotlk
    [25600] = true, -- Unliving Swine > wotlk
    [28732] = true, -- Anub'ar Warrior > wotlk
    [25445] = true, -- Nerub'ar Corpse Harvester > wotlk
    [27734] = true, -- Crypt Fiend > wotlk
    [28734] = true, -- Anub'ar Skirmisher > wotlk
    [26605] = true, -- Anub'ar Underlord > wotlk
    [24562] = true, -- Nerub'ar Invader > wotlk
    [37501] = true, -- Nerub'ar Champion > wotlk
    [28860] = true, -- Sartharion > wotlk
    [32273] = true, -- Infinite Corruptor > wotlk
    [28378] = true, -- Primordial Drake > wotlk
    [26723] = true, -- Keristrasza > wotlk
    [29753] = true, -- Stormpeak Wyrm > wotlk
    [26349] = true, -- Goramosh > wotlk
    [31134] = true, -- Cyanigosa > wotlk
    [28467] = true, -- Broodmother Slivina > wotlk
    [31403] = true, -- Azure Spellweaver > wotlk
    [23680] = true, -- Plagued Proto-Dragon > wotlk
    [26532] = true, -- Chrono-Lord Epoch > wotlk
    [25448] = true, -- Curator Insivius > wotlk
    [30451] = true, -- Shadron > wotlk
    [27636] = true, -- Azure Ley-Whelp > wotlk
    [32191] = true, -- Azure Stalker > wotlk
    [25728] = true, -- Coldarra Wyrmkin > wotlk
    [25712] = true, -- Warbringer Goredrak > wotlk
    [30668] = true, -- Azure Raider > wotlk
    [30680] = true, -- Onyx Brood General > wotlk
    [25585] = true, -- Beryl Mage Hunter > wotlk
    [27744] = true, -- Infinite Agent > wotlk
    [24160] = true, -- Plagued Proto-Whelp > wotlk
    [30695] = true, -- Portal Keeper > wotlk
    [30449] = true, -- Vesperon > wotlk
    [23689] = true, -- Proto-Drake > wotlk
    [27633] = true, -- Azure Inquisitor > wotlk
    [26716] = true, -- Azure Warder > wotlk
    [25713] = true, -- Blue Drakonid Supplicant > wotlk
    [30682] = true, -- Onyx Flight Captain > wotlk
    [25721] = true, -- Arcane Serpent > wotlk
    [26322] = true, -- Arcane Wyrm > wotlk
    [31402] = true, -- Azure Scalebane > wotlk
    [32572] = true, -- Dragonblight Mage Hunter > wotlk
    [24083] = true, -- Enslaved Proto-Drake > wotlk
    [30453] = true, -- Onyx Sanctum Guardian > wotlk
    [30660] = true, -- Portal Guardian > wotlk
    [30666] = true, -- Azure Captain > wotlk
    [25722] = true, -- Coldarra Spellweaver > wotlk
    [25716] = true, -- General Cerulean > wotlk
    [27742] = true, -- Infinite Adversary > wotlk
    [27743] = true, -- Infinite Hunter > wotlk
    [26734] = true, -- Azure Enforcer > wotlk
    [30667] = true, -- Azure Sorcerer > wotlk
    [27635] = true, -- Azure Spellbinder > wotlk
    [22072] = true, -- Shadowsworn Drakonid > wotlk
    [23688] = true, -- Proto-Whelp > wotlk
    [33528] = true, -- Guardian of Life > wotlk
    [30681] = true, -- Onyx Blaze Mistress > wotlk
    [26722] = true, -- Azure Magus > wotlk
    [26735] = true, -- Azure Scale-Binder > wotlk
    [25717] = true, -- Coldarra Scalesworn > wotlk
    [30892] = true, -- Portal Guardian > wotlk
    [30893] = true, -- Portal Keeper > wotlk
    [23750] = true, -- Proto-Whelp Hatchling > wotlk
    [37206] = true, -- Plains Prowler > cata
    [37559] = true, -- Savannah Boar > cata
    [11741] = true, -- Dredge Crusher > cata
    [43050] = true, -- Vale Howler > cata
    [44473] = true, -- Shaggy Black Bear > cata
    [5247] = true, -- Zukk'ash Tunneler > cata
    [35096] = true, -- Weakened Mosshoof Stag > cata
    [45380] = true, -- Ashtail > cata
    [6584] = true, -- King Mosh > cata
    [11740] = true, -- Dredge Striker > cata
    [32997] = true, -- Fleetfoot > cata
    [37207] = true, -- Plains Pridemane > cata
    [44482] = true, -- Hulking Plaguebear > cata
    [49347] = true, -- Coldlurk Burrower > cata
    [43417] = true, -- Skymane Bonobo > cata
    [51662] = true, -- Mahamba > cata
    [42336] = true, -- Tainted Black Bear > cata
    [5450] = true, -- Hazzali Stinger > cata
    [41166] = true, -- Gomegaz > cata
    [37091] = true, -- Deviate Plainstrider > cata
    [51663] = true, -- Pogeyan > cata
    [37082] = true, -- Dusthoof Giraffe > cata
    [43084] = true, -- Forest Stalker > cata
    [47687] = true, -- Winna's Kitten > cata
    [45950] = true, -- Sorrowmurk Snapjaw > cata
    [14344] = true, -- Mongress > cata
    [48765] = true, -- Rimepelt > cata
    [46575] = true, -- Darktusk Boar > cata
    [36304] = true, -- Mistwing Cliffdweller > cata
    [48456] = true, -- Rabid Screecher > cata
    [44089] = true, -- Blackbelly Forager > cata
    [48192] = true, -- Barbed Gasgill > cata
    [44113] = true, -- Ironjaw Behemoth > cata
    [41400] = true, -- Highland Razormaw > cata
    [44635] = true, -- Hill Fox > cata
    [48132] = true, -- Needlespine Shimmerback > cata
    [47390] = true, -- Silithid Defender > cata
    [46146] = true, -- Stagalbog Serpent > cata
    [42859] = true, -- Wild Mature Swine > cata
    [5823] = true, -- Death Flayer > cata
    [39049] = true, -- Plagued Bruin > cata
    [51661] = true, -- Tsul'Kalu > cata
    [48188] = true, -- Siltwash Terrapin > cata
    [38187] = true, -- Spiny Raptor > cata
    [36512] = true, -- Fox > cata
    [50320] = true, -- Lost Ravager > cata
    [40193] = true, -- Sharphorn Stag > cata
    [38346] = true, -- Devilsaur Queen > cata
    [35412] = true, -- Rejuvenated Thunder Lizard > cata
    [48128] = true, -- Stranded Sparkleshell > cata
    [44165] = true, -- Sunscale Consort > cata
    [45825] = true, -- Swampstrider > cata
    [37083] = true, -- Terrortooth Runner > cata
    [45450] = true, -- The Lone Hunter > cata
    [37557] = true, -- Thunderhawk Cloudscraper > cata
    [44474] = true, -- Whitetail Fox > cata
    [6551] = true, -- Gorishi Wasp > cata
    [37555] = true, -- Landquaker Kodo > cata
    [44595] = true, -- Sand Slitherer > cata
    [48249] = true, -- Sorrow Screecher > cata
    [42338] = true, -- Tainted Screecher > cata
    [34318] = true, -- Whitetail Stag > cata
    [49161] = true, -- Altered Beast > cata
    [40657] = true, -- Basking Cobra > cata
    [45453] = true, -- Blighthound > cata
    [5458] = true, -- Centipaar Worker > cata
    [44573] = true, -- Dune Worm > cata
    [11897] = true, -- Duskwing > cata
    [5454] = true, -- Hazzali Sandreaver > cata
    [33710] = true, -- Lake Snapper > cata
    [36681] = true, -- Ravenous Lurker > cata
    [37208] = true, -- Thunderhead > cata
    [33009] = true, -- Corrupted Thistle Bear > cata
    [41293] = true, -- Harbor Shredfin > cata
    [48178] = true, -- Silithid Ravager > cata
    [5245] = true, -- Zukk'ash Wasp > cata
    [37492] = true, -- Blackwald Fox > cata
    [5455] = true, -- Centipaar Wasp > cata
    [40581] = true, -- Gargantapid > cata
    [15319] = true, -- Hive'Zara Collector > cata
    [49235] = true, -- Icewhomp > cata
    [34829] = true, -- King Reaperclaw > cata
    [41342] = true, -- Mottled Screecher > cata
    [45807] = true, -- Sawtooth Crocolisk > cata
    [33311] = true, -- Darkshore Stag > cata
    [6554] = true, -- Gorishi Stinger > cata
    [45896] = true, -- Marsh Crocolisk > cata
    [35409] = true, -- Revitalized Basilisk > cata
    [44594] = true, -- Sunburst Adder > cata
    [5246] = true, -- Zukk'ash Worker > cata
    [50313] = true, -- Displaced Warp Stalker > cata
    [44599] = true, -- Duneclaw Broodlord > cata
    [40656] = true, -- Duneclaw Matriarch > cata
    [26111] = true, -- Grimtotem Spirit Wolf > cata
    [5452] = true, -- Hazzali Worker > cata
    [14476] = true, -- Krellack > cata
    [39385] = true, -- Screamslash > cata
    [44188] = true, -- Bobcat > cata
    [34302] = true, -- Consumed Thistle Bear > cata
    [41064] = true, -- Cragjaw > cata
    [37088] = true, -- Elder Zhevra > cata
    [47485] = true, -- Highperch Wind Rider > cata
    [33127] = true, -- Moonstalker > cata
    [43083] = true, -- Redridge Fox > cata
    [42170] = true, -- Snow Leopard > cata
    [44167] = true, -- Sunscale Raptor > cata
    [41419] = true, -- Wetlands Crocolisk > cata
    [5347] = true, -- Antilus the Soarer > cata
    [39452] = true, -- Dreadmaw Toothgnasher > cata
    [6553] = true, -- Gorishi Reaver > cata
    [48131] = true, -- Needlespine Cobra > cata
    [44551] = true, -- Rabid Fox > cata
    [48130] = true, -- Scorpid Cliffcrawler > cata
    [42171] = true, -- Snow Leopard Cub > cata
    [43536] = true, -- Southsea Mako > cata
    [36147] = true, -- Static-Charged Hippogryph > cata
    [46748] = true, -- Stonard Kodo Beast > cata
    [34894] = true, -- Stonetalon Ram > cata
    [37078] = true, -- Swamp Crocolisk > cata
    [48180] = true, -- Wild Horse > cata
    [34417] = true, -- Young Grizzled Thistle Bear > cata
    [37786] = true, -- Brown Stag > cata
    [44476] = true, -- Bullmastiff > cata
    [44016] = true, -- Coalpelt Bear > cata
    [43704] = true, -- Dire Wolf > cata
    [15318] = true, -- Hive'Zara Drone > cata
    [33978] = true, -- Hungry Thistle Bear > cata
    [42504] = true, -- Mature Swine > cata
    [41478] = true, -- Snow Tracker Wolf > cata
    [33903] = true, -- Thistle Bear Cub > cata
    [49249] = true, -- Vicious Black Bear > cata
    [48918] = true, -- Winterhorn Stag > cata
    [38845] = true, -- Child of Volcanoth > cata
    [37090] = true, -- Deviate Terrortooth > cata
    [48455] = true, -- Felrot Courser > cata
    [6552] = true, -- Gorishi Worker > cata
    [5451] = true, -- Hazzali Swarmer > cata
    [48177] = true, -- Silithid Ravager > cata
    [37084] = true, -- Terrortooth Scytheclaw > cata
    [5459] = true, -- Centipaar Tunneler > cata
    [44546] = true, -- Duneclaw Burrower > cata
    [44587] = true, -- Duneclaw Stalker > cata
    [6555] = true, -- Gorishi Tunneler > cata
    [44627] = true, -- Mudbelly Boar > cata
    [43106] = true, -- Redridge Fox Kit > cata
    [36541] = true, -- Subject Four > cata
    [36882] = true, -- Swamp Crocolisk > cata
    [5460] = true, -- Centipaar Sandreaver > cata
    [41137] = true, -- Displaced Threshadon > cata
    [44568] = true, -- Dune Rattler > cata
    [41401] = true, -- Highland Scytheclaw > cata
    [42357] = true, -- Hulking Goretusk > cata
    [40064] = true, -- Jungle Panther > cata
    [45664] = true, -- Landlocked Grouper > cata
    [37556] = true, -- Landquaker Bull > cata
    [47388] = true, -- Silithid Ravager > cata
    [39337] = true, -- Wayward Plainstrider > cata
    [33905] = true, -- Corrupted Thistle Bear Matriarch > cata
    [40717] = true, -- Duneclaw Lasher > cata
    [35245] = true, -- Greystone Basilisk > cata
    [37086] = true, -- Hecklefang Scavenger > cata
    [44638] = true, -- Hill Grizzly > cata
    [48184] = true, -- Hill Stag > cata
    [47204] = true, -- Infested Bear > cata
    [37718] = true, -- Mountain Mastiff > cata
    [35434] = true, -- Recovering Kodo > cata
    [44164] = true, -- Sunscale Ravager > cata
    [37085] = true, -- Towering Plainstrider > cata
    [5244] = true, -- Zukk'ash Stinger > cata
    [44166] = true, -- Grazing Zhevra > cata
    [41343] = true, -- Mottled Raptor > cata
    [48191] = true, -- Remora Scrounger > cata
    [35189] = true, -- Skoll > cata
    [32485] = true, -- King Krush > cata
    [47676] = true, -- Baradin Fox > cata
    [51714] = true, -- King Crawler > cata
    [39700] = true, -- Beauty > cata
    [51713] = true, -- Longstrider Gazelle > cata
    [47115] = true, -- Black Recluse > cata
    [43181] = true, -- Shalehide Basilisk > cata
    [39948] = true, -- Brinescale Serpent > cata
    [40223] = true, -- Speckled Sea Turtle > cata
    [39964] = true, -- Akasha > cata
    [40403] = true, -- Spinescale Matriarch > cata
    [41614] = true, -- Nemesis > cata
    [40819] = true, -- Pacified Hyjal Bear > cata
    [39588] = true, -- Hyjal Stag > cata
    [40276] = true, -- Sabreclaw Skitterer > cata
    [46508] = true, -- Darkwood Lurker > cata
    [47726] = true, -- Tiger > cata
    [42108] = true, -- Seabrush Terrapin > cata
    [51193] = true, -- Wild Camel > cata
    [46910] = true, -- Core Hound > cata
    [52224] = true, -- Jungle Serpent > cata
    [40802] = true, -- Softshell Sea Turtle > cata
    [46162] = true, -- Tawny Owl > cata
    [46871] = true, -- Scalemother Hevna > cata
    [40798] = true, -- Spineshell Pincer > cata
    [46608] = true, -- Tank > cata
    [49582] = true, -- Frenzied Thresher > cata
    [46153] = true, -- Highland Worg > cata
    [45202] = true, -- Mangy Hyena > cata
    [46317] = true, -- Neferset Crocolisk > cata
    [40340] = true, -- Nemesis > cata
    [47544] = true, -- Svarnos > cata
    [47591] = true, -- Baradin Crocolisk > cata
    [52795] = true, -- Brimstone Hound > cata
    [17144] = true, -- Goretooth > cata
    [41520] = true, -- Deepseeker Crab > cata
    [46580] = true, -- Elementium Spinner > cata
    [43981] = true, -- Jadecrest Basilisk > cata
    [51671] = true, -- Rabid Hyena > cata
    [46158] = true, -- Untamed Gryphon > cata
    [48724] = true, -- Spinescale Basilisk > cata
    [40466] = true, -- Blackfin > cata
    [45353] = true, -- Bloodsnarl Hyena > cata
    [52648] = true, -- Cinderweb Creeper > cata
    [41923] = true, -- Luxscale Grouper > cata
    [51675] = true, -- Oasis Crocolisk > cata
    [41922] = true, -- Pyreshell Scuttler > cata
    [42341] = true, -- Barbfin Skimmer > cata
    [47720] = true, -- Camel > cata
    [39913] = true, -- Frenzied Orca > cata
    [41326] = true, -- Slickback Remora > cata
    [53128] = true, -- Giant Fire Scorpion > cata
    [39796] = true, -- Anemone Frenzy > cata
    [40855] = true, -- Slitherfin Eel > cata
    [39418] = true, -- Green Sand Crab > cata
    [15320] = true, -- Hive'Zara Soldier > cata
    [46570] = true, -- Putrid Worg > cata
    [52085] = true, -- Razzashi Adder > cata
    [45204] = true, -- Skarf > cata
    [40685] = true, -- Splitclaw Skitterer > cata
    [45096] = true, -- Tamed Tol'vir Prowler > cata
    [40013] = true, -- Buster > cata
    [41646] = true, -- Crushing Eel > cata
    [41647] = true, -- Deep Remora > cata
    [44211] = true, -- Giant Driftray > cata
    [53545] = true, -- Molten Spewer > cata
    [40795] = true, -- Ravenous Oceanic Broadhead > cata
    [46868] = true, -- Stillwater Slitherer > cata
    [24138] = true, -- Tamed Amani Crocolisk > cata
    [32400] = true, -- Tukemuth > cata
    [46477] = true, -- Young Crocolisk > cata
    [15336] = true, -- Hive'Zara Tail Lasher > cata
    [52418] = true, -- Lost Offspring of Gahz'ranka > cata
    [40008] = true, -- Lucky > cata
    [51676] = true, -- Marsh Serpent > cata
    [53617] = true, -- Molten Erupter > cata
    [55453] = true, -- Shadowbat > cata
    [48239] = true, -- Armadillo > cata
    [41643] = true, -- Bloodcrazed Thresher > cata
    [52981] = true, -- Cinderweb Spinner > cata
    [29358] = true, -- Frostworg > cata
    [51726] = true, -- Greater Roc > cata
    [15323] = true, -- Hive'Zara Sandstalker > cata
    [52345] = true, -- Pride of Bethekk > cata
    [47283] = true, -- Sand Serpent > cata
    [42112] = true, -- Scourgut Remora > cata
    [46279] = true, -- Young Crocolisk > cata
    [53240] = true, -- Emberspit Scorpion > cata
    [46970] = true, -- Highland Elk > cata
    [40219] = true, -- Ravenous Thresher > cata
    [45321] = true, -- Riverbed Crocolisk > cata
    [44209] = true, -- Spotted Swellfish > cata
    [51673] = true, -- Venomscale Spitter > cata
    [47263] = true, -- Fleeing Stag > cata
    [47190] = true, -- Shaggy Desert Coyote > cata
    [41609] = true, -- Silversand Burrower > cata
    [40200] = true, -- Spiketooth Eel > cata
    [42113] = true, -- Spinescale Hammerhead > cata
    [53127] = true, -- Fire Scorpion > cata
    [43339] = true, -- Gorgonite > cata
    [24797] = true, -- Reef Cow > cata
    [47803] = true, -- Sand Scorpid > cata
    [41002] = true, -- Slickskin Eel > cata
    [52414] = true, -- Tor-Tun > cata
    [45859] = true, -- Venomblood Scorpid > cata
    [52413] = true, -- Zulian Gnasher > cata
    [41645] = true, -- Chasm Stalker > cata
    [42543] = true, -- Crystal Gorged Basilisk > cata
    [41997] = true, -- Famished Great Shark > cata
    [48479] = true, -- Glopgut Warhound > cata
    [40912] = true, -- Snapjaw Grouper > cata
    [40011] = true, -- Spot > cata
    [53134] = true, -- Ancient Core Hound > cata
    [26426] = true, -- Arctic Ram > cata
    [40889] = true, -- Sandskin Pincer > cata
    [39658] = true, -- Spinescale Basilisk > cata
    [46280] = true, -- Thartep > cata
    [53656] = true, -- Cinderweb Clutchkeeper > cata
    [46507] = true, -- Darkwood Broodmother > cata
    [40755] = true, -- Emissary of Flame > cata
    [47484] = true, -- Yetimus the Yeti Lord > cata
    [39896] = true, -- Feral Scar Yeti > cata
    [40336] = true, -- Charbringer > cata
    [46925] = true, -- Ashbearer > cata
    [42808] = true, -- Stonecore Flayer > cata
    [40224] = true, -- Rage Scar Yeti > cata
    [52311] = true, -- Venomguard Destroyer > cata
    [40974] = true, -- Desperiona > cata
    [48628] = true, -- Ferocious Yeti > cata
    [41163] = true, -- Illycor > cata
    [28257] = true, -- Hath'ar Necromagus > cata
    [39384] = true, -- Noxious Whelp > cata
    [43214] = true, -- Slabhide > cata
    [32630] = true, -- Vyragosa > cata
    [43873] = true, -- Altairus > cata
    [39625] = true, -- General Umbriss > cata
    [41376] = true, -- Nefarian > cata
    [42042] = true, -- Ebon Whelp > cata
    [46917] = true, -- Darkflight Flameblade > cata
    [46916] = true, -- Nyxondra's Broodling > cata
    [46141] = true, -- Obsidian Pyrewing > cata
    [41029] = true, -- Twilight Dragonkin > cata
    [46918] = true, -- Darkflight Shadowspeaker > cata
    [41031] = true, -- Twilight Juggernaut > cata
    [41226] = true, -- Sethria's Hatchling > cata
    [39863] = true, -- Halion > cata
    [42522] = true, -- Stone Drake > cata
    [46915] = true, -- Darkflight Soldier > cata
    [18692] = true, -- Hemathion > cata
    [41030] = true, -- Twilight Dragonkin Armorer > cata
    [45919] = true, -- Young Storm Dragon > cata
    [39405] = true, -- Crimsonborne Seer > cata
    [47796] = true, -- Obsidian Viletongue > cata
    [39395] = true, -- Jademir Echospawn > cata
    [46914] = true, -- Raging Whelp > cata
    [46068] = true, -- Corrupted Guardian > cata
    [30452] = true, -- Tenebron > cata
    [54552] = true, -- Time-Twisted Breaker > cata
    [40687] = true, -- Young Twilight Drake > cata
    [40290] = true, -- Crimsonborne Seer > cata
    [46938] = true, -- Moldarr > cata
    [47797] = true, -- Obsidian Charscale > cata
    [48291] = true, -- Tugnar Goremaw > cata
    [43967] = true, -- Twilight Scalesister > cata
    [42767] = true, -- Ivoroc > cata
    [46859] = true, -- Kalaran the Annihilator > cata
    [39394] = true, -- Lethlas > cata
    [34898] = true, -- Black Dragon Whelp > cata
    [42043] = true, -- Ebon Slavehunter > cata
    [39854] = true, -- Azureborne Guardian > cata
    [34897] = true, -- Black Drake > cata
    [39626] = true, -- Crimsonborne Warlord > cata
    [47391] = true, -- Highland Black Drake > cata
    [21648] = true, -- Mature Netherwing Drake > cata
    [39855] = true, -- Azureborne Seer > cata
    [39909] = true, -- Azureborne Warlord > cata
    [46860] = true, -- General Jirakka > cata
    [54923] = true, -- Infinite Warden > cata
    [48289] = true, -- Minyoth > cata
    [47835] = true, -- Scarderis > cata
    [54553] = true, -- Time-Twisted Seer > cata
    [40291] = true, -- Azureborne Seer > cata
    [46861] = true, -- Nyxondra > cata
    [43971] = true, -- Stonescale Drake > cata
    [47372] = true, -- Gloomwing > cata
    [36640] = true, -- Sable Drake > cata
    [36639] = true, -- Sable Drakonid > cata
    [54543] = true, -- Time-Twisted Drake > cata
    [39381] = true, -- Crimsonborne Guardian > cata
    [54920] = true, -- Infinite Suppressor > cata
    [43966] = true, -- Twilight Dragonspawn > cata
    [42768] = true, -- Maimgor > cata
    [42764] = true, -- Pyrecraw > cata
    [40309] = true, -- Glittergill Grouper > cata
    [1933] = true, -- Sheep > mop-classic
    [3528] = true, -- Pyrewood Armorer > mop-classic
    [40419] = true, -- Charscale Assaulter > mop-classic
}

local minable_npcs = {
    [20772] = true, -- Netherock > mop-classic
    [47226] = true, -- Obsidian Stoneslave > mop-classic
    [7031] = true, -- Obsidian Elemental > mop-classic
    [42188] = true, -- Ozruk > mop-classic
    [28069] = true, -- Sholazar Guardian > mop-classic
    [18343] = true, -- Tavarok > mop-classic
    [45084] = true, -- Elemental Overseer > mop-classic
    [30876] = true, -- Earthbound Revenant > mop-classic
    [2592] = true, -- Rumbling Exile > mop-classic
    [40229] = true, -- Scalding Rock Elemental > mop-classic
    [43438] = true, -- Corborus > mop-classic
    [26283] = true, -- Ice Revenant > mop-classic
    [29124] = true, -- Lifeblood Elemental > mop-classic
    [43026] = true, -- Deepstone Elemental > mop-classic
    [18881] = true, -- Sundered Rumbler > mop-classic
    [44218] = true, -- Emerald Colossus > mop-classic
    [48960] = true, -- Frostshard Rumbler > mop-classic
    [52107] = true, -- Obsidium Punisher > mop-classic
    [6560] = true, -- Stone Guardian > mop-classic
    [5853] = true, -- Tempered War Golem > mop-classic
    [28597] = true, -- Guardian of Zim'Rhuk > mop-classic
    [29844] = true, -- Icebound Revenant > mop-classic
    [11783] = true, -- Theradrim Shardling > mop-classic
    [19940] = true, -- Apex > mop-classic
    [30160] = true, -- Brittle Revenant > mop-classic
    [11746] = true, -- Desert Rumbler > mop-classic
    [26406] = true, -- The Anvil > mop-classic
    [20202] = true, -- Cragskaar > mop-classic
    [18182] = true, -- Gurok the Usurper > mop-classic
    [44220] = true, -- Jade Rager > mop-classic
    [38914] = true, -- Sandstone Golem > mop-classic
    [44076] = true, -- Defaced Earthrager > mop-classic
    [43254] = true, -- Energized Geode > mop-classic
    [21050] = true, -- Enraged Earth Spirit > mop-classic
    [19188] = true, -- Raging Colossus > mop-classic
    [27977] = true, -- Krystallus > mop-classic
    [33083] = true, -- Enraged Earth Elemental > mop-classic
    [33722] = true, -- Storm Tempered Keeper > mop-classic
    [43258] = true, -- Lodestone Elemental > mop-classic
    [28877] = true, -- Stormwatcher > mop-classic
    [7032] = true, -- Greater Obsidian Elemental > mop-classic
    [24271] = true, -- Iron Rune Golem > mop-classic
    [23165] = true, -- Karrog > mop-classic
    [53732] = true, -- Unbound Smoldering Elemental > mop-classic
    [26794] = true, -- Ormorok the Tree-Shaper > mop-classic
    [22275] = true, -- Apexis Guardian > mop-classic
    [26316] = true, -- Crystalline Ice Elemental > mop-classic
    [18062] = true, -- Enraged Crusher > mop-classic
    [34190] = true, -- Hardened Iron Golem > mop-classic
    [41993] = true, -- Raging Earth Elemental > mop-classic
    [55559] = true, -- Crystalline Elemental > mop-classic
    [21181] = true, -- Cyrukh the Firelord > mop-classic
    [52289] = true, -- Fiery Behemoth > mop-classic
    [50258] = true, -- Frostmaul Tumbler > mop-classic
    [42766] = true, -- Gorged Gyreworm > mop-classic
    [46911] = true, -- Lava Surger > mop-classic
    [52552] = true, -- Molten Behemoth > mop-classic
    [92] = true, -- Rock Elemental > mop-classic
    [19824] = true, -- Son of Corok > mop-classic
    [33699] = true, -- Storm Tempered Keeper > mop-classic
    [7039] = true, -- War Reaver > mop-classic
    [34135] = true, -- Winter Rumbler > mop-classic
    [34197] = true, -- Chamber Overseer > mop-classic
    [42810] = true, -- Crystalspawn Giant > mop-classic
    [48533] = true, -- Enormous Gyreworm > mop-classic
    [30040] = true, -- Eternal Watcher > mop-classic
    [28411] = true, -- Frozen Earth > mop-classic
    [5854] = true, -- Heavy War Golem > mop-classic
    [34086] = true, -- Magma Rager > mop-classic
    [41389] = true, -- Paleolithic Elemental > mop-classic
    [20498] = true, -- Sundered Shard > mop-classic
    [34134] = true, -- Winter Revenant > mop-classic
    [40972] = true, -- Corrupted Cliff Giant > mop-classic
    [18885] = true, -- Farahlon Giant > mop-classic
    [44259] = true, -- Gorged Gyreworm > mop-classic
    [44257] = true, -- Gyreworm > mop-classic
    [28840] = true, -- Overlook Sentry > mop-classic
    [34196] = true, -- Rune Etched Sentry > mop-classic
    [42781] = true, -- Servant of Therazane > mop-classic
    [23725] = true, -- Stone Giant > mop-classic
    [36845] = true, -- Agitated Earth Spirit > mop-classic
    [19823] = true, -- Crazed Colossus > mop-classic
    [18886] = true, -- Farahlon Breaker > mop-classic
    [34085] = true, -- Forge Construct > mop-classic
    [29436] = true, -- Icetouched Earthrager > mop-classic
    [42527] = true, -- Irestone Rumbler > mop-classic
    [24316] = true, -- Iron Rune Sentinel > mop-classic
    [5855] = true, -- Magma Elemental > mop-classic
    [34069] = true, -- Molten Colossus > mop-classic
    [22313] = true, -- Rumbling Earth-Heart > mop-classic
    [26417] = true, -- Runed Giant > mop-classic
    [26284] = true, -- Runic Battle Golem > mop-classic
    [26347] = true, -- Runic War Golem > mop-classic
    [17157] = true, -- Shattered Rumbler > mop-classic
    [18882] = true, -- Sundered Thunderer > mop-classic
    [17156] = true, -- Tortured Earth Spirit > mop-classic
    [26291] = true, -- Crystalline Ice Giant > mop-classic
    [37553] = true, -- Disturbed Earth Elemental > mop-classic
    [29832] = true, -- Drakkari Golem > mop-classic
    [39595] = true, -- Furious Earthguard > mop-classic
}

local gatherable_npcs = {
    [42475] = true, -- Fungal Behemoth > mop-classic
    [17770] = true, -- Hungarfen > mop-classic
    [19402] = true, -- Withered Bog Lord > mop-classic
    [18127] = true, -- Bog Lord > mop-classic
    [33420] = true, -- Strange Tentacle > mop-classic
    [26782] = true, -- Crystalline Keeper > mop-classic
    [17977] = true, -- Warp Splinter > mop-classic
    [31229] = true, -- Ancient Watcher > mop-classic
    [30258] = true, -- Amanitar > mop-classic
    [34300] = true, -- Mature Lasher > mop-classic
    [17871] = true, -- Underbog Shambler > mop-classic
    [25709] = true, -- Glacial Ancient > mop-classic
    [21251] = true, -- Underbog Colossus > mop-classic
    [7100] = true, -- Warpwood Moss Flayer > mop-classic
    [26333] = true, -- Corrupted Lothalor Ancient > mop-classic
    [32913] = true, -- Elder Ironbranch > mop-classic
    [41424] = true, -- Mouldering Mirebeast > mop-classic
    [30329] = true, -- Savage Cave Beast > mop-classic
    [19519] = true, -- Starving Bog Lord > mop-classic
    [22307] = true, -- Rotting Forest-Rager > mop-classic
    [33354] = true, -- Corrupted Servitor > mop-classic
    [32914] = true, -- Elder Stonebark > mop-classic
    [45125] = true, -- Felspore Bog Lord > mop-classic
    [23029] = true, -- Talonsworn Forest-Rager > mop-classic
    [32915] = true, -- Elder Brightleaf > mop-classic
    [37092] = true, -- Outgrowth > mop-classic
    [6527] = true, -- Tar Creeper > mop-classic
    [2029] = true, -- Timberling Mire Beast > mop-classic
    [45119] = true, -- Corrupted Darkwood Treant > mop-classic
    [28323] = true, -- Mossy Rampager > mop-classic
    [17725] = true, -- Underbog Lurker > mop-classic
    [21326] = true, -- Raven's Wood Leafbeard > mop-classic
    [6519] = true, -- Tar Lord > mop-classic
    [26792] = true, -- Crystalline Protector > mop-classic
    [22095] = true, -- Infested Root-Walker > mop-classic
    [29036] = true, -- Servant of Freya > mop-classic
    [18125] = true, -- Starving Fungal Giant > mop-classic
    [23874] = true, -- Thornvine Creeper > mop-classic
    [6510] = true, -- Bloodpetal Flayer > mop-classic
    [21694] = true, -- Bog Overlord > mop-classic
    [13141] = true, -- Deeprot Stomper > mop-classic
    [13142] = true, -- Deeprot Tangler > mop-classic
    [25707] = true, -- Magic-bound Ancient > mop-classic
    [17734] = true, -- Underbog Lord > mop-classic
    [18124] = true, -- Withered Giant > mop-classic
    [4382] = true, -- Withervine Creeper > mop-classic
    [12219] = true, -- Barbed Lasher > mop-classic
    [6509] = true, -- Bloodpetal Lasher > mop-classic
    [12220] = true, -- Constrictor Vine > mop-classic
    [48952] = true, -- Frostleaf Treant > mop-classic
    [7139] = true, -- Irontree Stomper > mop-classic
    [30845] = true, -- Living Lasher > mop-classic
    [33525] = true, -- Mangrove Ent > mop-classic
    [43732] = true, -- Corpseweed > mop-classic
    [27254] = true, -- Emerald Lasher > mop-classic
    [37093] = true, -- Lashvine > mop-classic
    [21040] = true, -- Outraged Raven's Wood Sapling > mop-classic
    [26417] = true, -- Runed Giant > mop-classic
    [21023] = true, -- Stronglimb Deeproot > mop-classic
    [44487] = true, -- Thrashing Pumpkin > mop-classic
    [2027] = true, -- Timberling Trampler > mop-classic
    [36062] = true, -- Uprooted Lasher > mop-classic
    [26421] = true, -- Woodlands Walker > mop-classic
    [17723] = true, -- Bog Giant > mop-classic
    [44489] = true, -- Corn Stalker > mop-classic
    [2030] = true, -- Elder Timberling > mop-classic
    [33431] = true, -- Forest Swarmer > mop-classic
    [33430] = true, -- Guardian Lasher > mop-classic
    [6518] = true, -- Tar Lurker > mop-classic
    [2022] = true, -- Timberling > mop-classic
    [30861] = true, -- Unbound Ancient > mop-classic
    [20774] = true, -- Farahlon Lasher > mop-classic
    [19734] = true, -- Fungal Giant > mop-classic
}

local difficultyColours = {
    grey = "ff808080",   -- Gray: Trivial difficulty
    green = "ff40bf40",  -- Green: Easy difficulty
    yellow = "ffffff00", -- Yellow: Medium difficulty
    orange = "ffff8040", -- Orange: Hard difficulty
    red = "ffff0000"     -- Red: Cannot gather/skin
}

local otherColours = {
    white = "ffffffcf"
}

local APPRENTICE_MAX = 75
local JOURNEYMAN_MAX = 150
local EXPERT_MAX = 225
local ARTISAN_MAX = 300
local MASTER_MAX = 375
local GRAND_MASTER_MAX = 450
local ILLUSTRIOUS_GRAND_MASTER_MAX = 525
local ZEN_MASTER_MAX = 600

local LEVELS = {
    APPRENTICE_MAX,
    JOURNEYMAN_MAX,
    EXPERT_MAX,
    ARTISAN_MAX,
    MASTER_MAX,
    GRAND_MASTER_MAX,
    ILLUSTRIOUS_GRAND_MASTER_MAX,
    ZEN_MASTER_MAX,
}

local GATHERING_LEVEL_THRESHOLDS = {
    { cap = APPRENTICE_MAX,   reqLevel =   1 },
    { cap = JOURNEYMAN_MAX,   reqLevel =   1 },
    { cap = EXPERT_MAX,       reqLevel =  10 },
    { cap = ARTISAN_MAX,      reqLevel =  25 },
    { cap = MASTER_MAX,       reqLevel =  58 },
    { cap = GRAND_MASTER_MAX, reqLevel =  70 },
    { cap = ILLUSTRIOUS_GRAND_MASTER_MAX, reqLevel =  80 },
    { cap = ZEN_MASTER_MAX,   reqLevel =  85 },
}

local FISHING_THRESHOLDS = {
    { cap = APPRENTICE_MAX,   reqLevel =   5 },
    { cap = JOURNEYMAN_MAX,   reqLevel =  10 },
    { cap = EXPERT_MAX,       reqLevel =  10 },
    { cap = ARTISAN_MAX,      reqLevel =  10 },
    { cap = MASTER_MAX,       reqLevel =  58 },
    { cap = GRAND_MASTER_MAX, reqLevel =  70 },
    { cap = ILLUSTRIOUS_GRAND_MASTER_MAX, reqLevel =  80 },
    { cap = ZEN_MASTER_MAX,   reqLevel =  85 },
}

local skills = {
    { name = L["Fishing"],    thresholds = FISHING_THRESHOLDS },
    { name = L["Mining"],     thresholds = GATHERING_LEVEL_THRESHOLDS },
    { name = L["Herbalism"],  thresholds = GATHERING_LEVEL_THRESHOLDS },
    { name = L["Skinning"],   thresholds = GATHERING_LEVEL_THRESHOLDS },
}

local MAX_SKILL = ARTISAN_MAX

local eventHandlers = {
    PLAYER_ENTERING_WORLD = "MaybeCheckMaxSkill",
    PLAYER_UPDATE_RESTING = "MaybeCheckMaxSkill",
}

function GT:OnEnable()
    if IsClassicWow() then MAX_SKILL = ARTISAN_MAX
    elseif IsTBCWow() then MAX_SKILL = MASTER_MAX 
    elseif IsWrathWow() then MAX_SKILL = GRAND_MASTER_MAX
    elseif IsCataWow() then MAX_SKILL = ILLUSTRIOUS_GRAND_MASTER_MAX
    elseif IsMopWow() then MAX_SKILL = ZEN_MASTER_MAX end

    for event, func in pairs(eventHandlers) do
        self:RegisterEvent(event, func)
    end

    self.lastChecked = 0
end

function GT:MaybeCheckMaxSkill()
    local resting = IsResting()
    local now = GetTime()
    local delta = now-self.lastChecked
    if resting and delta > 5 then
        GT:checkMaxSkill()
        self.lastChecked = now
    end
end

local function remindSkilling(skill, playerSkill, maxSkill)
    UIErrorsFrame:AddMessage(L["Current"].." "..skill.." "..L["skill"]..": ".. tostring(playerSkill).."/"..tostring(maxSkill).." !!!",1.0,0.8,0.0,GetChatTypeIndex("SYSTEM"),5)
end



local function IsMaxLevel(maxSkill, skillLevel)
    local diff = maxSkill - skillLevel
    return diff == 0 or diff == 15
end

local function getMaxLevel(maxSkill)
    for _, skillLevel in ipairs(LEVELS) do
        if IsMaxLevel(maxSkill, skillLevel) then return skillLevel end
    end
    return 1000 -- we shouldn't get this
end

local function gatherLevels(skill, playerLevel, playerSkill, maxSkill, thresholds)
    for _, tier in ipairs(thresholds) do
        if playerLevel >= tier.reqLevel and maxSkill < tier.cap then
            return remindSkilling(skill, playerSkill, maxSkill)
        end
    end
end

local function checkSkill(playerLevel, skill)
    local playerSkill = GetSkillLevel(skill.name) or 0
    local maxSkill = GetMaxSkillLevel(skill.name) or 1000
    
    if maxSkill >= MAX_SKILL then return end
    if playerSkill > 0 and getMaxLevel(maxSkill) - playerSkill <= 25 then
        return gatherLevels(skill.name, playerLevel, playerSkill, maxSkill, skill.thresholds)
    end
end

function GT:checkMaxSkill()
    local playerLevel = UnitLevel("player")
    for _, skill in ipairs(skills) do
        checkSkill(playerLevel, skill)
    end
end



local debug = false
local function DebugPrint(...)
    if debug then
        print(...)
    end
end

local function ListMethods(obj)
    DebugPrint("tooltip:", obj)
    DebugPrint("type:", type(obj))
    for k, v in pairs(obj) do
        DebugPrint(k, type(v), v)
    end
end

local function TestMethods(obj)
    for k, v in pairs(obj) do
        if type(v) == "function" then
            DebugPrint("Testing method:", k)
            local status, result = pcall(v, obj)
            if status then
                DebugPrint(k, "returned:", result)
            else
                DebugPrint(k, "error:", result)
            end
        end
    end
end

local function EnumerateTooltipLines_helper(...)
    local lines = {}
    for i = 1, select("#", ...) do
        local region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText() -- string or nil
            if text then
                DebugPrint(i, text)
                table.insert(lines, {text = text, region = region})
            end
        end
    end
    return lines
end

function EnumerateTooltipLines(tooltip) -- good for script handlers that pass the tooltip as the first argument.
    DebugPrint("Attempting to list the tooltip lines")
    return EnumerateTooltipLines_helper(tooltip:GetRegions())
end

function GetSkillLevel(skillName)
    for i = 1, GetNumSkillLines() do
        local name, _, _, skillRank = GetSkillLineInfo(i)
        if name == skillName then
            DebugPrint("Found skill:", name, "with rank:", skillRank)
            return skillRank
        end
    end
    DebugPrint("Skill not found:", skillName)
    return nil
end

local baseLKSkill = 73 * 5
local baseCataSkill = baseLKSkill + 7 * 10
local baseCataSkill2 = baseCataSkill + 15

local function getRequiredSkinningSkill(mobLevel)
    if mobLevel <= 10 then
        return 1
    elseif mobLevel <= 20 then
        return (mobLevel * 10) - 100
    elseif mobLevel <= 73 then
        return mobLevel * 5
    end
    if mobLevel > 73 then
        if mobLevel <= 80 then
            return baseLKSkill + ((mobLevel - 73) * 10)
        end
    end
    if mobLevel > 80 then
        if mobLevel <= 83 then
            return baseCataSkill + ((mobLevel - 80) * 5)
        else
            return baseCataSkill2 + ((mobLevel - 83) * 20)
        end
    end
end

local function getMaxSkinnableMobLevel(playerSkill)
    if playerSkill < 10 then -- Skill 1 maps to level 1-10
        return 10
    elseif playerSkill <= 100 then -- Skill 10-100 maps to level 11-20
        return floor(playerSkill/10)
    elseif playerSkill <= baseLKSkill then -- Above that, divide skill by 5
        return floor(playerSkill/5)
    elseif playerSkill <= baseCataSkill then 
        return floor((playerSkill - baseLKSkill)/10) + 73
    elseif playerSkill <= baseCataSkill2 then
        return floor((playerSkill - baseCataSkill)/5) + 80
    else
        return floor((playerSkill - baseCataSkill2)/20) + 83
    end
end

function GetSkillColor(thresholds, requiredSkill, playerSkill)
    DebugPrint("Thresholds:", thresholds)
    if playerSkill >= thresholds.grey then
        return difficultyColours.grey
    elseif playerSkill >= thresholds.green then
        return difficultyColours.green
    elseif playerSkill >= thresholds.yellow then
        return difficultyColours.yellow
    elseif playerSkill >= requiredSkill then
        return difficultyColours.orange
    else
        return difficultyColours.red
    end
end

local function getSkinningColor(mobLevel, playerSkill)
    if not playerSkill then 
        return "ffff0000" -- Red if no skinning skill
    end
    
    local maxSkinnableLevel = getMaxSkinnableMobLevel(playerSkill)
    local levelDiff = maxSkinnableLevel - mobLevel

    if levelDiff >= 20 then
        return difficultyColours.grey -- Gray: Can skin mobs 20+ levels below max
    elseif levelDiff >= 10 then
        return difficultyColours.green -- Green: Can skin mobs 10-19 levels below max
    elseif levelDiff >= 5 then
        return  difficultyColours.yellow -- Yellow: Can skin mobs 5-9 levels below max
    elseif levelDiff >= 0 then
        return difficultyColours.orange -- Orange: Can skin mobs 0-4 levels below max
    else
        return difficultyColours.red -- Red: Mob level is above what player can skin
    end
end

local function GetMaxSkillLevel(skillName)
    for i = 1, GetNumSkillLines() do
        local name, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
        if name == skillName then
            return skillMaxRank
        end
    end
    return nil
end

local function isSkinnable(unit)
    local guid = UnitGUID(unit)
    if guid then
        local npcID = tonumber(guid:match("-(%d+)-%x+$"))
        if skinnable_npcs[npcID] then
            return true
        end
    end

    return false
end

local function isMinable(unit)
    local guid = UnitGUID(unit)
    if guid then
        local npcID = tonumber(guid:match("-(%d+)-%x+$"))
        if minable_npcs[npcID] then
            return true
        end
    end

    return false
end

local function isGatherable(unit)
    local guid = UnitGUID(unit)
    if guid then
        local npcID = tonumber(guid:match("-(%d+)-%x+$"))
        if gatherable_npcs[npcID] then
            return true
        end
    end

    return false
end


local function UpdateSkinningTooltip(tooltip, skillName)
    -- Get the unit from the tooltip
    local _, unit = tooltip:GetUnit()
    if not unit then return end
    
    -- Get creature type and level
    -- local creatureType = UnitCreatureType(unit)
    if not isSkinnable(unit) then return end
    
    -- Get mob level
    local mobLevel = UnitLevel(unit)
    if not mobLevel or mobLevel <= 0 then return end -- Level 0 or negative means hidden/boss
    
    local playerSkill = GetSkillLevel(skillName)
    if not playerSkill then return end
    
    local requiredSkill = getRequiredSkinningSkill(mobLevel)
    local maxSkinnableLevel = getMaxSkinnableMobLevel(playerSkill)
    local colour = getSkinningColor(mobLevel, playerSkill)
    local maxSkill = GetMaxSkillLevel(skillName)
    
    local colouredText = "|c"..colour..skillName.."|r ("..L["Req:"].." "..requiredSkill..")"
    tooltip:AddLine(colouredText, 1, 1, 1)

    -- Add skinning information
    if maxSkill then
                    tooltip:AddLine("|c"..otherColours.white..L["Current"].." "..skillName.." "..L["Skill"]..":|r "..playerSkill.."/"..maxSkill, 1, 1, 1)
                else
                    tooltip:AddLine("|c"..otherColours.white..L["Current"].." "..skillName.." "..L["Skill"]..":|r "..playerSkill, 1, 1, 1)
                end
    tooltip:Show()
end

local skinningSkills = {L["Skinning"], L["Mining"], L["Herbalism"]}
local function UpdateTooltip(tooltip)
    if not tooltip or type(tooltip.GetRegions) ~= "function" then
        return
    end

    local _, unit = tooltip:GetUnit()
    if unit then
        for _, skill in ipairs(skinningSkills)do
            UpdateSkinningTooltip(tooltip, skill)
        end
        return
    end

    local lines = EnumerateTooltipLines(tooltip)
    local playerSkills = {} -- Collect all relevant player skills
    local foundNodes = false

    for _, line in ipairs(lines) do
        local tooltipText = line.text
        local tooltipRegion = line.region
        DebugPrint("Tooltip text:", tooltipText)
        DebugPrint("Tooltip region:", tooltipRegion)

        -- Split tooltipText by line breaks and process each line separately
        local uniqueLines = {}
        for nodeLine in tooltipText:gmatch("[^\r\n]+") do
            uniqueLines[nodeLine] = true
        end

        for nodeLine, _ in pairs(uniqueLines) do
            -- Perform table lookup for known node names
            local match_found = false
            for _, nodeName in ipairs(nodeNameList) do
            -- for nodeName, nodeData in pairs(nodeInfo) do
                local nodeData = nodeInfo[nodeName]

                -- Check for Frozen Herb with specific zones 
                if nodeName == "Frozen Herb" then 
                    local currentSubzone = GetRealZoneText() -- Get the current subzone 
                    local currentZone = GetZoneText() -- Assume this gets the larger zone
                    nodeData = nodeData[currentZone] or nodeData[currentSubzone] or nodeData["any"] -- or nodeData[parentZone] 
                end

                if not match_found then
                    if nodeLine:find(nodeName) then
                        foundNodes = true
                        match_found = true
                        DebugPrint("Node name:", nodeName)
                        DebugPrint("Node data:", nodeData)
                        local skillName = nodeData.skill
                        local requiredSkill = nodeData.requiredSkill
                        local playerSkill = GetSkillLevel(skillName)
                        playerSkills[skillName] = playerSkill -- Store the player's skill level for this gathering skill
                        DebugPrint("Skill name:", skillName)
                        DebugPrint("Player skill:", playerSkill)
                        DebugPrint("Required skill:", requiredSkill)

                        -- Strip existing color codes
                        local plainText = nodeLine:gsub("|c%x%x%x%x%x%x%x%x(.-)|r", "%1")

                        if playerSkill then
                            local color = GetSkillColor(nodeData.thresholds, requiredSkill, playerSkill)
                            DebugPrint("Color:", color)
                            local coloredText = "|c"..color..plainText.."|r ("..L["Req:"].." "..requiredSkill..")"
                            tooltipText = tooltipText:gsub(nodeLine, coloredText)
                        end
                    end
                end
            end
        end
        -- Update the tooltip region with the modified text
        tooltipRegion:SetText(tooltipText)
    end

    if foundNodes then
        for skillName, playerSkill in pairs(playerSkills) do
            if playerSkill then
                local maxSkill = GetMaxSkillLevel(skillName)
                if maxSkill then
                    tooltip:AddLine(L["Current"].." "..skillName.." "..L["Skill"]..": "..playerSkill.."/"..maxSkill, 1, 1, 1)
                else
                    tooltip:AddLine(L["Current"].." "..skillName.." "..L["Skill"]..": "..playerSkill, 1, 1, 1)
                end
            end
        end
        tooltip:Show()
    end
end


-- Hook for all tooltips
GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
    DebugPrint("GameTooltip OnTooltipSetItem")
    UpdateTooltip(tooltip)
end)

GameTooltip:HookScript("OnShow", function(tooltip)
    DebugPrint("GameTooltip OnShow")
    UpdateTooltip(tooltip)
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip)
    DebugPrint("ItemRefTooltip OnTooltipSetItem")
    UpdateTooltip(tooltip)
end)


ItemRefTooltip:HookScript("OnShow", function(tooltip)
    DebugPrint("ItemRefTooltip OnShow")
    UpdateTooltip(tooltip)
end)

ShoppingTooltip1:HookScript("OnShow", function(tooltip)
    DebugPrint("ShoppingTooltip1 OnShow")
    UpdateTooltip(tooltip)
end)

ShoppingTooltip2:HookScript("OnShow", function(tooltip)
    DebugPrint("ShoppingTooltip2 OnShow")
    UpdateTooltip(tooltip)
end)