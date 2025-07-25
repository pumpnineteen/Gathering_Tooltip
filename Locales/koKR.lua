-- GatheringTooltip Locale; based on GatherMate-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/gathermate2-classic/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltip", "koKR")
if not L then return end

-- Options
L["Always show"] = "항상 표시"
L["Archaeology"] = "고고학"
L["Disabled"] = "불가"
L["Enabled"] = "가능"
L["Fishes"] = "낚시"
L["Fishing"] = "낚시"
L["Frequently Asked Questions"] = "중요한 질문과 답변"
L["Gas filter"] = "가스 분류"
L["Herb Bushes"] = "약초"
L["Herbalism"] = "약초채집"
L["Mineral Veins"] = "광맥"
L["Mining"] = "채광"
L["Never show"] = "항상 숨김"
L["Only while tracking"] = "추적하는 동안에만"
L["Only with profession"] = "전문기술이 있을때만"
L["Demon"] = "악마"
L["Skinning"] = "무두질"
L["Beast"] = "야수"
L["Dragonkin"] = "용족"
L["Humanoid"] = "인간형"
L["Current"] = "현재"
L["skill"] = "기술"
L["Skill"] = "기술"
L["Req:"] = "요구:"  -- Korean abbreviation for "요구사항"
L["Toggle tooltip for fishing nodes."] = "낚시 장소 툴팁 표시/숨기기"
L["Toggle tooltip for herbalism nodes."] = "약초 채집 장소 툴팁 표시/숨기기"
L["Toggle tooltip for mining nodes."] = "채광 장소 툴팁 표시/숨기기"
L["Toggle tooltip for archaeology nodes."] = "고고학 발굴 장소 툴팁 표시/숨기기"
L["Toggle tooltip for gas clouds."] = "가스 구름 툴팁 표시/숨기기"
L["Wintergrasp"] = "겨울손아귀"

local NL = LibStub("AceLocale-3.0"):NewLocale("GatheringTooltipNodes", "koKR")
if not NL then return end

