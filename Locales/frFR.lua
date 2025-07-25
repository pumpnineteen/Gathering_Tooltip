-- GatheringTooltip Locale; based on GatherMate-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/gathermate2-classic/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltip", "frFR")
if not L then return end

-- Options
L["Always show"] = "Toujours afficher"
L["Archaeology"] = "Archéologie"
L["Disabled"] = "Désactivées"
L["Enabled"] = "Activées"
L["Fishes"] = "Poissons"
L["Fishing"] = "Pêche"
L["Frequently Asked Questions"] = "Foire aux questions"
L["Gas filter"] = "Filtre des gaz"
L["Herb Bushes"] = "Buissons d'herbe"
L["Herbalism"] = "Herboristerie"
L["Mineral Veins"] = "Veines de minerai"
L["Mining"] = "Minage"
L["Never show"] = "Ne jamais afficher"
L["Only while tracking"] = "Si le suivi est activé"
L["Only with profession"] = "Si j'ai le métier"
L["Demon"] = "Démon"
L["Skinning"] = "Dépeçage"
L["Beast"] = "Bête"
L["Dragonkin"] = "Dragon"
L["Humanoid"] = "Humanoïde"
L["Current"] = "Actuel"
L["skill"] = "compétence"
L["Skill"] = "Compétence"
L["Req:"] = "Req:"  -- Common French abbreviation for "Requis"
L["Toggle tooltip for fishing nodes."] = "Activer/Désactiver l'infobulle pour les points de pêche"
L["Toggle tooltip for herbalism nodes."] = "Activer/Désactiver l'infobulle pour les herbes"
L["Toggle tooltip for mining nodes."] = "Activer/Désactiver l'infobulle pour les minerais"
L["Toggle tooltip for archaeology nodes."] = "Activer/Désactiver l'infobulle pour l'archéologie"
L["Toggle tooltip for gas clouds."] = "Activer/Désactiver l'infobulle pour les nuages de gaz"
L["Wintergrasp"] = "Joug-d'hiver"

local NL = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltipNodes", "frFR")
if not NL then return end

