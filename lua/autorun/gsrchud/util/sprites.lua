--[[
  SPRITES
]]

if CLIENT then

  local DEFAULT_ALPHA = 145

  -- Methods
  --[[
    Returns the sprite data
    @param {string} name
    @return {table} spriteData
  ]]
  function GSRCHUD:GetSprite(name)
    local theme = GSRCHUD:GetCurrentTheme();
    if self:GetThemeSprite(theme, name) == nil then return self:GetThemeSprite(self.DefaultConfig.DefaultTheme, name) end;
    if self:GetThemeSprite(theme, name) == NULL then return end;
    return self:GetThemeSprite(theme, name);
  end

  --[[
    Returns the file containing the material
    @param {string} name
    @return {table} file
  ]]
  function GSRCHUD:GetSpriteFile(name)
    if self:GetSprite(name) == nil then return nil end;
    return self:GetSprite(name).file;
  end

  --[[
    Returns the sprite file name
    @param {string} sprite
    @return {string} filename
  ]]
  function GSRCHUD:GetSpriteFileName(sprite)
    if self:GetSprite(sprite) == nil then return "nil" end;
    return self:GetSpriteFile(sprite).filename;
  end

  --[[
    Returns the dimensions of a sprite material file
    @param {string} sprite
    @return {number} w
    @return {number} h
  ]]
  function GSRCHUD:GetSpriteFileDimensions(sprite)
    if self:GetSprite(sprite) == nil then return 0, 0 end;
    return self:GetSpriteFile(sprite).w, self:GetSpriteFile(sprite).h;
  end

  --[[
    Returns the sprite dimensions
    @param {string} name
    @return {number} w
    @return {number} h
  ]]
  function GSRCHUD:GetSpriteDimensions(name)
    if self:GetSprite(name) == nil then return 0, 0 end;
    return self:GetSprite(name).w or 0, self:GetSprite(name).h or 0;
  end

  --[[
    Returns the position of the sprite in the file
    @param {string} name
    @return {number} x
    @return {number} y
  ]]
  function GSRCHUD:GetSpritePosition(name)
    if self:GetSprite(name) == nil then return 0, 0 end;
    return self:GetSprite(name).x or 0, self:GetSprite(name).y or 0;
  end

  --[[
    Returns the position modification of the sprite from the theme
    @param {string} name
    @return {number} xOffset
    @return {number} yOffset
  ]]
  function GSRCHUD:GetSpriteOffsets(name)
    if self:GetSprite(name) == nil then return 0, 0 end;
    return self:GetSprite(name).xOffset or 0, self:GetSprite(name).yOffset or 0;
  end

  --[[
    Returns the margin modification of the sprite from the theme
    @param {string} name
    @return {number} wOffset
    @return {number} hOffset
  ]]
  function GSRCHUD:GetSpriteMargins(name)
    if self:GetSprite(name) == nil then return 0, 0 end;
    return self:GetSprite(name).wOffset or 0, self:GetSprite(name).hOffset or 0;
  end

  --[[
    Renders a sprite -- if the alpha channel goes over the default, it'll render another sprite on top
    @param {number} x
    @param {number} y
    @param {string} sprite
    @param {number} alpha
    @param {boolean} crit
    @param {number} vertical scissor
    @param {Color|nil} colour
    @param {boolean|nil} should offset be limited
    @param {boolean|nil} should highlight be a sprite overlap
    @param {number|nil} horizontal scissor
    @param {boolean|nil} is horizontal scissor inverted
    @void
  ]]
  function GSRCHUD:DrawSprite(x, y, sprite, scale, alpha, crit, scissor, color, limitOffset, overlap, hScissor, invHScis)
    alpha = alpha or DEFAULT_ALPHA;
    overlap = overlap or false;
    if (overlap) then
      self:RenderSprite(x, y, sprite, scale, math.Clamp(alpha, 0, self:GetBaseAlpha()), crit, scissor, color, limitOffset, hScissor, invHScis);
      if (alpha > self:GetBaseAlpha()) then
        self:RenderSprite(x, y, sprite, scale, alpha - self:GetBaseAlpha(), crit, scissor, color, limitOffset, hScissor, invHScis);
      end
    else
      self:RenderSprite(x, y, sprite, scale, alpha, crit, scissor, color, limitOffset, hScissor, invHScis);
    end
  end

  --[[
    Draws an sprite on the given location
    @param {number} x
    @param {number} y
    @param {string} sprite
    @param {number} alpha
    @param {boolean} crit
    @param {number} vertical scissor
    @param {Color|nil} colour
    @param {boolean|nil} should offset be limited
    @param {number|nil} horizontal scissor
    @param {boolean|nil} is horizontal scissor inverted
    @void
  ]]
  function GSRCHUD:RenderSprite(x, y, sprite, scale, alpha, crit, scissor, color, limitOffset, hScissor, invHScis)
    if self:GetSprite(sprite) == nil then return end; -- No valid sprite? Don't draw it!
    scale = scale or 1;
    alpha = alpha or DEFAULT_ALPHA;
    crit = crit or false;
    scissor = scissor or 1;
    hScissor = hScissor or 1;

    if (limitOffset == nil) then
      limitOffset = true;
    end

    -- Sprite special displacement
    local xOffset, yOffset = GSRCHUD:GetSpriteOffsets(sprite);
    local wOffset, hOffset = GSRCHUD:GetSpriteMargins(sprite);

    -- Get colour
    local theme = self:GetCurrentTheme();
    local themeColor = self:GetThemeDefaultColor(theme);
    if crit then
      themeColor = self:GetThemeDefaultCritColor(theme);
    end
    if (self:IsCustomColouringEnabled() and color ~= nil) then
      themeColor = color;
      if crit then
        themeColor = self:GetCustomCritColor();
      end
    end

    local add = math.Clamp(alpha - 255, 0, 255)/255; -- How much will it be addedfrom alpha overload
    local r, g, b = themeColor.r + 255 * add, themeColor.g + 255 * add, themeColor.b + 255 * add; -- Colour structure
    local color = Color(r, g, b, alpha); -- Final colour
    local material = self:GetSpriteFileName(sprite); -- The material to get the sprite from
    local fW, fH = self:GetSpriteFileDimensions(sprite); -- The file dimensions
    local u, v = self:GetSpritePosition(sprite); -- The sprite pos in the file
    local w, h = self:GetSpriteDimensions(sprite); -- Sprite dimensions

    local hCut = math.Round(h * scissor); -- How much is it cut (if it is), function for armor and stuff
    local wCut = math.Round(w * hScissor); -- Horizontal cut

    local offset = (yOffset * scale);

    if (limitOffset) then
      local max, min = yOffset, -yOffset;

      if (yOffset < 0) then
        max = -yOffset;
        min = yOffset;
      end

      offset = math.Clamp(yOffset + yOffset * (1 - scale), min, max);
    end

    surface.SetTexture(material); -- Set the texture
    surface.SetDrawColor(color); -- Set the colour

    if (invHScis) then
      surface.DrawTexturedRectUV(x + xOffset + math.Round((w - wCut) * scale), y + (h - hCut) * scale + offset - h * (scale - 1), math.Round(wCut * scale), math.Round(hCut * scale), (u + (w - wCut))/fW, (v + (h - hCut))/fH, (u + w)/fW, (v+h)/fH); -- Draw the sprite
    else
      surface.DrawTexturedRectUV(x + xOffset, y + (h - hCut) * scale + offset - h * (scale - 1), math.Round(wCut * scale), math.Round(hCut * scale), u/fW, (v + (h - hCut))/fH, (u+wCut)/fW, (v+h)/fH); -- Draw the sprite
    end
  end

end
