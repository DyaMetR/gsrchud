--[[------------------------------------------------------------------
  Support for upset's Half-Life SWEPs
  https://steamcommunity.com/sharedfiles/filedetails/?id=1360233031
]]--------------------------------------------------------------------

GSRCHUD.weapon.inheritSprite('weapon_hl1_crowbar', 'weapon_crowbar_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_glock', 'weapon_glock_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_357', 'weapon_357_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_mp5', 'weapon_mp5_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_shotgun', 'weapon_shotgun_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_crossbow', 'weapon_crossbow_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_rpg', 'weapon_rpg_hl1')
GSRCHUD.weapon.inheritSprite('weapon_hl1_gauss', 'weapon_gauss')
GSRCHUD.weapon.inheritSprite('weapon_hl1_egon', 'weapon_egon')
GSRCHUD.weapon.inheritSprite('weapon_hl1_hornetgun', 'weapon_hornetgun')
GSRCHUD.weapon.inheritSprite('weapon_hl1_handgrenade', 'weapon_handgrenade')
GSRCHUD.weapon.inheritSprite('weapon_hl1_satchel', 'weapon_satchel')
GSRCHUD.weapon.inheritSprite('weapon_hl1_tripmine', 'weapon_tripmine')
GSRCHUD.weapon.inheritSprite('weapon_hl1_snark', 'weapon_snark')

hook.Add('GSRCHUD_ShouldUseHDWeaponIcon', 'gsrchud_hl1sweps', function(weapon)
    if not weapon.IsHL1Base or not weapon.IsHDEnabled then return end -- NOTE: some weapons were using the IsHL1Base flag without implementing IsHDEnabled for some reason
    return weapon:IsHDEnabled()
end)