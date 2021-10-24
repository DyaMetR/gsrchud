--[[------------------------------------------------------------------
  Support for upset's Half-Life: Absolute Zero SWEPs
  https://steamcommunity.com/sharedfiles/filedetails/?id=2622152364
]]--------------------------------------------------------------------

local HUD2, HUD5, HUD10, HLWE = '640hlaz2', '640hlaz5', '640hlaz10', '640hlwe'
local GLOCK, SILENCED, SELECTED = 'weapon_glock_hl1', 'weapon_hlaz_glock_silenced', '_s'

--[[ Default theme ]]--

-- textures
GSRCHUD.sprite.addTexture(HUD2, surface.GetTextureID('gsrchud/_hlaz/640hud2'), 256, 256)
GSRCHUD.sprite.addTexture(HUD5, surface.GetTextureID('gsrchud/_hlaz/640hud5'), 256, 256)
GSRCHUD.sprite.addTexture(HUD10, surface.GetTextureID('gsrchud/_hlaz/640hud10'), 256, 256)

-- inherit
GSRCHUD.weapon.inheritSprite('weapon_hlaz_crowbar', 'weapon_crowbar_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_357', 'weapon_357_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_mp5', 'weapon_mp5_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_shotgun', 'weapon_shotgun_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_crossbow', 'weapon_crossbow_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_gauss', 'weapon_gauss')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_handgrenade', 'weapon_handgrenade')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_satchel', 'weapon_satchel')
GSRCHUD.weapon.inheritSprite('weapon_hlaz_tripmine', 'weapon_tripmine')

-- new sprites
GSRCHUD.sprite.add('weapon_hlaz_glock_silenced', HUD10, 0, 0, 170, 45)
GSRCHUD.sprite.add('weapon_hlaz_glock_silenced_s', HUD10, 0, 45, 170, 45)

-- new weapon icons
GSRCHUD.weapon.addSprite('weapon_hlaz_rpg', {
  weapon = {HUD2, 0, 45, 170, 45},
  weapon_s = {HUD5, 0, 45, 170, 45}
})

GSRCHUD.weapon.addDynamicIcon('weapon_hlaz_glock', function(x, y, weapon, selected, colour, scale, alpha, theme)
  local sprite = GLOCK
  if weapon:GetSilenced() then sprite = SILENCED end
  if selected then sprite = sprite .. SELECTED end
  GSRCHUD.sprite.draw(sprite, x, y, colour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, scale, alpha, theme)
end)

GSRCHUD.weapon.addSprite('weapon_hlaz_chumtoad', {
  weapon = {HUD10, 0, 90, 170, 45},
  weapon_s = {HUD10, 0, 135, 170, 45}
})

--[[ Half-Life: Opposing Force theme ]]--

-- textures
GSRCHUD.sprite.addTexture(HUD2, surface.GetTextureID('gsrchud/_hlaz/640hudof2'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)
GSRCHUD.sprite.addTexture(HUD5, surface.GetTextureID('gsrchud/_hlaz/640hudof5'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)
GSRCHUD.sprite.addTexture(HUD10, surface.GetTextureID('gsrchud/_hlaz/640hudof10'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)

--[[ Half-Life: Weapon Edition theme ]]--

-- textures
GSRCHUD.sprite.addTexture(HLWE, surface.GetTextureID('gsrchud/_hlaz/640hlwe'), 256, 128, GSRCHUD.THEME_HLWE)

-- inherit
GSRCHUD.weapon.inheritSprite('weapon_hlaz_rpg', 'weapon_rpg_hl1', GSRCHUD.THEME_HLWE)

-- new sprite
GSRCHUD.sprite.add('weapon_hlaz_glock_silenced', HLWE, 0, 0, 170, 52, GSRCHUD.THEME_HLWE)

-- new weapon icons
GSRCHUD.weapon.addSprite('weapon_hlaz_chumtoad', { weapon = {HLWE, 0, 51, 170, 52} }, false, GSRCHUD.THEME_HLWE)
