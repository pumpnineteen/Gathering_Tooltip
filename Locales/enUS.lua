-- GatheringTooltip Locale; based on GatherMate
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/gathermate2-classic/localization/

local debug = false
-- [==[@debug@
debug = true
-- @end-debug@]==]

local L = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltip", "enUS", true, debug)

local NL = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltipNodes", "enUS", true, debug)

-- Options
L["Humanoid"] = true
L["Gas filter"] = true
L["Toggle tooltip for fishing nodes."] = true
L["Fishes"] = true
L["Current"] = true
L["Mineral Veins"] = true
L["skill"] = true
L["Skill"] = true
L["Herbalism"] = true
L["Toggle tooltip for mining nodes."] = true
L["Req:"] = true
L["Toggle tooltip for archaeology nodes."] = true
L["Wintergrasp"] = true
L["Never show"] = true
L["Toggle tooltip for gas clouds."] = true
L["Demon"] = true
L["Skinning"] = true
L["Only with profession"] = true
L["Beast"] = true
L["Dragonkin"] = true
L["Mining"] = true
L["Fishing"] = true
L["Always show"] = true
L["Herb Bushes"] = true
L["Toggle tooltip for herbalism nodes."] = true
L["Enabled"] = true
L["Only while tracking"] = true
L["Frequently Asked Questions"] = true
L["Archaeology"] = true
L["Disabled"] = true

-- Nodes
NL["Titanium Ore"] = true
NL["Thorium Ore"] = true
NL["Gromsblood"] = true
NL["Icethorn"] = true
NL["Frost Lotus"] = true
NL["Rich Thorium Vein"] = true
NL["Ghost Mushroom"] = true
NL["Ragveil"] = true
NL["Wild Steelbloom"] = true
NL["Obsidium Ore"] = true
NL["Tiger Lily"] = true
NL["Peacebloom"] = true
NL["Rich Elementium Vein"] = true
NL["Ooze Covered Gold Vein"] = true
NL["Rich Obsidium Deposit"] = true
NL["Rich Pyrite Deposit"] = true
NL["Goldthorn"] = true
NL["Gold Ore"] = true
NL["Fadeleaf"] = true
NL["Wintersbite"] = true
NL["Copper Vein"] = true
NL["Obsidium Deposit"] = true
NL["Azshara's Veil"] = true
NL["Ooze Covered Mithril Deposit"] = true
NL["Dreamfoil"] = true
NL["Frozen Herb-Wintergrasp"] = true
NL["Whiptail"] = true
NL["Iron Ore"] = true
NL["Adamantite Ore"] = true
NL["Adder's Tongue"] = true
NL["Ooze Covered Truesilver Deposit"] = true
NL["Iron Deposit"] = true
NL["Silver Vein"] = true
NL["Twilight Jasmine"] = true
NL["Ancient Lichen"] = true
NL["Fel Iron Deposit"] = true
NL["Copper Ore"] = true
NL["Dark Iron Ore"] = true
NL["Firethorn"] = true
NL["Heartblossom"] = true
NL["Elementium Ore"] = true
NL["Truesilver Ore"] = true
NL["Silverleaf"] = true
NL["Rich Cobalt Deposit"] = true
NL["Talandra's Rose"] = true
NL["Saronite Deposit"] = true
NL["Rich Adamantite Deposit"] = true
NL["Sungrass"] = true
NL["Tin Vein"] = true
NL["Truesilver Deposit"] = true
NL["Khadgar's Whisker"] = true
NL["Stormvine"] = true
NL["Dark Iron Deposit"] = true
NL["Mageroyal"] = true
NL["Firebloom"] = true
NL["Felweed"] = true
NL["Fel Iron Ore"] = true
NL["Titanium Vein"] = true
NL["Rich Saronite Deposit"] = true
NL["Netherbloom"] = true
NL["Ooze Covered Silver Vein"] = true
NL["Purple Lotus"] = true
NL["Kingsblood"] = true
NL["Pyrite Ore"] = true
NL["Mountain Silversage"] = true
NL["Elementium Vein"] = true
NL["Grave Moss"] = true
NL["Terocone"] = true
NL["Liferoot"] = true
NL["Black Lotus"] = true
NL["Khorium Vein"] = true
NL["Tin Ore"] = true
NL["Mithril Ore"] = true
NL["Mana Thistle"] = true
NL["Icecap"] = true
NL["Nightmare Vine"] = true
NL["Stranglekelp"] = true
NL["Lichbloom"] = true
NL["Adamantite Deposit"] = true
NL["Earthroot"] = true
NL["Arthas' Tears"] = true
NL["Cinderbloom"] = true
NL["Cobalt Deposit"] = true
NL["Frozen Herb"] = true
NL["Plaguebloom"] = true
NL["Gold Vein"] = true
NL["Pyrite Deposit"] = true
NL["Blindweed"] = true
NL["Ooze Covered Thorium Vein"] = true
NL["Golden Sansam"] = true
NL["Ooze Covered Rich Thorium Vein"] = true
NL["Bruiseweed"] = true
NL["Silver Ore"] = true
NL["Small Thorium Vein"] = true
NL["Khorium Ore"] = true
NL["Mithril Deposit"] = true
NL["Briarthorn"] = true
NL["Cobalt Ore"] = true
NL["Saronite Ore"] = true
NL["Goldclover"] = true

-- MOP Mining Nodes --
NL["Ghost Iron Deposit"] = true
NL["Rich Ghost Iron Deposit"] = true
NL["Kyparite Deposit"] = true
NL["Rich Kyparite Deposit"] = true
NL["Trillium Vein"] = true
NL["Rich Trillium Vein"] = true

-- MOP Ores --
NL["Ghost Iron Ore"] = true
NL["Kyparite"] = true
NL["Black Trillium Ore"] = true
NL["White Trillium Ore"] = true

-- MOP Herbalism Nodes --
NL["Green Tea Leaf"] = true
NL["Silkweed"] = true
NL["Golden Lotus"] = true
NL["Rain Poppy"] = true
NL["Sha-Touched Herb"] = true
NL["Snow Lily"] = true
NL["Fool's Cap"] = true