--[[------------------------------------------------------------------
  Half-Life 1.5: Weapon Edition theme
]]--------------------------------------------------------------------

local BUCKET, IFACE, AMMO = 'hud_bucket', 'hud_interface', 'hud_ammo'
local WEAPON1, WEAPON2, WEAPON3, WEAPON4 = 'hud_weapons1', 'hud_weapons2', 'hud_weapons3', 'hud_weapons4'
local WEAPON5, WEAPON6, WEAPON7, WEAPON8 = 'hud_weapons5', 'hud_weapons6', 'hud_weapons7', 'hud_weapons8'
local WEAPON9, WEAPON10, WEAPON11, WEAPON12 = 'hud_weapons9', 'hud_weapons10', 'hud_weapons11', 'hud_weapons12'
local WEAPON13 = 'hud_weapons13'
local GMOD1, GMOD2, GMOD3, HLS1 = 'hud_gmod1', 'hud_gmod2', 'hud_gmod3', 'hud_hls1'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'
local HEADER_COLOUR = Color(255, 255, 0)

-- create theme
local THEME = GSRCHUD.theme.create()

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/hlwe/hud_bucket'), 256, 128)
THEME:addTexture(IFACE, surface.GetTextureID('gsrchud/hlwe/hud_interface'), 256, 128)
THEME:addTexture(AMMO, surface.GetTextureID('gsrchud/hlwe/hud_ammo'), 256, 128)
THEME:addTexture(WEAPON1, surface.GetTextureID('gsrchud/hlwe/hud_weapons1'), 256, 256)
THEME:addTexture(WEAPON2, surface.GetTextureID('gsrchud/hlwe/hud_weapons2'), 256, 256)
THEME:addTexture(WEAPON3, surface.GetTextureID('gsrchud/hlwe/hud_weapons3'), 256, 256)
THEME:addTexture(WEAPON4, surface.GetTextureID('gsrchud/hlwe/hud_weapons4'), 256, 256)
THEME:addTexture(WEAPON5, surface.GetTextureID('gsrchud/hlwe/hud_weapons5'), 256, 256)
THEME:addTexture(WEAPON6, surface.GetTextureID('gsrchud/hlwe/hud_weapons6'), 256, 256)
THEME:addTexture(WEAPON7, surface.GetTextureID('gsrchud/hlwe/hud_weapons7'), 256, 256)
THEME:addTexture(WEAPON8, surface.GetTextureID('gsrchud/hlwe/hud_weapons8'), 256, 256)
THEME:addTexture(WEAPON9, surface.GetTextureID('gsrchud/hlwe/hud_weapons9'), 256, 256)
THEME:addTexture(WEAPON10, surface.GetTextureID('gsrchud/hlwe/hud_weapons10'), 256, 256)
THEME:addTexture(WEAPON11, surface.GetTextureID('gsrchud/hlwe/hud_weapons11'), 256, 256)
THEME:addTexture(WEAPON12, surface.GetTextureID('gsrchud/hlwe/hud_weapons12'), 256, 256)
THEME:addTexture(WEAPON13, surface.GetTextureID('gsrchud/hlwe/hud_weapons13'), 256, 256)
THEME:addTexture(GMOD1, surface.GetTextureID('gsrchud/hlwe/hud_gmod1'), 256, 256)
THEME:addTexture(GMOD2, surface.GetTextureID('gsrchud/hlwe/hud_gmod2'), 256, 256)
THEME:addTexture(GMOD3, surface.GetTextureID('gsrchud/hlwe/hud_gmod3'), 256, 256)
THEME:addTexture(HLS1, surface.GetTextureID('gsrchud/hlwe/hud_hls1'), 256, 256)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/hlwe/640pain0'), 128, 16)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/hlwe/640pain1'), 128, 128)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/hlwe/640pain2'), 256, 64)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/hlwe/640pain3'), 128, 128)

--[[ Sprites ]]--
THEME:addSprite('bucket', BUCKET, 0, 0, 170, 52)
THEME:addSprite('selection', WEAPON12, 0, 154, 170, 52)

