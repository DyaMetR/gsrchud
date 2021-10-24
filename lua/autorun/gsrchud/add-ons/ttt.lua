--[[------------------------------------------------------------------
  Trouble in Terrorist Town support
]]--------------------------------------------------------------------

if engine.ActiveGamemode() ~= 'terrortown' then return end

local HOOK = 'ttt'

-- colours for each role
local COLOURS = {
  Color(66, 255, 50),
  Color(255, 99, 33),
  Color(100, 180, 255)
}

--[[ Hide TTT HUD ]]--
local hide = { ['TTTInfoPanel'] = true, ['TTTPickupHistory'] = true }
hook.Add('HUDShouldDraw', GSRCHUD.hookname .. HOOK, function(element)
  if hide[element] then return false end
end)

--[[ Change theme based on current team ]]--
GSRCHUD.hook.add('GetTheme', HOOK, function() return GSRCHUD.THEME_CSDELETEDSCENES end)

--[[ Change colour based on current team ]]--
GSRCHUD.hook.add('GetColour', HOOK, function()
  local localPlayer = GSRCHUD.localPlayer()
  if not localPlayer.GetRole or not localPlayer.Team or localPlayer:Team() == TEAM_SPEC or GAMEMODE.round_state <= 2 then return GSRCHUD.theme.default().colour end
  return COLOURS[localPlayer:GetRole() + 1]
end)

--[[ Force maximum opacity ]]--
GSRCHUD.hook.add('GetAlpha', HOOK, function() return 255 end)

--[[ Suit battery is unused ]]--
GSRCHUD.hook.add('ShouldDraw', HOOK, function(element)
  local localPlayer = GSRCHUD.localPlayer()
  if not localPlayer.Team then return end
  if localPlayer:Team() == TEAM_SPEC or element == 'suit' then return false end
end)

--[[ Disallow death cam on spectator team ]]--
GSRCHUD.hook.add('ShouldUseDeathCam', HOOK, function()
  local localPlayer = GSRCHUD.localPlayer()
  if not localPlayer.Team then return end
  return localPlayer:Team() ~= TEAM_SPEC
end)

--[[ Disallow status spectating ]]--
GSRCHUD.hook.add('BlockStatusSpectate', HOOK, function() return true end)

--[[ Always allow switching to empty weapons ]]--
GSRCHUD.hook.add('ShouldSkipEmptyWeapons', HOOK, function() return false end)

