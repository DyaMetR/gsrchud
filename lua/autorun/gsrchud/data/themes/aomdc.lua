--[[------------------------------------------------------------------
  Afraid of Monsters: Director's Cut theme
]]--------------------------------------------------------------------

local BUCKET, HUD1, HUD2, _HUD2, _HUD3, HUD3, HUD4, HUD5, HUD6, HUD7, HUD8, HUD9 = '640bucket', '640hud1', '640hud2', '_640hud2', '_640hud3', '640hud3', '640hud4', '640hud5', '640hud6', '640hud7', '640hud8', '640hud9'
local GMOD1, GMOD2, GMOD3, GMOD4, GMOD5, GMOD6 = '640gmod1', '640gmod2', '640gmod3', '640gmod4', '640gmod5', '640gmod6'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Colour ]]--
THEME:setColour(Color(255, 255, 255))

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/aomdc/640bucket'), 256, 256)
THEME:addTexture(HUD1, surface.GetTextureID('gsrchud/_shared/640hud1'), 256, 256)
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/_shared/640hud2'), 256, 256)
THEME:addTexture(HUD3, surface.GetTextureID('gsrchud/_shared/640hud3'), 256, 256)
THEME:addTexture(HUD4, surface.GetTextureID('gsrchud/_shared/640hud4'), 256, 256)
THEME:addTexture(HUD5, surface.GetTextureID('gsrchud/_shared/640hud5'), 256, 256)
THEME:addTexture(HUD6, surface.GetTextureID('gsrchud/_shared/640hud6'), 256, 256)
THEME:addTexture(_HUD3, surface.GetTextureID('gsrchud/aomdc/640hud3'), 256, 256)
THEME:addTexture(_HUD2, surface.GetTextureID('gsrchud/aomdc/640hud2'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/aomdc/640hud7'), 256, 128)
THEME:addTexture(HUD8, surface.GetTextureID('gsrchud/aomdc/640hud8'), 256, 64)
THEME:addTexture(HUD9, surface.GetTextureID('gsrchud/aomdc/640hud9'), 256, 64)
THEME:addTexture(GMOD1, surface.GetTextureID('gsrchud/_shared/640gmod1'), 256, 256)
THEME:addTexture(GMOD2, surface.GetTextureID('gsrchud/_shared/640gmod2'), 256, 256)
THEME:addTexture(GMOD3, surface.GetTextureID('gsrchud/_shared/640gmod3'), 256, 256)
THEME:addTexture(GMOD4, surface.GetTextureID('gsrchud/_shared/640gmod4'), 256, 256)
THEME:addTexture(GMOD5, surface.GetTextureID('gsrchud/_shared/640gmod5'), 256, 256)
THEME:addTexture(GMOD6, surface.GetTextureID('gsrchud/_shared/640gmod6'), 256, 256)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/aomdc/640pain0'), 128, 64)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/aomdc/640pain1'), 64, 128)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/aomdc/640pain2'), 128, 64)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/aomdc/640pain3'), 64, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket', BUCKET, 0, 0, 170, 45)
THEME:addSprite('selection', _HUD3, 0, 180, 170, 45)

THEME:addSprite('bucket1', HUD7, 168, 72, 20, 20)
THEME:addSprite('bucket2', HUD7, 188, 72, 20, 20)
THEME:addSprite('bucket3', HUD7, 208, 72, 20, 20)
THEME:addSprite('bucket4', HUD7, 168, 92, 20, 20)
THEME:addSprite('bucket5', HUD7, 188, 92, 20, 20)
THEME:addSprite('bucket0', HUD7, 208, 92, 20, 20)
THEME:addSprite('bucket6', HUD7, 228, 72, 20, 20)

THEME:addSprite('dmg_drown', HUD8, 64, 0, 64, 64)
THEME:addSprite('dmg_heat', HUD9, 128, 0, 64, 64)
THEME:addSprite('dmg_shock', HUD8, 192, 0, 64, 64)
THEME:addSprite('dmg_generic', HUD8, 0, 0, 64, 64)

THEME:addSprite('pain0', PAIN0, 0, 0, 124, 44)
THEME:addSprite('pain1', PAIN1, 0, 0, 44, 124)
THEME:addSprite('pain2', PAIN2, 0, 0, 124, 44)
THEME:addSprite('pain3', PAIN3, 0, 0, 44, 124)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), HUD7, 24 * i, 0, 20, 24)
end

