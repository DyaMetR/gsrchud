--[[
  GAMEMODE BASED DEATH CAM OVERRIDE
]]

if CLIENT then

  -- Database
  GSRCHUD.DeathScreenOverride = {
    ["sandbox"] = function() return false; end
  };

  --[[
    Adds a gamemode based death screen override
    Make 'func' return true or false to decide whether to show the death scren or not
    @param {string} gamemode
    @param {function} func
    @void
  ]]
  function GSRCHUD:AddDeathScreenOverride(gamemode, func)
    self.DeathScreenOverride[gamemode] = func;
  end

  --[[
    Returns a gamemode based death screen override
    @param {string} gamemode
    @return {function} func
  ]]
  function GSRCHUD:GetDeathScreenOverride(gamemode)
    return self.DeathScreenOverride[gamemode];
  end

  --[[
    Returns whether a gamemode has a death screen override
    @param {string} gamemode
    @return {boolean} hasOverride
  ]]
  function GSRCHUD:HasDeathScreenOverride(gamemode)
    return self.DeathScreenOverride[gamemode] ~= nil and type(self.DeathScreenOverride[gamemode]()) == "boolean";
  end

  --[[
    Checks whether the current gamemode is overriding the death screen
    @return {boolean} hasOverride
    @return {boolean} isOverriden
  ]]
  function GSRCHUD:IsDeathScreenOverriden()
    local gamemode = GAMEMODE_NAME;
    local value = false;
    if (self:HasDeathScreenOverride(gamemode)) then value = self:GetDeathScreenOverride(gamemode)(); end
    return self:HasDeathScreenOverride(gamemode), value;
  end

end