THEME:addSprite('bucket0', BUCKET, 170, 0, 64, 48)
THEME:addSprite('bucket1', WEAPON9, 170, 48, 64, 48)
THEME:addSprite('bucket2', WEAPON9, 170, 96, 64, 48)
THEME:addSprite('bucket3', WEAPON9, 170, 144, 64, 48)
THEME:addSprite('bucket4', GMOD1, 170, 0, 64, 48)
THEME:addSprite('bucket5', GMOD1, 170, 48, 64, 48)
THEME:addSprite('bucket6', GMOD1, 170, 96, 64, 48)

THEME:addSprite('dmg_bullet', WEAPON12, 170, 0, 64, 64)
THEME:addSprite('dmg_blast', WEAPON12, 170, 64, 64, 64)
THEME:addSprite('dmg_energybeam', WEAPON13, 192, 89, 64, 64)
THEME:addSprite('dmg_concussion', WEAPON13, 0, 118, 64, 54)
THEME:addSprite('dmg_energyblast', WEAPON12, 170, 128, 64, 64)
THEME:addSprite('dmg_paralyze', WEAPON13, 0, 172, 58, 62)

THEME:addSprite('pain0', PAIN0, 0, 0, 95, 16)
THEME:addSprite('pain1', PAIN1, 0, 0, 87, 80)
THEME:addSprite('pain2', PAIN2, 0, 0, 223, 48)
THEME:addSprite('pain3', PAIN3, 0, 0, 87, 80)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), IFACE, 24 * i, 0, 20, 20)
end

THEME:addSprite('divider', IFACE, 240, 0, 2, 20)

THEME:addSprite('cross', IFACE, 80, 24, 32, 32)

THEME:addSprite('suit_full', IFACE, 0, 24, 40, 40)
THEME:addSprite('suit_empty', IFACE, 40, 24, 40, 40)

THEME:addSprite('flash_full', WEAPON13, 114, 45, 98, 44)
THEME:addSprite('flash_empty', WEAPON13, 109, 1, 136, 44)
THEME:addSprite('flash_beam', WEAPON13, 245, 1, 11, 44)

--[[ Hazards ]]--
THEME:setHazardSprite(DMG_BULLET, 'dmg_bullet')
THEME:setHazardSprite(DMG_BLAST, 'dmg_blast')
THEME:setHazardSprite(DMG_ENERGYBEAM, 'dmg_energybeam')
THEME:setHazardSprite(DMG_SONIC, 'dmg_concussion')
THEME:setHazardSprite(DMG_PLASMA, 'dmg_energyblast')
THEME:setHazardSprite(DMG_PARALYZE, 'dmg_paralyze')

