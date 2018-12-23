--[[
  GAMEMODE BASED DISPLAY OVERRIDE
]]

if CLIENT then

  -- Override table
  GSRCHUD.GamemodeOverride = {};

  --[[
    Adds a gamemode based display override
    Make 'func' return true or false to decide whether to display or not
    @param {string} gamemode
    @param {function} func
    @void
  ]]
  function GSRCHUD:AddGamemodeOverride(gamemode, func)
    self.GamemodeOverride[gamemode] = func;
  end

  --[[
    Returns a gamemode based display override
    @param {string} gamemode
    @return {function} func
  ]]
  function GSRCHUD:GetGamemodeOverride(gamemode)
    return self.GamemodeOverride[gamemode];
  end

  --[[
    Returns whether a gamemode has an override
    @param {string} gamemode
    @return {boolean} hasOverride
  ]]
  function GSRCHUD:HasGamemodeOverride(gamemode)
    return self.GamemodeOverride[gamemode] ~= nil and type(self.GamemodeOverride[gamemode]()) == "boolean";
  end

  --[[
    Checks whether the current gamemode is overriding the HUD
    @return {boolean} hasOverride
    @return {boolean} isOverriden
  ]]
  function GSRCHUD:IsHUDOverriden()
    local gamemode = GAMEMODE_NAME;
    local value = false;
    if (self:HasGamemodeOverride(gamemode)) then value = self:GetGamemodeOverride(gamemode)(); end
    return self:HasGamemodeOverride(gamemode), value;
  end

end
