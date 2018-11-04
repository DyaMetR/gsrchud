--[[
  CUSTOM SPRITES
]]

if CLIENT then

  -- Sprites list
  GSRCHUD.CustomSprites = {};

  -- Methods
  --[[
    Adds a custom sprite to the list
    @param {string} id
    @param {string} texture
    @param {number} fileW
    @param {number} fileH
    @param {number|null} x
    @param {number|null} y
    @param {number|null} w
    @param {number|null} h
    @void
  ]]
  function GSRCHUD:AddCustomSprite(id, texture, fileW, fileH, x, y, w, h)
    x = x or 0;
    y = y or 0;
    w = w or fileW;
    h = h or fileH;
    self.CustomSprites[id] = {texture = texture, fileW = fileW, fileH = fileH, x = x, y = y, w = w, h = h};
  end

  --[[
    Returns the sprite information based on id
    @param {string} id
    @return {table} iconData
  ]]
  function GSRCHUD:GetCustomSprite(id)
    return self.CustomSprites[id];
  end

  --[[
    Returns whether the icon exists or not
    @param {string} id
    @return {boolean} hasIcon
  ]]
  function GSRCHUD:HasCustomSprite(id)
    return self.CustomSprites[id] ~= nil;
  end

  --[[
    Draws a custom sprite
    @param {string} id
    @param {number} x
    @param {number} y
    @param {number} scale
    @param {number} alpha
    @param {boolean} crit
  ]]
  function GSRCHUD:DrawCustomSprite(id, x, y, scale, alpha, crit)
    if not self:HasCustomSprite(id) then return; end
    scale = scale or 1;
    crit = crit or false;

    local add = math.Clamp(alpha - 255, 0, 255)/255;
    local color = self:GetThemeDefaultColor(self:GetCurrentTheme());
    if (crit) then color = self:GetThemeDefaultCritColor(self:GetCurrentTheme()); end
    if (self:IsCustomColouringEnabled()) then
      color = self:GetCustomSelectorColor();
      if (crit) then color = self:GetCustomCritColor(); end
    end

    local icon = self:GetCustomSprite(id);
    local u1, v1, u2, v2 = icon.x/icon.fileW, icon.y/icon.fileH, (icon.x + icon.w)/icon.fileW, (icon.y + icon.h)/icon.fileH;
    local w, h = icon.w * scale, icon.h * scale;
    surface.SetDrawColor(Color(color.r + 255 * add, color.g + 255 * add, color.b + 255 * add, color.a * (alpha/255)));
    surface.SetTexture(icon.texture);
    surface.DrawTexturedRectUV(x, y, w, h, u1, v1, u2, v2);
  end

end