-- Nodes
NL["Arthas' Tears"] = "아서스의 눈물"
NL["Black Lotus"] = "검은 연꽃"
NL["Blindweed"] = "실명초"
NL["Briarthorn"] = "찔레가시"
NL["Bruiseweed"] = "생채기풀"
NL["Copper Vein"] = "구리 광맥"
NL["Dark Iron Deposit"] = "검은무쇠 광맥"
NL["Dreamfoil"] = "꿈풀"
NL["Earthroot"] = "뱀뿌리"
NL["Fadeleaf"] = "미명초잎"
NL["Firebloom"] = "화염초"
NL["Ghost Mushroom"] = "유령버섯"
NL["Gold Vein"] = "금 광맥"
NL["Golden Sansam"] = "황금 산삼"
NL["Goldthorn"] = "황금가시"
NL["Grave Moss"] = "무덤이끼"
NL["Gromsblood"] = "그롬의 피"
NL["Icecap"] = "얼음송이"
NL["Iron Deposit"] = "철 광맥"
NL["Khadgar's Whisker"] = "카드가의 수염"
NL["Kingsblood"] = "왕꽃잎풀"
NL["Liferoot"] = "생명의 뿌리"
NL["Mageroyal"] = "마법초"
NL["Mithril Deposit"] = "미스릴 광맥"
NL["Mountain Silversage"] = "은초롱이"
NL["Ooze Covered Gold Vein"] = "진흙으로 덮인 금 광맥"
NL["Ooze Covered Mithril Deposit"] = "진흙으로 덮인 미스릴 광맥"
NL["Ooze Covered Rich Thorium Vein"] = "진흙으로 덮인 풍부한 토륨 광맥"
NL["Ooze Covered Silver Vein"] = "진흙으로 덮인 은 광맥"
NL["Ooze Covered Thorium Vein"] = "진흙으로 덮인 토륨 광맥"
NL["Ooze Covered Truesilver Deposit"] = "진흙으로 덮인 진은 광맥"
NL["Peacebloom"] = "평온초"
NL["Plaguebloom"] = "역병초"
NL["Purple Lotus"] = "보라 연꽃"
NL["Rich Thorium Vein"] = "풍부한 토륨 광맥"
NL["Silver Vein"] = "은 광맥"
NL["Silverleaf"] = "은엽수 덤불"
NL["Small Thorium Vein"] = "작은 토륨 광맥"
NL["Stranglekelp"] = "갈래물풀"
NL["Sungrass"] = "태양풀"
NL["Tin Vein"] = "주석 광맥"
NL["Truesilver Deposit"] = "진은 광맥"
NL["Wild Steelbloom"] = "야생 철쭉"
NL["Wintersbite"] = "겨울서리풀"
NL["Adamantite Deposit"] = "아다만타이트 광맥"
NL["Adder's Tongue"] = "얼레지 꽃"
NL["Ancient Lichen"] = "고대 이끼"
NL["Azshara's Veil"] = "아즈샤라의 신비"
NL["Cinderbloom"] = "재투성이꽃"
NL["Cobalt Deposit"] = "코발트 광맥"
NL["Elementium Vein"] = "엘레멘티움 광맥"
NL["Fel Iron Deposit"] = "지옥무쇠 광맥"
NL["Felweed"] = "지옥풀"
NL["Firethorn"] = "화염가시풀"
NL["Frost Lotus"] = "서리 연꽃"
NL["Frozen Herb"] = "얼어붙은 약초"
NL["Goldclover"] = "황금토끼풀"
NL["Heartblossom"] = "심장꽃"
NL["Icethorn"] = "얼음가시"
NL["Khorium Vein"] = "코륨 광맥"
NL["Lichbloom"] = "시체꽃"
NL["Mana Thistle"] = "마나 엉겅퀴"
NL["Netherbloom"] = "황천꽃"
NL["Nightmare Vine"] = "악몽의 덩굴"
NL["Obsidium Deposit"] = "흑요암 광맥"
NL["Pyrite Deposit"] = "황철석 광맥"
NL["Ragveil"] = "가림막이버섯"
NL["Rich Adamantite Deposit"] = "풍부한 아다만타이트 광맥"
NL["Rich Cobalt Deposit"] = "풍부한 코발트 광맥"
NL["Rich Elementium Vein"] = "풍부한 엘레멘티움 광맥"
NL["Rich Obsidium Deposit"] = "풍부한 흑요암 광맥"
NL["Rich Pyrite Deposit"] = "풍부한 황철석 광맥"
NL["Rich Saronite Deposit"] = "풍부한 사로나이트 광맥"
NL["Saronite Deposit"] = "사로나이트 광맥"
NL["Stormvine"] = "폭풍덩굴"
NL["Talandra's Rose"] = "탈란드라의 장미"
NL["Terocone"] = "테로열매"
NL["Tiger Lily"] = "참나리"
NL["Titanium Vein"] = "티타늄 광맥"
NL["Twilight Jasmine"] = "황혼의 말리꽃"
NL["Whiptail"] = "채찍꼬리"
NL["Cobalt Ore"] = "코발트 광석"
NL["Titanium Ore"] = "티타늄 광석"
NL["Thorium Ore"] = "토륨 광석"
NL["Frozen Herb-Wintergrasp"] = "얼어붙은 약초-겨울손아귀"
NL["Iron Ore"] = "철 광석"
NL["Adamantite Ore"] = "아다만타이트 광석"
NL["Fel Iron Ore"] = "지옥무쇠 광석"
NL["Obsidium Ore"] = "흑요암 광석"
NL["Truesilver Ore"] = "진은 광석"
NL["Silver Ore"] = "은 광석"
NL["Pyrite Ore"] = "황철석 광석"
NL["Copper Ore"] = "구리 광석"
NL["Dark Iron Ore"] = "검은무쇠 광석"
NL["Elementium Ore"] = "엘레멘티움 광석"
NL["Gold Ore"] = "금 광석"
NL["Tin Ore"] = "주석 광석"
NL["Mithril Ore"] = "미스릴 광석"
NL["Khorium Ore"] = "코륨 광석"
NL["Saronite Ore"] = "사로나이트 광석"

-- MOP Mining Nodes --
NL["Ghost Iron Deposit"]      = "유령철 광맥"
NL["Rich Ghost Iron Deposit"] = "풍부한 유령철 광맥"
NL["Kyparite Deposit"]        = "키파라이트 광맥"
NL["Rich Kyparite Deposit"]   = "풍부한 키파라이트 광맥"
NL["Trillium Vein"]           = "트릴리엄 광맥"
NL["Rich Trillium Vein"]      = "풍부한 트릴리엄 광맥"

-- MOP Ores --
NL["Ghost Iron Ore"]          = "유령철 광석"
NL["Kyparite"]                = "키파라이트"
NL["Black Trillium Ore"]      = "검은 트릴리엄 광석"
NL["White Trillium Ore"]      = "흰 트릴리엄 광석"

-- MOP Herbalism Nodes --
NL["Green Tea Leaf"]          = "녹차잎"
NL["Silkweed"]                = "비단풀"
NL["Golden Lotus"]            = "황금연꽃"
NL["Rain Poppy"]              = "비양귀비"
NL["Sha-Touched Herb"]        = "샤에 물든 약초"
NL["Snow Lily"]               = "눈백합"
NL["Fool's Cap"]              = "바보모자"