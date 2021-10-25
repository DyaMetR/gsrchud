--[[------------------------------------------------------------------
  Half-Life: Opposing Force PRESS DEMO theme
]]--------------------------------------------------------------------

local HUD7 = '_640hud7'
-- create theme
local THEME = GSRCHUD.theme.create(GSRCHUD.THEME_OPPOSINGFORCE)

--[[ Colour ]]--
THEME:setColour(Color(0, 255, 0))

--[[ Files ]]--
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/ofdemo/640hud7'), 256, 128)

--[[ Sprites ]]--
THEME:addSprite('cross', HUD7, 80, 24, 32, 32)

THEME:addSprite('suit_full', HUD7, 0, 24, 40, 40)
THEME:addSprite('suit_empty', HUD7, 40, 24, 40, 40)

--[[ Register ]]--
GSRCHUD.THEME_OFPRESSDEMO = GSRCHUD.theme.register('Half-Life: Opposing Force PRESS DEMO', THEME)
