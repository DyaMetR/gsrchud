--[[------------------------------------------------------------------
  Half-Nuked theme
]]--------------------------------------------------------------------

local HUD2, HUD7 = '640hud2', '640hud7'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(48, 170, 255))

--[[ Files ]]--
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/halfnuked/640hud2'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/halfnuked/640hud7'), 256, 128)

--[[ Sprites ]]--
THEME:addSprite('number_0', HUD7, 0, 0, 20, 25)
THEME:addSprite('number_1', HUD7, 23, 0, 20, 25)
THEME:addSprite('number_2', HUD7, 47, 0, 20, 25)
THEME:addSprite('number_3', HUD7, 70, 0, 20, 25)
THEME:addSprite('number_4', HUD7, 95, 0, 20, 25)
THEME:addSprite('number_5', HUD7, 119, 0, 20, 25)
THEME:addSprite('number_6', HUD7, 144, 0, 20, 25)
THEME:addSprite('number_7', HUD7, 169, 0, 20, 25)
THEME:addSprite('number_8', HUD7, 192, 0, 20, 25)
THEME:addSprite('number_9', HUD7, 216, 0, 20, 25)

THEME:addSprite('cross', HUD7, 80, 24, 32, 32)

THEME:addSprite('suit_full', HUD7, 0, 24, 40, 40)
THEME:addSprite('suit_empty', HUD7, 40, 24, 40, 40)

THEME:addSprite('flash_full', HUD7, 160, 25, 30, 32)
THEME:addSprite('flash_empty', HUD7, 112, 25, 30, 32)
THEME:addSprite('flash_beam', HUD7, 142, 25, 16, 32)

THEME:addSprite('item_vest', HUD2, 176, 0, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', 'item_vest')

--[[ Register ]]--
GSRCHUD.THEME_HALFNUKED = GSRCHUD.theme.register('Half-Nuked', THEME)
