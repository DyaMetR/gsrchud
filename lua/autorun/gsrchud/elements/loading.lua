--[[------------------------------------------------------------------
  Fake loading screen.
]]--------------------------------------------------------------------

local HOOK = GSRCHUD.hookname .. '_loading'

if SERVER then
	-- add network string
	util.AddNetworkString(HOOK)

	--[[ Send signal upon respawning ]]--
	hook.Add('PlayerSpawn', HOOK, function(_player)
		net.Start(HOOK)
		net.Send(_player)
	end)
end

if CLIENT then

	local HOOK_NAME = 'ShowLoadingScreen'
	local DELAY = 2
	local offset, delay = 0, 0

	--[[ Add configuration ]]--
	GSRCHUD.config.createConVar('loading', 1, GSRCHUD.PARAM_CHECK)

	--[[------------------------------------------------------------------
	  Triggers the loading screen.
	]]--------------------------------------------------------------------
	local function trigger()
		-- get visibility
	  local visible = GSRCHUD.isEnabled() and GSRCHUD.config.getLoading()
	  local override = GSRCHUD.hook.run(HOOK_NAME)
	  if override ~= nil then visible = override end

	  -- if not visible, do not run
	  if not visible then return end

	  -- reset animation
	  GSRCHUD.loadingPanel:SetSize(ScrW(), ScrH()) -- reset size
	  GSRCHUD.loadingPanel:SetOffset(0) -- reset offset
	  GSRCHUD.loadingPanel:SetupPlayer(GSRCHUD.loadingPanel.player) -- refresh the player model
	  delay = CurTime() + DELAY -- place a delay
	  offset = 0
	end

	-- toggle panel visibility based on configuration
	cvars.AddChangeCallback(HOOK, function(cvar, old, new)
	  local enabled = tonumber(new)
	  if not GSRCHUD.loadingPanel or not enabled then return end
	  local visible = enabled > 0 -- whether it should be visible

	  -- check any hook overrides
	  local override = GSRCHUD.hook.run(HOOK_NAME)
	  if override ~= nil then visible = override end

	  -- change visibility
	  GSRCHUD.loadingPanel:SetVisible(visible)

	  -- end animation if we're disabling it
	  if not visible then GSRCHUD.loadingPanel:SetOffset(1) end
	end)

	--[[ Run code on post initialization ]]--
	hook.Add('InitPostEntity', HOOK, function()
	  -- get visibility
	  local visible = GSRCHUD.isEnabled() and GSRCHUD.config.getLoading()
	  local override = GSRCHUD.hook.run(HOOK_NAME)
	  if override ~= nil then visible = override end

	  -- create panel
	  local panel = vgui.Create('DLoadingScreen')
	  panel:SetPlayer(LocalPlayer())
	  if visible then
			panel:SetSize(ScrW(), ScrH())
		else
			panel:SetSize(0, 0)
	  end
	  panel:SetOffset(offset)
	  panel:SetVisible(visible)
	  delay = CurTime() + DELAY -- apply initial delay
	  GSRCHUD.loadingPanel = panel -- store reference
	end)

	--[[ Run animation on the think loop ]]--
	hook.Add('Think', HOOK, function()
	  if offset >= 1 or delay > CurTime() or not GSRCHUD.loadingPanel then return end
	  offset = offset + RealFrameTime() * .66
	  GSRCHUD.loadingPanel:SetOffset(offset)

	  -- upon finishing, resize the panel so it doesn't bother other UI elements
	  if offset >= 1 then GSRCHUD.loadingPanel:SetSize(0, 0) end
	end)

	--[[ Resize panel if screen size changes ]]--
	hook.Add('OnScreenSizeChanged', HOOK, function(_w, _h)
	  if offset >= 1 then return end -- do not update if the animation ended
	  GSRCHUD.loadingPanel:SetSize(ScrW(), ScrH())
	end)

	--[[ Add command to reset loading screen status ]]--
	concommand.Add(GSRCHUD.hookname .. '_reset_loading', trigger)

	--[[ If enabled, show the loading screen after respawn ]]--
	net.Receive(HOOK, function(len)
		if not GSRCHUD.loadingPanel or not GSRCHUD.config.showLoadingOnRespawn() then return end
		trigger()
	end)

end
