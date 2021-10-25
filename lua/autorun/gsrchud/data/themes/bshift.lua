--[[------------------------------------------------------------------
  Half-Life: Blue Shift theme
]]--------------------------------------------------------------------

local BS_HUD = 'bs_hud'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(95, 95, 255))

--[[ Files ]]--
THEME:addTexture(BS_HUD, surface.GetTextureID('gsrchud/bshift/bs_hud'), 128, 64)

--[[ Sprites ]]--
THEME:addSprite('item_vest', BS_HUD, 45, 0, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', 'item_vest')

--[[ Register ]]--
GSRCHUD.THEME_BLUESHIFT = GSRCHUD.theme.register('Half-Life: Blue Shift', THEME)
