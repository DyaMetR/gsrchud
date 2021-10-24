--[[------------------------------------------------------------------
  Support for Olli's Sven-Coop weapons
  https://steamcommunity.com/sharedfiles/filedetails/?id=1882980338
  https://steamcommunity.com/sharedfiles/filedetails/?id=1897316174
]]--------------------------------------------------------------------

local HUDOF1, HUDOF1_DISPLACER, HUDOF2, HUDOF2_DISPLACER = '640hudof1', '640hudof1_displacer', '640hudof2', '640hudof2_displacer'
local HUDOF3, HUDOF4, HUDSC, HUDSC2, WRHUDSC = '640hudof3', '640hudof4', '640hudsc', '640hudsc2', '640wrhudsc'
local M1911, M16, M14, GREASEGUN, TOMMYGUN, DBARREL = 'weapon_m1911', 'weapon_m16a1', 'weapon_m14', 'weapon_greasegun', 'weapon_tommygun', 'weapon_dbarrel'

--[[ Textures ]]--
GSRCHUD.sprite.addTexture(HUDOF1, surface.GetTextureID('gsrchud/svencoop/640hudof1'), 256, 256)
GSRCHUD.sprite.addTexture(HUDOF1_DISPLACER, surface.GetTextureID('gsrchud/svencoop/640hudof1_displacer'), 256, 256)
GSRCHUD.sprite.addTexture(HUDOF2, surface.GetTextureID('gsrchud/svencoop/640hudof2'), 256, 256)
GSRCHUD.sprite.addTexture(HUDOF2_DISPLACER, surface.GetTextureID('gsrchud/svencoop/640hudof2_displacer'), 256, 256)
GSRCHUD.sprite.addTexture(HUDOF3, surface.GetTextureID('gsrchud/svencoop/640hudof3'), 256, 256)
GSRCHUD.sprite.addTexture(HUDOF4, surface.GetTextureID('gsrchud/svencoop/640hudof4'), 256, 256)
GSRCHUD.sprite.addTexture(HUDSC, surface.GetTextureID('gsrchud/svencoop/640hudsc'), 256, 256)
GSRCHUD.sprite.addTexture(HUDSC2, surface.GetTextureID('gsrchud/svencoop/640hudsc2'), 256, 256)
GSRCHUD.sprite.addTexture(WRHUDSC, surface.GetTextureID('gsrchud/svencoop/640wrhudsc'), 256, 256)

-- add They Hunger weapon textures to both default and 320 theme
for _, theme in pairs({GSRCHUD.THEME_HALFLIFE, GSRCHUD.THEME_HALFLIFE320}) do
  GSRCHUD.sprite.addTexture(M1911, surface.GetTextureID('gsrchud/svencoop/weapon_m1911'), 256, 256, theme)
  GSRCHUD.sprite.addTexture(M16, surface.GetTextureID('gsrchud/svencoop/weapon_m16a1'), 256, 256, theme)
  GSRCHUD.sprite.addTexture(GREASEGUN, surface.GetTextureID('gsrchud/svencoop/weapon_greasegun'), 256, 256, theme)
  GSRCHUD.sprite.addTexture(M14, surface.GetTextureID('gsrchud/svencoop/weapon_m14'), 256, 256, theme)
  GSRCHUD.sprite.addTexture(DBARREL, surface.GetTextureID('gsrchud/svencoop/weapon_dbarrel'), 256, 256, theme)
  GSRCHUD.sprite.addTexture(TOMMYGUN, surface.GetTextureID('gsrchud/svencoop/weapon_tommygun'), 256, 256, theme)
end

--[[ Weapons ]]--
GSRCHUD.weapon.inheritSprite('tfa_svencoop_crowbar', 'weapon_crowbar_hl1')
GSRCHUD.weapon.inheritSprite('tfa_svencoop_handgun', 'weapon_glock_hl1')
GSRCHUD.weapon.inheritSprite('tfa_svencoop_revolver', 'weapon_357_hl1')
GSRCHUD.weapon.inheritSprite('tfa_svencoop_shotgun', 'weapon_shotgun_hl1')
GSRCHUD.weapon.inheritSprite('tfa_svencoop_th_umbrella', 'weapon_crowbar_hl1')
GSRCHUD.weapon.inheritSprite('tfa_svencoop_th_revolver', 'weapon_357_hl1')

GSRCHUD.weapon.addSprite('tfa_svencoop_deagle', {
  weapon = {HUDOF1, 0, 90, 170, 45},
  weapon_s = {HUDOF2, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_m16', {
  weapon = {HUDSC2, 0, 0, 170, 45},
  weapon_s = {HUDSC2, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_lmg', {
  weapon = {HUDOF1, 0, 135, 170, 45},
  weapon_s = {HUDOF2, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_sniper', {
  weapon = {HUDOF3, 0, 135, 170, 45},
  weapon_s = {HUDOF4, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_mp5', {
  weapon = {HUDSC2, 0, 92, 170, 45},
  weapon_s = {HUDSC2, 0, 138, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_uzi', {
  weapon = {HUDSC, 0, 0, 170, 45},
  weapon_s = {HUDSC, 0, 46, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_1911', {
  weapon = {M1911, 0, 0, 170, 45},
  weapon_s = {M1911, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_m16', {
  weapon = {M16, 0, 0, 170, 45},
  weapon_s = {M16, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_m14', {
  weapon = {M14, 0, 0, 170, 45},
  weapon_s = {M14, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_greasegun', {
  weapon = {GREASEGUN, 0, 0, 170, 45},
  weapon_s = {GREASEGUN, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_tommygun', {
  weapon = {TOMMYGUN, 0, 0, 170, 45},
  weapon_s = {TOMMYGUN, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('tfa_svencoop_th_dbarrel', {
  weapon = {DBARREL, 0, 0, 170, 45},
  weapon_s = {DBARREL, 0, 45, 170, 45}
})

--[[ 320x200 Weapons ]]--
GSRCHUD.weapon.addSprite('tfa_svencoop_th_1911', {
  weapon = {M1911, 94, 93, 80, 20},
  weapon_s = {M1911, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)

GSRCHUD.weapon.addSprite('tfa_svencoop_th_m16', {
  weapon = {M16, 94, 93, 80, 20},
  weapon_s = {M16, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)

GSRCHUD.weapon.addSprite('tfa_svencoop_th_m14', {
  weapon = {M14, 94, 93, 80, 20},
  weapon_s = {M14, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)

GSRCHUD.weapon.addSprite('tfa_svencoop_th_greasegun', {
  weapon = {GREASEGUN, 94, 93, 80, 20},
  weapon_s = {GREASEGUN, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)

GSRCHUD.weapon.addSprite('tfa_svencoop_th_tommygun', {
  weapon = {TOMMYGUN, 94, 93, 80, 20},
  weapon_s = {TOMMYGUN, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)

GSRCHUD.weapon.addSprite('tfa_svencoop_th_dbarrel', {
  weapon = {DBARREL, 94, 93, 80, 20},
  weapon_s = {DBARREL, 94, 114, 80, 20}
}, false, GSRCHUD.THEME_HALFLIFE320)