--[[ Rearrange weapons' slots ]]--
GSRCHUD.hook.add('GetWeaponSlot', HOOK, function(weapon)
  -- knife goes into slot 1
  if weapon:GetClass() == 'weapon_ttt_knife' then return 0 end

  -- silenced pistol goes into slot 2
  if weapon:GetClass() == 'weapon_ttt_sipistol' then return 1 end

  -- stun gun goes into slot 3
  if weapon:GetClass() == 'weapon_ttt_stungun' then return 2 end

  -- all equipment goes to slot 5
  if weapon:GetSlot() > 5 then return 4 end
end)

--[[ Add icons for default weapons ]]--
local HUD1, HUD2, HUD3, HUD4, HUD5 = '640ttt1', '640ttt2', '640ttt3', '640ttt4', '640ttt5'
local HUD6, HUD7, HUD8, HUD9 = '640ttt6', '640ttt7', '640ttt8', '640ttt9'
local HUD10, HUD11, HUD12, HUD13 = '640ttt10', '640ttt11', '640ttt12', '640ttt13'

-- add textures
GSRCHUD.sprite.addTexture(HUD1, surface.GetTextureID('gsrchud/_ttt/640hud1'), 256, 256)
GSRCHUD.sprite.addTexture(HUD2, surface.GetTextureID('gsrchud/_ttt/640hud2'), 256, 256)
GSRCHUD.sprite.addTexture(HUD3, surface.GetTextureID('gsrchud/_ttt/640hud3'), 256, 256)
GSRCHUD.sprite.addTexture(HUD4, surface.GetTextureID('gsrchud/_ttt/640hud4'), 256, 256)
GSRCHUD.sprite.addTexture(HUD5, surface.GetTextureID('gsrchud/_ttt/640hud5'), 256, 256)
GSRCHUD.sprite.addTexture(HUD6, surface.GetTextureID('gsrchud/_ttt/640hud6'), 256, 256)
GSRCHUD.sprite.addTexture(HUD7, surface.GetTextureID('gsrchud/_ttt/640hud7'), 256, 256)
GSRCHUD.sprite.addTexture(HUD8, surface.GetTextureID('gsrchud/_ttt/640hud8'), 256, 256)
GSRCHUD.sprite.addTexture(HUD9, surface.GetTextureID('gsrchud/_ttt/640hud9'), 256, 256)
GSRCHUD.sprite.addTexture(HUD10, surface.GetTextureID('gsrchud/_ttt/640hud10'), 256, 256)
GSRCHUD.sprite.addTexture(HUD11, surface.GetTextureID('gsrchud/_ttt/640hud11'), 256, 256)
GSRCHUD.sprite.addTexture(HUD12, surface.GetTextureID('gsrchud/_ttt/640hud12'), 256, 256)
GSRCHUD.sprite.addTexture(HUD13, surface.GetTextureID('gsrchud/_ttt/640hud13'), 256, 256)

-- add weapon icons
GSRCHUD.weapon.addSprite('weapon_ttt_beacon', {
  weapon = {HUD7, 0, 0, 170, 45},
  weapon_s = {HUD8, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_binoculars', {
  weapon = {HUD9, 0, 0, 170, 45},
  weapon_s = {HUD10, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_c4', {
  weapon = {HUD5, 0, 0, 170, 45},
  weapon_s = {HUD6, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_confgrenade', {
  weapon = {HUD1, 0, 45, 170, 45},
  weapon_s = {HUD2, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_cse', {
  weapon = {HUD7, 0, 45, 170, 45},
  weapon_s = {HUD8, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_decoy', {
  weapon = {HUD7, 0, 0, 170, 45},
  weapon_s = {HUD8, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_defuser', {
  weapon = {HUD9, 0, 45, 170, 45},
  weapon_s = {HUD10, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_flaregun', {
  weapon = {HUD7, 0, 180, 170, 45},
  weapon_s = {HUD8, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_glock', {
  weapon = {HUD5, 0, 45, 170, 45},
  weapon_s = {HUD6, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_health_station', {
  weapon = {HUD7, 0, 135, 170, 45},
  weapon_s = {HUD8, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_knife', {
  weapon = {HUD5, 0, 180, 170, 45},
  weapon_s = {HUD6, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_m16', {
  weapon = {HUD3, 0, 0, 170, 45},
  weapon_s = {HUD4, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_phammer', {
  weapon = {HUD9, 0, 90, 170, 45},
  weapon_s = {HUD10, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_push', {
  weapon = {HUD9, 0, 135, 170, 45},
  weapon_s = {HUD10, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_radio', {
  weapon = {HUD11, 0, 90, 170, 45},
  weapon_s = {HUD12, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_sipistol', {
  weapon = {HUD5, 0, 90, 170, 45},
  weapon_s = {HUD6, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_smokegrenade', {
  weapon = {HUD1, 0, 135, 170, 45},
  weapon_s = {HUD2, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_stungun', {
  weapon = {HUD3, 0, 135, 170, 45},
  weapon_s = {HUD4, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_teleport', {
  weapon = {HUD11, 0, 45, 170, 45},
  weapon_s = {HUD12, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_unarmed', {
  weapon = {HUD11, 0, 135, 170, 45},
  weapon_s = {HUD12, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_ttt_wtester', {
  weapon = {HUD11, 0, 0, 170, 45},
  weapon_s = {HUD12, 0, 0, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_carry', {
  weapon = {HUD9, 0, 180, 170, 45},
  weapon_s = {HUD10, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_improvised', {
  weapon = {HUD13, 0, 90, 170, 45},
  weapon_s = {HUD13, 0, 135, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_mac10', {
  weapon = {HUD1, 0, 180, 170, 45},
  weapon_s = {HUD2, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_molotov', {
  weapon = {HUD13, 0, 0, 170, 45},
  weapon_s = {HUD13, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_pistol', {
  weapon = {HUD11, 0, 180, 170, 45},
  weapon_s = {HUD12, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_revolver', {
  weapon = {HUD3, 0, 180, 170, 45},
  weapon_s = {HUD4, 0, 180, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_rifle', {
  weapon = {HUD3, 0, 45, 170, 45},
  weapon_s = {HUD4, 0, 45, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_shotgun', {
  weapon = {HUD3, 0, 90, 170, 45},
  weapon_s = {HUD4, 0, 90, 170, 45}
})

GSRCHUD.weapon.addSprite('weapon_zm_sledge', {
  weapon = {HUD1, 0, 0, 170, 45},
  weapon_s = {HUD2, 0, 0, 170, 45}
})

--[[ Timer element ]]--
local TEXTURE, NUM0 = surface.GetTextureID('gsrchud/_shared/white_additive'), 'number_0'
local colour = Color(255, 255, 255, GSRCHUD.DEFAULT_ALPHA) -- cached colour

-- add clock sprite
GSRCHUD.sprite.add('clock', '640hud7', 144, 72, 24, 24, GSRCHUD.THEME_CSDELETEDSCENES)

-- add element
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  local scale = GSRCHUD.sprite.scale()
  local x, y = ScrW() * .5, ScrH() - 12 * scale

  -- get ttt variables
  local isHaste = HasteMode() and GAMEMODE.round_state == ROUND_ACTIVE
  local isTraitor = GSRCHUD.localPlayer():IsActiveTraitor()
  local endtime = math.max(GetGlobalFloat('ttt_round_end', 0) - CurTime(), 0)
  local haste = math.max(GetGlobalFloat('ttt_haste_end', 0) - CurTime(), 0)

  -- get time
  local minutes = math.floor(endtime / 60)
  local seconds = math.floor(endtime - minutes * 60)

  -- select time to display during haste mode
  local highlight = false
  if isHaste then
    if not isTraitor or math.ceil(CurTime()) % 7 > 2 then
      minutes = math.floor(haste / 60)
      seconds = math.floor(haste - minutes * 60)
      highlight = haste <= 0
    else
      highlight = true
    end
  end

  -- get dots colour
  local _colour = GSRCHUD.sprite.colour(highlight)
  colour.r = _colour.r
  colour.g = _colour.g
  colour.b = _colour.b

  -- draw dots
  surface.SetTexture(TEXTURE)
  surface.SetDrawColor(colour)
  surface.DrawTexturedRect(x + 2 * scale, y - 10 * scale, 2 * scale, 2 * scale)
  surface.DrawTexturedRect(x + 2 * scale, y - 16 * scale, 2 * scale, 2 * scale)

  -- draw seconds
  local w, h = GSRCHUD.sprite.getSize(NUM0)
  if seconds < 10 then GSRCHUD.sprite.draw(NUM0, x + w + 6 * scale, y, highlight, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM) end
  GSRCHUD.number.render(seconds, x + (w * 2) + 6 * scale, y, TEXT_ALIGN_BOTTOM, nil, highlight)

  -- draw minutes
  GSRCHUD.number.render(minutes, x, y, TEXT_ALIGN_BOTTOM, nil, highlight, nil, nil)

  -- draw clock
  GSRCHUD.sprite.draw('clock', x - w * 2, y - scale, highlight, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end

GSRCHUD.element.register('timer', {}, ELEMENT)
