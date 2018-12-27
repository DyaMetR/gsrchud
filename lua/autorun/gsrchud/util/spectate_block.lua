--[[
  BLOCK SPECTATE STATS
  In case you don't want your gamemode to support stats spectating
]]

if CLIENT then

  -- Database
  GSRCHUD.SpectateBlock = {};

  --[[
    Adds a gamemode to the block list
    @param {string} gamemode
    @void
  ]]
  function GSRCHUD:AddSpectateBlock(gamemode)
    self.SpectateBlock[gamemode] = true;
  end

  --[[
    Returns whether a gamemode is blocking the spectate feature
    @param {string} gamemode
    @return {boolean} isBlocked
  ]]
  function GSRCHUD:GetSpectateBlock(gamemode)
    if (self.SpectateBlock[gamemode] == nil) then return false; end
    return self.SpectateBlock[gamemode];
  end

  --[[
    Returns whether the current gamemode is blocking stat spectating
    @return {boolean} isBlocked
  ]]
  function GSRCHUD:IsStatSpectatingBlocked()
    local gamemode = GAMEMODE_NAME;
    return self:GetSpectateBlock(gamemode);
  end

  --[[
    Returns the player whose stats you should be seeing
    @return {Player} localPlayer
  ]]
  function GSRCHUD:GetLocalPlayer()
    if (not IsValid(LocalPlayer():GetObserverTarget()) || self:IsStatSpectatingBlocked()) then return LocalPlayer(); end
    return LocalPlayer():GetObserverTarget();
  end

end