-- Nodes
NL["Arthas' Tears"] = "Larmes d'Arthas"
NL["Black Lotus"] = "Lotus noir"
NL["Blindweed"] = "Aveuglette"
NL["Briarthorn"] = "Eglantine"
NL["Bruiseweed"] = "Doulourante"
NL["Copper Vein"] = "Filon de cuivre"
NL["Dark Iron Deposit"] = "Gisement de sombrefer"
NL["Dreamfoil"] = "Feuillerêve"
NL["Earthroot"] = "Terrestrine"
NL["Fadeleaf"] = "Pâlerette"
NL["Firebloom"] = "Fleur de feu"
NL["Ghost Mushroom"] = "Champignon fantôme"
NL["Gold Vein"] = "Filon d'or"
NL["Golden Sansam"] = "Sansam doré"
NL["Goldthorn"] = "Dorépine"
NL["Grave Moss"] = "Tombeline"
NL["Gromsblood"] = "Gromsang"
NL["Icecap"] = "Calot de glace"
NL["Iron Deposit"] = "Gisement de fer"
NL["Khadgar's Whisker"] = "Moustache de Khadgar"
NL["Kingsblood"] = "Sang-royal"
NL["Liferoot"] = "Vietérule"
NL["Mageroyal"] = "Mage royal"
NL["Mithril Deposit"] = "Gisement de mithril"
NL["Mountain Silversage"] = "Sauge-argent des montagnes"
NL["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon"
NL["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase"
NL["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon"
NL["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon"
NL["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon"
NL["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase"
NL["Peacebloom"] = "Pacifique"
NL["Plaguebloom"] = "Fleur de peste"
NL["Purple Lotus"] = "Lotus pourpre"
NL["Rich Thorium Vein"] = "Riche filon de thorium"
NL["Silver Vein"] = "Filon d'argent"
NL["Silverleaf"] = "Feuillargent"
NL["Small Thorium Vein"] = "Petit filon de thorium"
NL["Stranglekelp"] = "Etouffante"
NL["Sungrass"] = "Soleillette"
NL["Tin Vein"] = "Filon d'étain"
NL["Truesilver Deposit"] = "Gisement de vrai-argent"
NL["Wild Steelbloom"] = "Aciérite sauvage"
NL["Wintersbite"] = "Hivernale"
NL["Adamantite Deposit"] = "Gisement d'adamantite"
NL["Adder's Tongue"] = "Langue de serpent"
NL["Ancient Lichen"] = "Lichen ancien"
NL["Azshara's Veil"] = "Voile d'Azshara"
NL["Cinderbloom"] = "Cendrelle"
NL["Cobalt Deposit"] = "Gisement de cobalt"
NL["Elementium Vein"] = "Filon d'élémentium"
NL["Fel Iron Deposit"] = "Gisement de gangrefer"
NL["Felweed"] = "Gangrelette"
NL["Firethorn"] = "Epine de feu"
NL["Frost Lotus"] = "Lotus givré"
NL["Frozen Herb"] = "Herbe gelée"
NL["Goldclover"] = "Trèfle doré"
NL["Heartblossom"] = "Pétale de cœur"
NL["Icethorn"] = "Glacépine"
NL["Khorium Vein"] = "Filon de khorium"
NL["Lichbloom"] = "Fleur-de-liche"
NL["Mana Thistle"] = "Chardon de mana"
NL["Netherbloom"] = "Néantine"
NL["Nightmare Vine"] = "Cauchemardelle"
NL["Obsidium Deposit"] = "Gisement d'obsidium"
NL["Pyrite Deposit"] = "Gisement de pyrite"
NL["Ragveil"] = "Voile-misère"
NL["Rich Adamantite Deposit"] = "Riche gisement d'adamantite"
NL["Rich Cobalt Deposit"] = "Riche gisement de cobalt"
NL["Rich Elementium Vein"] = "Riche filon d'élémentium"
NL["Rich Obsidium Deposit"] = "Riche gisement d'obsidienne"
NL["Rich Pyrite Deposit"] = "Riche gisement de pyrite"
NL["Rich Saronite Deposit"] = "Riche gisement de saronite"
NL["Saronite Deposit"] = "Gisement de saronite"
NL["Stormvine"] = "Vignétincelle"
NL["Talandra's Rose"] = "Rose de Talandra"
NL["Terocone"] = "Terocône"
NL["Tiger Lily"] = "Lys tigré"
NL["Titanium Vein"] = "Veine de titane"
NL["Twilight Jasmine"] = "Jasmin crépusculaire"
NL["Whiptail"] = "Fouettine"
NL["Cobalt Ore"] = "Minerai de cobalt"
NL["Titanium Ore"] = "Minerai de titane"
NL["Thorium Ore"] = "Minerai de thorium"
NL["Frozen Herb-Wintergrasp"] = "Herbe gelée du Joug-d'hiver"
NL["Iron Ore"] = "Minerai de fer"
NL["Adamantite Ore"] = "Minerai d'adamantite"
NL["Fel Iron Ore"] = "Minerai de gangrefer"
NL["Obsidium Ore"] = "Minerai d'obsidium"
NL["Truesilver Ore"] = "Minerai de vrai-argent"
NL["Silver Ore"] = "Minerai d'argent"
NL["Pyrite Ore"] = "Minerai de pyrite"
NL["Copper Ore"] = "Minerai de cuivre"
NL["Dark Iron Ore"] = "Minerai de sombrefer"
NL["Elementium Ore"] = "Minerai d'élémentium"
NL["Gold Ore"] = "Minerai d'or"
NL["Tin Ore"] = "Minerai d'étain"
NL["Mithril Ore"] = "Minerai de mithril"
NL["Khorium Ore"] = "Minerai de khorium"
NL["Saronite Ore"] = "Minerai de saronite"

-- MOP Mining Nodes --
NL["Ghost Iron Deposit"]       = "Gisement de fer fantôme"
NL["Rich Ghost Iron Deposit"]  = "Gisement de fer fantôme riche"
NL["Kyparite Deposit"]         = "Gisement de kyparite"
NL["Rich Kyparite Deposit"]    = "Gisement de kyparite riche"
NL["Trillium Vein"]            = "Filon de trillium"
NL["Rich Trillium Vein"]       = "Filon de trillium riche"

-- MOP Ores --
NL["Ghost Iron Ore"]           = "Minerai de fer fantôme"
NL["Kyparite"]                 = "Kyparite"
NL["Black Trillium Ore"]       = "Minerai de trillium noir"
NL["White Trillium Ore"]       = "Minerai de trillium blanc"

-- MOP Herbalism Nodes --
NL["Green Tea Leaf"]           = "Feuille de thé vert"
NL["Silkweed"]                 = "Herbe soyeuse"
NL["Golden Lotus"]             = "Lotus doré"
NL["Rain Poppy"]               = "Pavot de pluie"
NL["Sha-Touched Herb"]         = "Herbe imprégnée de Sha"
NL["Snow Lily"]                = "Lis des neiges"
NL["Fool's Cap"]               = "Toque du fou"