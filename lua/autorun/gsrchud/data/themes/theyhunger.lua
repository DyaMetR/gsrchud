--[[------------------------------------------------------------------
  They Hunger theme
]]--------------------------------------------------------------------

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(255, 0, 0))

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('hideDivider', not localPlayer.Armor or localPlayer:Armor() <= 0)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('hide', not localPlayer.Armor or localPlayer:Armor() <= 0)
end)

--[[ Register ]]--
GSRCHUD.THEME_THEYHUNGER = GSRCHUD.theme.register('They Hunger', THEME)
