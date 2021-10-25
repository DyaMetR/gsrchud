--[[------------------------------------------------------------------
  Half-Life: Decay themes
]]--------------------------------------------------------------------

-- create theme
local GINA = GSRCHUD.theme.create()
local COLETTE = GSRCHUD.theme.create()

--[[ Colour ]]--
GINA:setColour(Color(160, 160, 192))
COLETTE:setColour(Color(255, 128, 64))

--[[ Register ]]--
GSRCHUD.THEME_GINACROSS = GSRCHUD.theme.register('Half-Life: Decay (Gina Cross)', GINA)
GSRCHUD.THEME_COLETTEGREEN = GSRCHUD.theme.register('Half-Life: Decay (Colette Green)', COLETTE)