--[[ Weapons ]]--
THEME:addWeaponSprite('weapon_medkit', { weapon = {WEAPON1, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_crowbar', { weapon = {WEAPON1, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_pistol', { weapon = {GMOD1, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_357', { weapon = {WEAPON2, 0, 153, 170, 52} })
THEME:addWeaponSprite('weapon_smg1', { weapon = {GMOD1, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_ar2', { weapon = {GMOD1, 0, 102, 170, 52} })
THEME:addWeaponSprite('weapon_shotgun', { weapon = {WEAPON3, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_crossbow', { weapon = {GMOD1, 0, 153, 170, 52} })
THEME:addWeaponSprite('weapon_physcannon', { weapon = {GMOD2, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_physgun', { weapon = {GMOD2, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_rpg', { weapon = {GMOD2, 0, 102, 170, 52} })
THEME:addWeaponSprite('weapon_frag', { weapon = {GMOD2, 0, 153, 170, 52} })
THEME:addWeaponSprite('weapon_stunstick', { weapon = {GMOD3, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_slam', { weapon = {GMOD3, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_bugbait', { weapon = {GMOD3, 0, 102, 170, 52} })

--[[ Half-Life: Source Weapons ]]--
THEME:addWeaponSprite('weapon_crowbar_hl1', { weapon = {WEAPON1, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_glock_hl1', { weapon = {WEAPON2, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_357_hl1', { weapon = {WEAPON2, 0, 153, 170, 52} })
THEME:addWeaponSprite('weapon_mp5_hl1', { weapon = {WEAPON3, 0, 204, 170, 52} })
THEME:addWeaponSprite('weapon_shotgun_hl1', { weapon = {WEAPON3, 0, 51, 170, 52} })
THEME:addWeaponSprite('weapon_crossbow_hl1', { weapon = {WEAPON4, 0, 153, 170, 52} })
THEME:addWeaponSprite('weapon_rpg_hl1', { weapon = {WEAPON7, 0, 204, 170, 52} })
THEME:addWeaponSprite('weapon_egon', { weapon = {WEAPON9, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_gauss', { weapon = {WEAPON9, 0, 102, 170, 52} })
THEME:addWeaponSprite('weapon_hornetgun', { weapon = {HLS1, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_handgrenade', { weapon = {WEAPON10, 0, 204, 170, 52} })
THEME:addWeaponSprite('weapon_satchel', { weapon = {WEAPON11, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_tripmine', { weapon = {WEAPON12, 0, 0, 170, 52} })
THEME:addWeaponSprite('weapon_snark', { weapon = {HLS1, 0, 51, 170, 52} })

--[[ Ammunition ]]--
THEME:addAmmoSprite('Pistol', IFACE, 23, 75, 10, 17)
THEME:addAmmoSprite('357', IFACE, 39, 72, 10, 23)
THEME:addAmmoSprite('SMG1_Grenade', IFACE, 48, 72, 24, 24)
THEME:addAmmoSprite('Buckshot', IFACE, 72, 72, 24, 24)
THEME:addAmmoSprite('XBowBolt', IFACE, 96, 72, 24, 24)
THEME:addAmmoSprite('Grenade', IFACE, 48, 96, 24, 24)
THEME:addAmmoSprite('RPG_Round', IFACE, 124, 72, 18, 27)
THEME:addAmmoSprite('slam', IFACE, 120, 96, 24, 24)
THEME:addAmmoSprite('Uranium', IFACE, 144, 96, 24, 24)
THEME:addAmmoSprite('Satchel', AMMO, 238, 97, 18, 28)
THEME:addAmmoSprite('weapon_medkit', IFACE, 24, 96, 24, 24)

--[[ Custom element parameters ]]--
THEME:addPreDraw('health', function(element)
  element:set('y', ScrH() - 10 * GSRCHUD.sprite.scale())
  element:set('crossOffset', 13)
end)
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('y', ScrH() - 10 * GSRCHUD.sprite.scale())
  element:set('suitOffset', 13)
  element:set('numberOffset', -1)
  element:set('colour', localPlayer.Armor and localPlayer:Armor() <= 25)
end)
THEME:addPreDraw('ammo', function(element)
  local scale = GSRCHUD.sprite.scale()
  element:set('x', ScrW() - 18 * scale)
  element:set('y', ScrH() - 10 * scale)
  element:set('iconOffsetX', 0)
  element:set('iconOffsetY', -2)
  element:set('clipOffset', -10)
  element:set('altOffsetY', -5)
end)
THEME:addPreDraw('weapon_selector', function(element)
  element:set('headerColour', HEADER_COLOUR)
  element:set('mode', GSRCHUD.switcher.MODE_NOSPRITE)
end)
THEME:addPreDraw('pickup', function(element)
  element:set('size', 52)
end)
THEME:addPreDraw('damage', function(element)
  element:set('colour', GSRCHUD.sprite.colour(GSRCHUD.localPlayer():Health() <= 25))
end)
THEME:addPreDraw('flashlight', function(element)
  element:set('y', 0)
  element:set('fullSpriteOffsetX', -33)
  element:set('highlightEmptySprite', true)
  element:set('low', .2)
end)

--[[ Register ]]--
GSRCHUD.THEME_HLWE = GSRCHUD.theme.register('Half-Life 1.5: Weapon Edition', THEME)