THEME:addSprite('divider', HUD7, 240, 0, 2, 24)

THEME:addSprite('cross', HUD7, 80, 24, 32, 32)

THEME:addSprite('suit_full', HUD7, 0, 24, 40, 40)
THEME:addSprite('suit_empty', HUD7, 40, 24, 40, 40)

THEME:addSprite('flash_full', HUD7, 160, 24, 32, 32)
THEME:addSprite('flash_empty', HUD7, 112, 24, 32, 32)

THEME:addSprite('_item_battery', _HUD2, 176, 0, 44, 44)
THEME:addSprite('item_healthkit', _HUD2, 176, 48, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', '_item_battery')

--[[ Hazards ]]--
THEME:setHazardSprite(DMG_POISON, NULL)
THEME:setHazardSprite(DMG_ACID, NULL)
THEME:setHazardSprite(DMG_PLASMA, NULL)
THEME:setHazardSprite(DMG_NERVEGAS, NULL)
THEME:setHazardSprite(DMG_RADIATION, NULL)

--[[ Vanilla Weapons ]]--
THEME:addWeaponSprite('weapon_crowbar', {
  weapon = {GMOD1, 0, 0, 170, 45},
  weapon_s = {GMOD2, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_pistol', {
  weapon = {GMOD1, 0, 45, 170, 45},
  weapon_s = {GMOD2, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_357', {
  weapon = {GMOD1, 0, 90, 170, 45},
  weapon_s = {GMOD2, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_smg1', {
  weapon = {GMOD1, 0, 135, 170, 45},
  weapon_s = {GMOD2, 0, 135, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_shotgun', {
  weapon = {GMOD1, 0, 180, 170, 45},
  weapon_s = {GMOD2, 0, 180, 170, 45}
}, true)

THEME:setWeaponSprite('weapon_annabelle', 'weapon_shotgun', 'weapon_shotgun_s', true)

THEME:addWeaponSprite('weapon_crossbow', {
  weapon = {GMOD3, 0, 0, 170, 45},
  weapon_s = {GMOD4, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_rpg', {
  weapon = {GMOD3, 0, 45, 170, 45},
  weapon_s = {GMOD4, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_physgun', {
  weapon = {GMOD3, 0, 90, 170, 45},
  weapon_s = {GMOD4, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_ar2', {
  weapon = {GMOD3, 0, 135, 170, 45},
  weapon_s = {GMOD4, 0, 135, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_physcannon', {
  weapon = {GMOD3, 0, 180, 170, 45},
  weapon_s = {GMOD4, 0, 180, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_frag', {
  weapon = {GMOD5, 0, 0, 170, 45},
  weapon_s = {GMOD6, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_slam', {
  weapon = {GMOD5, 0, 45, 170, 45},
  weapon_s = {GMOD6, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_bugbait', {
  weapon = {GMOD5, 0, 90, 170, 45},
  weapon_s = {GMOD6, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_stunstick', {
  weapon = {GMOD5, 0, 135, 170, 45},
  weapon_s = {GMOD6, 0, 135, 170, 45}
}, true)

--[[ Half-Life: Source weapons ]]--
THEME:addWeaponSprite('weapon_crowbar_hl1', {
  weapon = {HUD1, 0, 0, 170, 45},
  weapon_s = {HUD4, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_glock_hl1', {
  weapon = {HUD1, 0, 45, 170, 45},
  weapon_s = {HUD4, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_357_hl1', {
  weapon = {HUD1, 0, 90, 170, 45},
  weapon_s = {HUD4, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_mp5_hl1', {
  weapon = {HUD1, 0, 135, 170, 45},
  weapon_s = {HUD4, 0, 135, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_shotgun_hl1', {
  weapon = {HUD1, 0, 180, 170, 45},
  weapon_s = {HUD4, 0, 180, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_crossbow_hl1', {
  weapon = {HUD2, 0, 0, 170, 45},
  weapon_s = {HUD5, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_rpg_hl1', {
  weapon = {HUD2, 0, 45, 170, 45},
  weapon_s = {HUD5, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_gauss', {
  weapon = {HUD2, 0, 90, 170, 45},
  weapon_s = {HUD5, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_egon', {
  weapon = {HUD2, 0, 135, 170, 45},
  weapon_s = {HUD5, 0, 135, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_hornetgun', {
  weapon = {HUD2, 0, 180, 170, 45},
  weapon_s = {HUD5, 0, 180, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_handgrenade', {
  weapon = {HUD3, 0, 0, 170, 45},
  weapon_s = {HUD6, 0, 0, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_satchel', {
  weapon = {HUD3, 0, 45, 170, 45},
  weapon_s = {HUD6, 0, 45, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_tripmine', {
  weapon = {HUD3, 0, 90, 170, 45},
  weapon_s = {HUD6, 0, 90, 170, 45}
}, true)

THEME:addWeaponSprite('weapon_snark', {
  weapon = {HUD3, 0, 135, 170, 45},
  weapon_s = {HUD6, 0, 135, 170, 45}
}, true)

--[[ Flashlight switch ]]--
local function drawSwitch()
  local localPlayer = GSRCHUD.localPlayer()
  local scale = GSRCHUD.sprite.scale()
  local sprite = 'flash_full'
  if localPlayer:FlashlightIsOn() then sprite = 'flash_empty' end
  GSRCHUD.sprite.draw(sprite, ScrW() - 16 * scale, 17 * scale, GSRCHUD.sprite.userColour(GSRCHUD.config.getFlashlightColour()), TEXT_ALIGN_RIGHT, nil, nil, (GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA) * 255)
end

--[[ Custom element parameters ]]--
local gmod_suit = GetConVar('gmod_suit')

THEME:addPreDraw('health', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  local flashlight = GSRCHUD.element.import('flashlight')
  element:set('hideDivider', not GSRCHUD.config.getFlashlight() or not localPlayer.Armor or not flashlight.visible or localPlayer:Armor() <= 0)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  local scale = GSRCHUD.sprite.scale()
  local flashlight = GSRCHUD.element.import('flashlight')

  -- if auxiliary power is disabled, move the indicator where the flashlight would be
  if not GSRCHUD.config.getFlashlight() or not flashlight.visible then
    -- highlight if armour is very low
    if localPlayer.Armor and localPlayer:Armor() <= 15 then
      GSRCHUD.number.get(GSRCHUD.NUMBER_SUIT).highlight = 1
    end
    element:set('colour', localPlayer.Armor and localPlayer:Armor() <= 25)
    element:set('x', ScrW() - 120 * scale)
    element:set('y', 84 * scale)
    drawSwitch()
  else
    element:set('hide', not localPlayer.Armor or localPlayer:Armor() <= 0)
  end
end)
THEME:addPreDraw('flashlight', function(element)
  local scale = GSRCHUD.sprite.scale()
  local localPlayer = GSRCHUD.localPlayer()
  local used = localPlayer:KeyDown(IN_SPEED) or localPlayer:WaterLevel() >= 3 or localPlayer:FlashlightIsOn()
  local hide = not GetConVar('gmod_suit'):GetBool()

  -- call hooks to allow third party addons customize it
  local amount, _used, _hide = hook.Run('GSRCHUDFlashlight')
  amount = amount or localPlayer:GetSuitPower() * .01
  if _hide ~= nil then hide = _hide end

  -- export visibility
  GSRCHUD.element.get('flashlight'):export('visible', not hide)

  -- do not draw if prompted to do so
  if hide then return end

  -- highlight when in use
  local highlight = 0
  if (_used == nil and used) or _used then highlight = 1 end

  -- draw
  local x, y = ScrW() - 19 * scale, 54 * scale
  local low = amount <= .2
  low = GSRCHUD.sprite.userColour(GSRCHUD.config.getFlashlightColour(), low)
  GSRCHUD.number.render(math.max(math.Round(amount * 100), 0), x, y + 6 * scale, nil, highlight, low)
  GSRCHUD.sprite.drawTwin('suit_full', x - 100 * scale, y, highlight, low)
  drawSwitch()

  return true -- do not draw original flashlight
end)

--[[ Register ]]--
GSRCHUD.THEME_AFRAIDOFMONSTERS = GSRCHUD.theme.register('Afraid of Monster\'s: Director\'s cut', THEME)
