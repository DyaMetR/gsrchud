--[[------------------------------------------------------------------
  Sideways camera when dying
]]--------------------------------------------------------------------

local deathcam = CreateConVar('sv_gsrchud_allow_deathcam', 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, 'Allow the first-person sideways camera when dead.')

if SERVER then return end

local DEATHCAM_HOOK = 'ShouldUseDeathCam'

-- configuraton
GSRCHUD.config.createConVar('deathCam', 1, GSRCHUD.config.PARAM_CHECK)

-- implementation
hook.Add('CalcView', GSRCHUD.hookname, function(_player, origin, angles, fov, znear, zfar)
  if LocalPlayer():Alive() or not GSRCHUD.isEnabled() or not deathcam:GetBool() or GSRCHUD.hook.run(DEATHCAM_HOOK) == false or not GSRCHUD.config.getDeathCam() then return end

  -- hide ragdoll
  local ragdoll = LocalPlayer():GetRagdollEntity()
  if ragdoll and IsValid(ragdoll) and ragdoll.SetNoDraw then ragdoll:SetNoDraw(true) end

  -- generate table
  local view = {
    origin = _player:GetPos() + Vector(0, 0, 5),
    angles = angles + Angle(0, 0, 90),
    fov = fov
  }

  -- return it
  return view
end)
