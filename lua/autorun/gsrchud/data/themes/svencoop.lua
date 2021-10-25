--[[------------------------------------------------------------------
  Sven-Coop theme
]]--------------------------------------------------------------------

local _HUD7, HUD7 = '_640hud7', '640hud7'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(135, 170, 255))

--[[ Files ]]--
THEME:addTexture(_HUD7, surface.GetTextureID('gsrchud/default/640hud7'), 256, 128)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/svencoop/640hud7'), 256, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket1', HUD7, 0, 108, 20, 20)
THEME:addSprite('bucket2', HUD7, 20, 108, 20, 20)
THEME:addSprite('bucket3', HUD7, 40, 108, 20, 20)
THEME:addSprite('bucket4', HUD7, 60, 108, 20, 20)
THEME:addSprite('bucket5', HUD7, 80, 108, 20, 20)
THEME:addSprite('bucket6', HUD7, 100, 108, 20, 20)
THEME:addSprite('bucket0', HUD7, 200, 108, 20, 20)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), HUD7, 20 * i, 0, 20, 20)
end

THEME:addSprite('divider', _HUD7, 240, 0, 2, 20)

THEME:addSprite('cross', HUD7, 74, 24, 34, 35)

THEME:addSprite('suit_full', HUD7, 0, 20, 32, 38)
THEME:addSprite('suit_empty', HUD7, 36, 20, 32, 38)

THEME:addSprite('flash_full', HUD7, 164, 20, 32, 32)
THEME:addSprite('flash_empty', HUD7, 116, 20, 32, 32)
THEME:addSprite('flash_beam', HUD7, 148, 20, 16, 32)

--[[ Ammunition ]]--
THEME:addAmmoSprite('SMG1', HUD7, 168, 60, 24, 24)
THEME:addAmmoSprite('AR2', HUD7, 144, 60, 24, 24)
THEME:setAmmoSprite('SniperRound', 'ammo_AR2')
THEME:setAmmoSprite('SniperPenetratedRound', 'ammo_AR2')
THEME:addAmmoSprite('weapon_medkit', HUD7, 192, 84, 24, 24)

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  element:set('y', ScrH() - 16 * GSRCHUD.sprite.scale())
  element:set('numberOffset', 4)
  element:set('crossOffset', 8)
  element:set('hideDivider', true)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  local health = GSRCHUD.element.import('health')
  local scale = GSRCHUD.sprite.scale()
  local healthWidth = (health.width or 0) + 19 * scale
  local margin = math.max(healthWidth, (ScrW() - 720) * .2)
  local x, y = 16, ScrH() - 16 * scale
  element:set('x', x + margin)
  element:set('y', y)
  element:set('suitOffset', 9)
  element:set('numberOffset', 4)

  -- draw divider (if necessary)
  if margin <= healthWidth then
    GSRCHUD.sprite.drawTwin('divider', x + health.width + 8 * scale, y, GSRCHUD.number.get(GSRCHUD.NUMBER_HEALTH).highlight, localPlayer:Health() <= 25, nil, TEXT_ALIGN_BOTTOM)
  end
end)
THEME:addPreDraw('ammo', function(element)
  local scale = GSRCHUD.sprite.scale()
  element:set('x', ScrW() - 20 * scale)
  element:set('y', ScrH() - 16 * scale)
  element:set('iconOffsetX', 4)
  element:set('iconOffsetY', -2)
  element:set('altOffsetX', 0)
  element:set('altOffsetY', -10)
end)

--[[ Register ]]--
GSRCHUD.THEME_SVENCOOP = GSRCHUD.theme.register('Sven-Coop', THEME)
