--[[------------------------------------------------------------------
  Support for upset's Half-Life: Co-op (and Infected) gamemode
  https://steamcommunity.com/sharedfiles/filedetails/?id=1590755372
  https://steamcommunity.com/sharedfiles/filedetails/?id=2262729696
]]--------------------------------------------------------------------

local COOP_GAMEMODES = { -- Half-Life: Co-op gamemodes
  ['hl1coop'] = true,
  ['hl1coop_infected'] = true
}

if not COOP_GAMEMODES[engine.ActiveGamemode()] then return end

local HOOK_NAME = 'hl1coop'
local cvar_huddisable = CreateClientConVar('hl1_coop_cl_disablehud', 0, true, false, 'Disable HL1 HUD')

--[[ Show itself if we're playing (or spectating) ]]--
GSRCHUD.hook.add('IsEnabled', HOOK_NAME, function()
  local localPlayer = LocalPlayer()
  if not IsValid(localPlayer) then return end
  return not cvar_huddisable:GetBool() and localPlayer:Team() ~= TEAM_UNASSIGNED and (localPlayer:GetObserverMode() == OBS_MODE_NONE or IsValid(localPlayer:GetObserverTarget()))
end)

--[[ Always require suit to draw ]]--
GSRCHUD.hook.add('RequireSuit', HOOK_NAME, function() return true end)

--[[ Only show death screen when not spectating (and while in first person) ]]--
GSRCHUD.hook.add('ShouldUseDeathCam', HOOK_NAME, function()
  local localPlayer = LocalPlayer()
  if not IsValid(localPlayer) then return end
  return GSRCHUD.config.getDeathCam() and not localPlayer:IsSpectator() and localPlayer:Team() ~= TEAM_SPECTATOR and localPlayer:GetObserverMode() == OBS_MODE_NONE and not IsValid(localPlayer:GetObserverTarget()) and not localPlayer:IsChasing() and not localPlayer.thirdpersonEnabled
end)

--[[ Do not play pickup sound ]]--
GSRCHUD.hook.add('PlayPickupSound', HOOK_NAME, function() return false end)

--[[ Do not skip throwables ]]--
GSRCHUD.hook.add('ShouldSkipEmptyWeapons', HOOK_NAME, function()
  if weapon.IsThrowable then return false end
end)

--[[ Set weapon icons ]]--
GSRCHUD.weapon.inheritSprite('weapon_crowbar', 'weapon_crowbar_hl1')
GSRCHUD.weapon.inheritSprite('weapon_glock', 'weapon_glock_hl1')
GSRCHUD.weapon.inheritSprite('weapon_357', 'weapon_357_hl1')
GSRCHUD.weapon.inheritSprite('weapon_mp5', 'weapon_mp5_hl1')
GSRCHUD.weapon.inheritSprite('weapon_shotgun', 'weapon_shotgun_hl1')
GSRCHUD.weapon.inheritSprite('weapon_crossbow', 'weapon_crossbow_hl1')
GSRCHUD.weapon.inheritSprite('weapon_rpg', 'weapon_rpg_hl1')
GSRCHUD.weapon.inheritSprite('weapon_healthkit', 'weapon_medkit')

--[[ Set ammunition icons ]]--
GSRCHUD.ammunition.setSprite('m249', 'ammo_357')
GSRCHUD.ammunition.setSprite('qrocket', 'ammo_RPG_Round')

--[[ Textures for icons ]]--
local HUD1, HUD2, HUD3 = '640hl1coop1', '640hl1coop2', '640hl1coop3'

GSRCHUD.sprite.addTexture(HUD1, surface.GetTextureID('gsrchud/_hl1coop/640hud1'), 256, 256)
GSRCHUD.sprite.addTexture(HUD2, surface.GetTextureID('gsrchud/_hl1coop/640hud2'), 256, 256)
GSRCHUD.sprite.addTexture(HUD3, surface.GetTextureID('gsrchud/_hl1coop/640hud3'), 256, 256)
GSRCHUD.sprite.addTexture(HUD1, surface.GetTextureID('gsrchud/_hl1coop/640hudof1'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)
GSRCHUD.sprite.addTexture(HUD2, surface.GetTextureID('gsrchud/_hl1coop/640hudof2'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)
GSRCHUD.sprite.addTexture(HUD3, surface.GetTextureID('gsrchud/_hl1coop/640hudof3'), 256, 256, GSRCHUD.THEME_OPPOSINGFORCE)

--[[ Medkit ammunition ]]--
GSRCHUD.ammunition.addSprite('medkit', HUD1, 182, 65, 16, 16)

--[[ Bleeding hazard ]]--
GSRCHUD.hazard.addSprite(3, HUD1, 182, 0, 64, 64)

--[[ Weapon icons ]]--
GSRCHUD.weapon.addSprite('weapon_ak47', {
  weapon = {HUD1, 0, 0, 170, 45},
  weapon_s = {HUD2, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_m16', {
  weapon = {HUD1, 0, 45, 170, 45},
  weapon_s = {HUD2, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_sniperrifle', {
  weapon = {HUD1, 0, 90, 170, 45},
  weapon_s = {HUD2, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_m249', {
  weapon = {HUD1, 0, 135, 170, 45},
  weapon_s = {HUD2, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_rocketlauncher', {
  weapon = {HUD3, 0, 0, 170, 45},
  weapon_s = {HUD3, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_doublebarrel', {
  weapon = {HUD3, 0, 45, 170, 45},
  weapon_s = {HUD3, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_minigun', {
  weapon = {HUD1, 0, 180, 170, 45},
  weapon_s = {HUD2, 0, 180, 170, 45}
})
