--[[------------------------------------------------------------------
  320x200 version of the Half-Life theme
]]--------------------------------------------------------------------

local BUCKET, HUD1, HUD2, HUD4 = '320bucket', '320hud1', '320hud2', '320hud4'
local GMOD1, TFCHUD6 = '320gmod1', 'tfchud6'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/default/320bucket'), 128, 32)
THEME:addTexture(HUD1, surface.GetTextureID('gsrchud/default/320hud1'), 256, 256)
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/default/320hud2'), 128, 128)
THEME:addTexture(HUD4, surface.GetTextureID('gsrchud/default/320hud4'), 256, 32)
THEME:addTexture(GMOD1, surface.GetTextureID('gsrchud/default/320gmod1'), 256, 256)
THEME:addTexture(TFCHUD6, surface.GetTextureID('gsrchud/default/tfchud6'), 256, 256)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/default/320pain0'), 64, 32)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/default/320pain1'), 32, 64)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/default/320pain2'), 64, 32)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/default/320pain3'), 32, 64)

--[[ Sprites ]]--
THEME:addSprite('bucket', BUCKET, 0, 0, 80, 20)
THEME:addSprite('selection', HUD1, 160, 160, 80, 20)

THEME:addSprite('bucket1', HUD2, 108, 16, 12, 12)
THEME:addSprite('bucket2', HUD2, 108, 28, 12, 12)
THEME:addSprite('bucket3', HUD2, 108, 40, 12, 12)
THEME:addSprite('bucket4', HUD2, 108, 52, 12, 12)
THEME:addSprite('bucket5', HUD2, 108, 63, 12, 12)
THEME:addSprite('bucket0', HUD2, 108, 75, 12, 12)
THEME:addSprite('bucket6', HUD2, 108, 87, 12, 12)

THEME:addSprite('dmg_bio', HUD4, 0, 0, 32, 32)
THEME:addSprite('dmg_poison', HUD4, 0, 0, 32, 32)
THEME:addSprite('dmg_chem', HUD4, 32, 0, 32, 32)
THEME:addSprite('dmg_cold', HUD4, 64, 0, 32, 32)
THEME:addSprite('dmg_drown', HUD4, 96, 0, 32, 32)
THEME:addSprite('dmg_heat', HUD4, 128, 0, 32, 32)
THEME:addSprite('dmg_gas', HUD4, 160, 0, 32, 32)
THEME:addSprite('dmg_rad', HUD4, 192, 0, 32, 32)
THEME:addSprite('dmg_shock', HUD4, 224, 0, 32, 32)

THEME:addSprite('pain0', PAIN0, 0, 0, 60, 20)
THEME:addSprite('pain1', PAIN1, 0, 0, 20, 60)
THEME:addSprite('pain2', PAIN2, 0, 0, 60, 20)
THEME:addSprite('pain3', PAIN3, 0, 0, 20, 60)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), HUD2, 12 * i, 0, 12, 16)
end

THEME:addSprite('divider', HUD2, 120, 0, 1, 16)

THEME:addSprite('cross', HUD2, 0, 72, 16, 16)

THEME:addSprite('suit_full', HUD2, 0, 52, 20, 20)
THEME:addSprite('suit_empty', HUD2, 20, 52, 20, 20)

THEME:addSprite('flash_full', HUD2, 16, 72, 18, 16)
THEME:addSprite('flash_empty', HUD2, 34, 72, 18, 16)
THEME:addSprite('flash_beam', HUD2, 52, 72, 6, 16)

THEME:addSprite('item_battery', HUD2, 48, 52, 20, 20)
THEME:addSprite('item_healthkit', HUD2, 68, 52, 20, 20)
THEME:addSprite('item_longjump', HUD2, 88, 52, 20, 20)

