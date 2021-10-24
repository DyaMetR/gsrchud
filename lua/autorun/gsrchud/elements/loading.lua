--[[------------------------------------------------------------------
  Fake loading screen.
]]--------------------------------------------------------------------

local HOOK = GSRCHUD.hookname .. '_loading'
local DELAY = 2
local offset, delay = 0, 0

--[[ Add configuration ]]--
GSRCHUD.config.createConVar('loading', 1, GSRCHUD.PARAM_CHECK)

-- toggle panel visibility based on configuration
cvars.AddChangeCallback(HOOK, function(cvar, old, new)
  local enabled = tonumber(new)
  if not GSRCHUD.loadingPanel or not enabled then return end
  GSRCHUD.loadingPanel:SetVisible(enabled > 0)
end)

--[[ Run code on post initialization ]]--
hook.Add('InitPostEntity', HOOK, function()
  local panel = vgui.Create('DLoadingScreen')
  panel:SetSize(ScrW(), ScrH())
  panel:SetPlayer(LocalPlayer())
  if GSRCHUD.config.getLoading() then
    panel:SetOffset(0)
  else
    panel:SetOffset(1) -- start with animation finished (also hides it)
  end
  panel:SetVisible(GSRCHUD.isEnabled())
  delay = CurTime() + DELAY -- apply initial delay
  GSRCHUD.loadingPanel = panel -- store reference
end)

--[[ Run animation on the think loop ]]--
hook.Add('Think', HOOK, function()
  if not GSRCHUD.isEnabled() or delay > CurTime() or offset >= 1 or not GSRCHUD.config.getLoading() or not GSRCHUD.loadingPanel then return end
  offset = offset + RealFrameTime() * .66
  GSRCHUD.loadingPanel:SetOffset(offset)
end)

--[[ Resize panel if screen size changes ]]--
hook.Add('OnScreenSizeChanged', HOOK, function(_w, _h)
  GSRCHUD.loadingPanel:SetSize(ScrW(), ScrH())
end)

--[[ Add command to reset loading screen status ]]--
concommand.Add(GSRCHUD.hookname .. '_reset_loading', function(_, _, _)
  if not GSRCHUD.isEnabled() then return end
  if GSRCHUD.config.getLoading() then GSRCHUD.loadingPanel:SetOffset(0) end
  GSRCHUD.loadingPanel:SetupPlayer(GSRCHUD.loadingPanel.player) -- refresh the player model
  delay = CurTime() + DELAY
  offset = 0
end)
