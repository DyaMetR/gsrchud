--[[
  THEMES HANDLING
]]

if CLIENT then
  -- Theme list
  GSRCHUD.Themes = {};

  -- Methods
  --[[
    Adds a theme to the list
    @param {string} name
    @param {table} spriteData
    @param {table} ammoData
    @void
  ]]
  function GSRCHUD:AddTheme(name, color, critColor, spriteData, ammoData, script)
    self.Themes[name] = {color = color, critColor = critColor, spriteData = spriteData, ammoData = ammoData or {}, script = script or nil};
  end

  --[[
    Returns the theme table
    @return {table} themes
  ]]
  function GSRCHUD:GetThemes()
    return self.Themes;
  end

  --[[
    Returns the theme data
    @param {string} name
    @return {table} theme
  ]]
  function GSRCHUD:GetTheme(name)
    return self.Themes[name];
  end

  --[[
    Returns the sprite data from a theme
    @param {string} theme
    @param {string} sprite
    @return {table} spriteData
  ]]
  function GSRCHUD:GetThemeSprite(theme, sprite)
    return self:GetTheme(theme).spriteData[sprite];
  end

  --[[
    Returns the default color from a theme
    @param {string} theme
    @return {color} color
  ]]
  function GSRCHUD:GetThemeDefaultColor(theme)
    return self:GetTheme(theme).color;
  end

  --[[
    Returns the default color for critical information from a theme
    @param {string} theme
    @return {color} critColor
  ]]
  function GSRCHUD:GetThemeDefaultCritColor(theme)
    return self:GetTheme(theme).critColor;
  end

  --[[
    Returns the custom ammunition icons that might or might not replace existing onesaa
    @param {string} theme
    @return {table} ammoData
  ]]
  function GSRCHUD:GetThemeAmmoIcons(theme)
    return self:GetTheme(theme).ammoData;
  end

  --[[
    Retruns a custom script played by a theme
    @param {string} theme
    @return {function} script
  ]]
  function GSRCHUD:GetThemeCustomScript(theme)
    return self:GetTheme(theme).script;
  end

end
