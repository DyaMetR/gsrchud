--[[------------------------------------------------------------------
  Brutal Half-Life theme
]]--------------------------------------------------------------------

local HUD7 = '640hud7'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(255, 0, 0))
THEME:setCriticalColour(Color(100, 0, 255))

--[[ Files ]]--
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/bhl/640hud7'), 256, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket6', HUD7, 228, 92, 20, 20)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), HUD7, 24 * i, 0, 20, 24)
end

THEME:addSprite('suit_full', HUD7, 0, 24, 40, 40)
THEME:addSprite('suit_empty', HUD7, 40, 24, 40, 40)

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  element:set('hideDivider', true)
  element:set('low', false)
  element:set('crossOffset', 3)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('x', 12)
  element:set('y', ScrH() - 48 * GSRCHUD.sprite.scale())
  element:set('numberOffset', -10)
  element:set('suitOffset', 7)
  element:set('hide', localPlayer.Armor and localPlayer:Armor() <= 0)
end)
THEME:addPreDraw('hazards', function(element)
  element:set('y', ScrH() - 88 * GSRCHUD.sprite.scale())
end)

--[[ Pickup history replacement ]]--
local LAYOUT = surface.GetTextureID('gsrchud/_shared/white_additive')
local colour = Color(255, 230, 75, 0) -- start transparent

-- override pickup
hook.Add('GSRCHUDPickup', GSRCHUD.hookname .. '_bhl', function()
  if GSRCHUD.theme.used() ~= GSRCHUD.THEME_BRUTALHALFLIFE then return end
  colour.a = 10
  return true
end)

-- draw
THEME:addPreDraw('pickup', function(element)
  colour.a = math.max(colour.a - RealFrameTime() * 40, 0)
  surface.SetTexture(LAYOUT)
  surface.SetDrawColor(colour)
  surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
  return true
end)

--[[ Register ]]--
GSRCHUD.THEME_BRUTALHALFLIFE = GSRCHUD.theme.register('Brutal Half-Life', THEME)
