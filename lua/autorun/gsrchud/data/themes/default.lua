--[[------------------------------------------------------------------
  !!! WARNING !!
  This is the default theme, the one the HUD falls back to if anything
  goes wrong.

  DO NOT DELETE IT
]]--------------------------------------------------------------------

local BUCKET, HUD1, HUD2, HUD3, HUD4, HUD5, HUD6, HUD7, HUD8, HUD9 = '640bucket', '640hud1', '640hud2', '640hud3', '640hud4', '640hud5', '640hud6', '640hud7', '640hud8', '640hud9'
local GMOD1, GMOD2, GMOD3, GMOD4, GMOD5, GMOD6 = '640gmod1', '640gmod2', '640gmod3', '640gmod4', '640gmod5', '640gmod6'
local TFCHUD5, TFCHUD6 = 'tfchud5', 'tfchud6'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/default/640bucket'), 256, 64)
THEME:addTexture(HUD1, surface.GetTextureID('gsrchud/default/640hud1'), 256, 256)
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/default/640hud2'), 256, 256)
THEME:addTexture(HUD3, surface.GetTextureID('gsrchud/default/640hud3'), 256, 256)
THEME:addTexture(HUD4, surface.GetTextureID('gsrchud/default/640hud4'), 256, 256)
THEME:addTexture(HUD5, surface.GetTextureID('gsrchud/default/640hud5'), 256, 256)
THEME:addTexture(HUD6, surface.GetTextureID('gsrchud/default/640hud6'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/default/640hud7'), 256, 128)
THEME:addTexture(HUD8, surface.GetTextureID('gsrchud/default/640hud8'), 256, 64)
THEME:addTexture(HUD9, surface.GetTextureID('gsrchud/default/640hud9'), 256, 64)
THEME:addTexture(GMOD1, surface.GetTextureID('gsrchud/default/640gmod1'), 256, 256)
THEME:addTexture(GMOD2, surface.GetTextureID('gsrchud/default/640gmod2'), 256, 256)
THEME:addTexture(GMOD3, surface.GetTextureID('gsrchud/default/640gmod3'), 256, 256)
THEME:addTexture(GMOD4, surface.GetTextureID('gsrchud/default/640gmod4'), 256, 256)
THEME:addTexture(GMOD5, surface.GetTextureID('gsrchud/default/640gmod5'), 256, 256)
THEME:addTexture(GMOD6, surface.GetTextureID('gsrchud/default/640gmod6'), 256, 256)
THEME:addTexture(TFCHUD5, surface.GetTextureID('gsrchud/default/tfchud5'), 256, 256)
THEME:addTexture(TFCHUD6, surface.GetTextureID('gsrchud/default/tfchud6'), 256, 256)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/default/640pain0'), 128, 64)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/default/640pain1'), 64, 128)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/default/640pain2'), 128, 64)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/default/640pain3'), 64, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket', BUCKET, 0, 0, 170, 45)
THEME:addSprite('selection', HUD3, 0, 180, 170, 45)

THEME:addSprite('bucket1', HUD7, 168, 72, 20, 20)
THEME:addSprite('bucket2', HUD7, 188, 72, 20, 20)
THEME:addSprite('bucket3', HUD7, 208, 72, 20, 20)
THEME:addSprite('bucket4', HUD7, 168, 92, 20, 20)
THEME:addSprite('bucket5', HUD7, 188, 92, 20, 20)
THEME:addSprite('bucket0', HUD7, 208, 92, 20, 20)
THEME:addSprite('bucket6', HUD7, 228, 72, 20, 20)

THEME:addSprite('dmg_bio', HUD8, 128, 0, 64, 64)
THEME:addSprite('dmg_poison', HUD8, 128, 0, 64, 64)
THEME:addSprite('dmg_chem', HUD8, 0, 0, 64, 64)
THEME:addSprite('dmg_cold', HUD9, 64, 0, 64, 64)
THEME:addSprite('dmg_drown', HUD8, 64, 0, 64, 64)
THEME:addSprite('dmg_heat', HUD9, 128, 0, 64, 64)
THEME:addSprite('dmg_gas', HUD9, 0, 0, 64, 64)
THEME:addSprite('dmg_rad', HUD9, 192, 0, 64, 64)
THEME:addSprite('dmg_shock', HUD8, 192, 0, 64, 64)

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
THEME:addSprite('flash_beam', HUD7, 144, 24, 16, 32)

