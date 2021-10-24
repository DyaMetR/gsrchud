--[[------------------------------------------------------------------
  Half-Life: Echoes theme
]]--------------------------------------------------------------------

local HUD7, BS_HUD = '640hud7', 'bs_hud'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(255, 255, 255))

--[[ Files ]]--
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/echoes/640hud7'), 256, 128)
THEME:addTexture(BS_HUD, surface.GetTextureID('gsrchud/bshift/bs_hud'), 128, 64)

--[[ Sprites ]]--
THEME:addSprite('suit_empty', HUD7, 40, 24, 38, 39)
THEME:addSprite('suit_full', HUD7, 0, 24, 40, 39)
THEME:addSprite('item_vest', BS_HUD, 45, 0, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', 'item_vest')

--[[ Register ]]--
GSRCHUD.THEME_ECHOES = GSRCHUD.theme.register('Half-Life: Echoes', THEME)
