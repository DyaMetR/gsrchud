--[[------------------------------------------------------------------
  Toggle stats spectating in your gamemode (or server)
]]--------------------------------------------------------------------

local spectate = CreateConVar('sv_gsrchud_allow_stat_spectating', 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, 'Allow players to see the stats of the entity they\'re spectating.')

if CLIENT then

  local BLOCKED_HOOK = 'BlockStatusSpectate'

  --[[------------------------------------------------------------------
    Returns the player we're displaying the stats from.
    @return {Entity} who we're taking the stats from
  ]]--------------------------------------------------------------------
  function GSRCHUD.localPlayer()
    local localPlayer = LocalPlayer()
    if not localPlayer.GetObserverTarget then return localPlayer end
    local observed = LocalPlayer():GetObserverTarget()
    if not IsValid(observed) or (not observed:IsNPC() and not observed:IsPlayer()) or GSRCHUD.hook.run(BLOCKED_HOOK, GAMEMODE_NAME) or not spectate:GetBool() then return localPlayer end
    return observed
  end

end