THEME:addSprite('item_battery', HUD2, 176, 0, 44, 44)
THEME:addSprite('item_healthkit', HUD2, 176, 48, 44, 44)
THEME:addSprite('item_longjump', HUD2, 176, 96, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', 'item_battery')
THEME:setItemSprite('item_healthkit', 'item_healthkit')
THEME:setItemSprite('item_longjump', 'item_longjump')

--[[ Hazards ]]--
THEME:setHazardSprite(DMG_POISON, 'dmg_poison')
THEME:setHazardSprite(DMG_ACID, 'dmg_chem')
THEME:setHazardSprite(DMG_PLASMA, 'dmg_chem')
THEME:setHazardSprite(DMG_DROWN, 'dmg_drown')
THEME:setHazardSprite(DMG_BURN, 'dmg_heat')
THEME:setHazardSprite(DMG_SLOWBURN, 'dmg_heat')
THEME:setHazardSprite(DMG_NERVEGAS, 'dmg_gas')
THEME:setHazardSprite(DMG_RADIATION, 'dmg_rad')
THEME:setHazardSprite(DMG_SHOCK, 'dmg_shock')
THEME:setHazardSprite(DMG_VEHICLE, 'dmg_cold')

--[[ Vanilla weapons ]]--
THEME:addWeaponSprite('weapon_crowbar', {
  weapon = {GMOD1, 0, 0, 170, 45},
  weapon_s = {GMOD2, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_pistol', {
  weapon = {GMOD1, 0, 45, 170, 45},
  weapon_s = {GMOD2, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_357', {
  weapon = {GMOD1, 0, 90, 170, 45},
  weapon_s = {GMOD2, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_smg1', {
  weapon = {GMOD1, 0, 135, 170, 45},
  weapon_s = {GMOD2, 0, 135, 170, 45}
})

THEME:addWeaponSprite('weapon_shotgun', {
  weapon = {GMOD1, 0, 180, 170, 45},
  weapon_s = {GMOD2, 0, 180, 170, 45}
})

THEME:setWeaponSprite('weapon_annabelle', 'weapon_shotgun', 'weapon_shotgun_s')

THEME:addWeaponSprite('weapon_crossbow', {
  weapon = {GMOD3, 0, 0, 170, 45},
  weapon_s = {GMOD4, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_rpg', {
  weapon = {GMOD3, 0, 45, 170, 45},
  weapon_s = {GMOD4, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_physgun', {
  weapon = {GMOD3, 0, 90, 170, 45},
  weapon_s = {GMOD4, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_ar2', {
  weapon = {GMOD3, 0, 135, 170, 45},
  weapon_s = {GMOD4, 0, 135, 170, 45}
})

THEME:addWeaponSprite('weapon_physcannon', {
  weapon = {GMOD3, 0, 180, 170, 45},
  weapon_s = {GMOD4, 0, 180, 170, 45}
})

THEME:addWeaponSprite('weapon_frag', {
  weapon = {GMOD5, 0, 0, 170, 45},
  weapon_s = {GMOD6, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_slam', {
  weapon = {GMOD5, 0, 45, 170, 45},
  weapon_s = {GMOD6, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_bugbait', {
  weapon = {GMOD5, 0, 90, 170, 45},
  weapon_s = {GMOD6, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_stunstick', {
  weapon = {GMOD5, 0, 135, 170, 45},
  weapon_s = {GMOD6, 0, 135, 170, 45}
})

THEME:addWeaponSprite('weapon_medkit', {
  weapon = {TFCHUD6, 0, 90, 170, 45},
  weapon_s = {TFCHUD5, 0, 180, 170, 45}
})

--[[ Half-Life: Source weapons ]]--
THEME:addWeaponSprite('weapon_crowbar_hl1', {
  weapon = {HUD1, 0, 0, 170, 45},
  weapon_s = {HUD4, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_glock_hl1', {
  weapon = {HUD1, 0, 45, 170, 45},
  weapon_s = {HUD4, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_357_hl1', {
  weapon = {HUD1, 0, 90, 170, 45},
  weapon_s = {HUD4, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_mp5_hl1', {
  weapon = {HUD1, 0, 135, 170, 45},
  weapon_s = {HUD4, 0, 135, 170, 45}
})

THEME:addWeaponSprite('weapon_shotgun_hl1', {
  weapon = {HUD1, 0, 180, 170, 45},
  weapon_s = {HUD4, 0, 180, 170, 45}
})

THEME:addWeaponSprite('weapon_crossbow_hl1', {
  weapon = {HUD2, 0, 0, 170, 45},
  weapon_s = {HUD5, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_rpg_hl1', {
  weapon = {HUD2, 0, 45, 170, 45},
  weapon_s = {HUD5, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_gauss', {
  weapon = {HUD2, 0, 90, 170, 45},
  weapon_s = {HUD5, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_egon', {
  weapon = {HUD2, 0, 135, 170, 45},
  weapon_s = {HUD5, 0, 135, 170, 45}
})

THEME:addWeaponSprite('weapon_hornetgun', {
  weapon = {HUD2, 0, 180, 170, 45},
  weapon_s = {HUD5, 0, 180, 170, 45}
})

THEME:addWeaponSprite('weapon_handgrenade', {
  weapon = {HUD3, 0, 0, 170, 45},
  weapon_s = {HUD6, 0, 0, 170, 45}
})

THEME:addWeaponSprite('weapon_satchel', {
  weapon = {HUD3, 0, 45, 170, 45},
  weapon_s = {HUD6, 0, 45, 170, 45}
})

THEME:addWeaponSprite('weapon_tripmine', {
  weapon = {HUD3, 0, 90, 170, 45},
  weapon_s = {HUD6, 0, 90, 170, 45}
})

THEME:addWeaponSprite('weapon_snark', {
  weapon = {HUD3, 0, 135, 170, 45},
  weapon_s = {HUD6, 0, 135, 170, 45}
})

--[[ Ammunition ]]--
THEME:addAmmoSprite('Pistol', HUD7, 0, 72, 24, 24)
THEME:addAmmoSprite('357', HUD7, 24, 72, 24, 24)
THEME:addAmmoSprite('SMG1_Grenade', HUD7, 48, 72, 24, 24)
THEME:addAmmoSprite('AR2AltFire', HUD7, 0, 96, 24, 24)
THEME:addAmmoSprite('Buckshot', HUD7, 72, 72, 24, 24)
THEME:addAmmoSprite('XBowBolt', HUD7, 96, 72, 24, 24)
THEME:addAmmoSprite('Grenade', HUD7, 48, 96, 24, 24)
THEME:addAmmoSprite('RPG_Round', HUD7, 120, 72, 24, 24)
THEME:addAmmoSprite('slam', HUD7, 120, 96, 24, 24)
THEME:addAmmoSprite('Satchel', HUD7, 72, 96, 24, 24)
THEME:addAmmoSprite('Hornet', HUD7, 24, 96, 24, 24)
THEME:addAmmoSprite('Snark', HUD7, 96, 96, 24, 24)
THEME:setAmmoSprite('AirboatGun', 'ammo_357')
THEME:setAmmoSprite('SMG1', 'ammo_Pistol')
THEME:setAmmoSprite('AR2', 'ammo_357')
THEME:setAmmoSprite('SniperRound', 'ammo_357')
THEME:setAmmoSprite('SniperPenetratedRound', 'ammo_357')
THEME:setAmmoSprite('9mmRound', 'ammo_Pistol')
THEME:setAmmoSprite('357Round', 'ammo_357')
THEME:setAmmoSprite('BuckshotHL1', 'ammo_Buckshot')
THEME:setAmmoSprite('XBowBoltHL1', 'ammo_XBowBolt')
THEME:setAmmoSprite('MP5_Grenade', 'ammo_SMG1_Grenade')
THEME:setAmmoSprite('RPG_Rocket', 'ammo_RPG_Round')
THEME:setAmmoSprite('Uranium', 'ammo_AR2AltFire')
THEME:setAmmoSprite('GrenadeHL1', 'ammo_Grenade')
THEME:setAmmoSprite('TripMine', 'ammo_slam')
THEME:setAmmoSprite('12mmRound', 'ammo_357')
THEME:setAmmoSprite('weapon_medkit', 'item_healthkit', 'item_healthkit')

--[[ Register as default ]]--
GSRCHUD.THEME_HALFLIFE = GSRCHUD.theme.registerDefault('Half-Life', THEME)
