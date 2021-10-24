--[[------------------------------------------------------------------
  Counter-Strike theme
]]--------------------------------------------------------------------

local BUCKET, HUD6, HUD7, _HUD7 = '640bucket', '640hud6', '640hud7', '_640hud7'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/cstrike/640bucket'), 256, 64)
THEME:addTexture(HUD6, surface.GetTextureID('gsrchud/cstrike/640hud6'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/cstrike/640hud7'), 256, 256)
THEME:addTexture(_HUD7, surface.GetTextureID('gsrchud/default/640hud7'), 256, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket', BUCKET, 0, 0, 170, 45)
THEME:addSprite('selection', HUD6, 0, 180, 170, 45)

THEME:addSprite('bucket1', HUD7, 168, 72, 20, 20)
THEME:addSprite('bucket2', HUD7, 188, 72, 20, 20)
THEME:addSprite('bucket3', HUD7, 208, 72, 20, 20)
THEME:addSprite('bucket4', HUD7, 168, 92, 20, 20)
THEME:addSprite('bucket5', HUD7, 188, 92, 20, 20)
THEME:addSprite('bucket0', HUD7, 208, 92, 20, 20)
THEME:addSprite('bucket6', HUD7, 228, 72, 20, 20)

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

THEME:addSprite('divider', HUD7, 240, 0, 2, 25)

THEME:addSprite('cross', HUD7, 48, 25, 24, 24)

THEME:addSprite('suit_full', HUD7, 0, 25, 24, 24)
THEME:addSprite('suit_empty', HUD7, 24, 25, 24, 24)

THEME:addSprite('suithelmet_full', HUD7, 0, 124, 24, 24)
THEME:addSprite('suithelmet_empty', HUD7, 24, 124, 24, 24)

THEME:addSprite('flash_full', HUD7, 160, 25, 30, 32)
THEME:addSprite('flash_empty', HUD7, 112, 25, 30, 32)
THEME:addSprite('flash_beam', HUD7, 142, 25, 16, 32)

--[[ Ammunition ]]--
THEME:addAmmoSprite('Pistol', HUD7, 48, 72, 24, 24)
THEME:addAmmoSprite('357', HUD7, 120, 72, 24, 24)
THEME:addAmmoSprite('SMG1', HUD7, 144, 120, 24, 24)
THEME:addAmmoSprite('AR2', HUD7, 0, 96, 24, 24)
THEME:addAmmoSprite('Buckshot', HUD7, 0, 72, 24, 24)
THEME:addAmmoSprite('Grenade', HUD7, 72, 96, 24, 24)
THEME:addAmmoSprite('SniperRound', HUD7, 24, 96, 24, 24)
THEME:addAmmoSprite('AirboatGun', _HUD7, 24, 72, 24, 24)

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  element:set('x', 12)
  element:set('numberOffset', -2)
  element:set('crossOffset', 0)
  element:set('hideDivider', true)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('suitOffset', 0)
  element:set('numberOffset', -1)
  if localPlayer.Armor and localPlayer:Armor() >= 100 then
    element:set('emptySprite', 'suithelmet_empty')
    element:set('fullSprite', 'suithelmet_full')
  end
end)
THEME:addPreDraw('ammo', function(element)
  element:set('dividerOffset', -1)
  element:set('clipOffset', -10)
end)

--[[ Register ]]--
GSRCHUD.THEME_COUNTERSTRIKE = GSRCHUD.theme.register('Counter-Strike', THEME)