--[[ Vanilla Weapons ]]--
THEME:addWeaponSprite('weapon_crowbar', {
  weapon = {GMOD1, 0, 0, 80, 20},
  weapon_s = {GMOD1, 0, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_pistol', {
  weapon = {GMOD1, 0, 40, 80, 20},
  weapon_s = {GMOD1, 0, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_357', {
  weapon = {GMOD1, 0, 80, 80, 20},
  weapon_s = {GMOD1, 0, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_smg1', {
  weapon = {GMOD1, 0, 120, 80, 20},
  weapon_s = {GMOD1, 0, 140, 80, 20}
})

THEME:addWeaponSprite('weapon_shotgun', {
  weapon = {GMOD1, 0, 160, 80, 20},
  weapon_s = {GMOD1, 0, 180, 80, 20}
})

THEME:addWeaponSprite('weapon_crossbow', {
  weapon = {GMOD1, 80, 0, 80, 20},
  weapon_s = {GMOD1, 80, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_rpg', {
  weapon = {GMOD1, 80, 40, 80, 20},
  weapon_s = {GMOD1, 80, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_physgun', {
  weapon = {GMOD1, 80, 80, 80, 20},
  weapon_s = {GMOD1, 80, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_ar2', {
  weapon = {GMOD1, 80, 120, 80, 20},
  weapon_s = {GMOD1, 80, 140, 80, 20}
})

THEME:addWeaponSprite('weapon_physcannon', {
  weapon = {GMOD1, 80, 160, 80, 20},
  weapon_s = {GMOD1, 80, 180, 80, 20}
})

THEME:addWeaponSprite('weapon_frag', {
  weapon = {GMOD1, 160, 0, 80, 20},
  weapon_s = {GMOD1, 160, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_slam', {
  weapon = {GMOD1, 160, 40, 80, 20},
  weapon_s = {GMOD1, 160, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_bugbait', {
  weapon = {GMOD1, 160, 80, 80, 20},
  weapon_s = {GMOD1, 160, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_stunstick', {
  weapon = {GMOD1, 160, 120, 80, 20},
  weapon_s = {GMOD1, 160, 140, 80, 20}
})

THEME:addWeaponSprite('weapon_medkit', {
  weapon = {TFCHUD6, 176, 40, 80, 20},
  weapon_s = {TFCHUD6, 176, 100, 80, 20}
})

--[[ Half-Life: Source weapons ]]--
THEME:addWeaponSprite('weapon_crowbar_hl1', {
  weapon = {HUD1, 0, 0, 80, 20},
  weapon_s = {HUD1, 0, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_glock_hl1', {
  weapon = {HUD1, 0, 40, 80, 20},
  weapon_s = {HUD1, 0, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_357_hl1', {
  weapon = {HUD1, 0, 80, 80, 20},
  weapon_s = {HUD1, 0, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_mp5_hl1', {
  weapon = {HUD1, 0, 120, 80, 20},
  weapon_s = {HUD1, 0, 140, 80, 20}
})

THEME:addWeaponSprite('weapon_shotgun_hl1', {
  weapon = {HUD1, 0, 160, 80, 20},
  weapon_s = {HUD1, 0, 180, 80, 20}
})

THEME:addWeaponSprite('weapon_crossbow_hl1', {
  weapon = {HUD1, 80, 0, 80, 20},
  weapon_s = {HUD1, 80, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_rpg_hl1', {
  weapon = {HUD1, 80, 40, 80, 20},
  weapon_s = {HUD1, 80, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_gauss', {
  weapon = {HUD1, 80, 80, 80, 20},
  weapon_s = {HUD1, 80, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_egon', {
  weapon = {HUD1, 80, 120, 80, 20},
  weapon_s = {HUD1, 80, 140, 80, 20}
})

THEME:addWeaponSprite('weapon_hornetgun', {
  weapon = {HUD1, 80, 160, 80, 20},
  weapon_s = {HUD1, 80, 180, 80, 20}
})

THEME:addWeaponSprite('weapon_handgrenade', {
  weapon = {HUD1, 160, 0, 80, 20},
  weapon_s = {HUD1, 160, 20, 80, 20}
})

THEME:addWeaponSprite('weapon_satchel', {
  weapon = {HUD1, 160, 40, 80, 20},
  weapon_s = {HUD1, 160, 60, 80, 20}
})

THEME:addWeaponSprite('weapon_tripmine', {
  weapon = {HUD1, 160, 80, 80, 20},
  weapon_s = {HUD1, 160, 100, 80, 20}
})

THEME:addWeaponSprite('weapon_snark', {
  weapon = {HUD1, 160, 120, 80, 20},
  weapon_s = {HUD1, 160, 140, 80, 20}
})

--[[ Ammunition ]]--
THEME:addAmmoSprite('Pistol', HUD2, 0, 16, 18, 18)
THEME:addAmmoSprite('357', HUD2, 18, 16, 18, 18)
THEME:addAmmoSprite('SMG1_Grenade', HUD2, 36, 16, 18, 18)
THEME:addAmmoSprite('AR2AltFire', HUD2, 0, 34, 18, 18)
THEME:addAmmoSprite('Buckshot', HUD2, 54, 16, 18, 18)
THEME:addAmmoSprite('XBowBolt', HUD2, 72, 16, 18, 18)
THEME:addAmmoSprite('Grenade', HUD2, 36, 34, 18, 18)
THEME:addAmmoSprite('RPG_Round', HUD2, 90, 16, 18, 18)
THEME:addAmmoSprite('slam', HUD2, 72, 34, 18, 18)
THEME:addAmmoSprite('Satchel', HUD2, 54, 34, 18, 18)
THEME:addAmmoSprite('Hornet', HUD2, 16, 36, 18, 18)
THEME:addAmmoSprite('Snark', HUD2, 90, 34, 18, 18)

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  element:set('x', 8)
  element:set('y', ScrH() - 8 * GSRCHUD.sprite.scale())
  element:set('numberOffset', -2)
  element:set('crossOffset', 0)
end)
THEME:addPreDraw('suit', function(element)
  local health = GSRCHUD.element.import('health')
  element:set('x', 7 + (health.width or 0))
  element:set('y', ScrH() - 8 * GSRCHUD.sprite.scale())
  element:set('suitOffset', 2)
end)
THEME:addPreDraw('ammo', function(element)
  element:set('x', ScrW() - 11)
  element:set('y', ScrH() - 8 * GSRCHUD.sprite.scale())
  element:set('iconOffsetX', 0)
  element:set('iconOffsetY', -1)
  element:set('clipOffset', -6)
  element:set('altOffsetY', -5)
end)
THEME:addPreDraw('weapon_selector', function(element)
  element:set('margin', 2)
end)
THEME:addPreDraw('pickup', function(element)
  element:set('y', ScrH() - 48 * GSRCHUD.sprite.scale())
end)
THEME:addPreDraw('hazards', function(element)
  local scale = GSRCHUD.sprite.scale()
  element:set('x', 4 * scale)
  element:set('y', ScrH() - 32 * scale)
end)

--[[ Register ]]--
GSRCHUD.THEME_HALFLIFE320 = GSRCHUD.theme.register('Half-Life (320x200)', THEME)
