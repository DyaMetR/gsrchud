--[[------------------------------------------------------------------
  Sprite rendering and custom sprite declaration
]]--------------------------------------------------------------------

GSRCHUD.sprite = {} -- namespace

GSRCHUD.DEFAULT_ALPHA = 100
GSRCHUD.DEFAULT_HIGHLIGHT_ALPHA = 128

local MISSING_TEXTURE = surface.GetTextureID('materials/debug/debugempty')
local DEFAULT_COLOUR = Color(255, 255, 255)

local HOOK_COLOUR = 'GetColour'
local HOOK_ALPHA = 'GetAlpha'
local HOOK_HIGHLIGHT = 'GetHighlightAlpha'
local HOOK_SCALE = 'GetScale'

local missingSprites = {} -- unavailable sprites that were attempted to be drawn
local missingTextures = {} -- unavailable textures that were attempted to be drawn

--[[------------------------------------------------------------------
  Draws a missing texture square in the place of a sprite.
  @param {number} x
  @param {number} y
]]--------------------------------------------------------------------
local function drawMissingTexture(x, y)
  surface.SetTexture(MISSING_TEXTURE)
  surface.SetDrawColor(DEFAULT_COLOUR)
  surface.DrawTexturedRect(x, y, 32, 32)
end

--[[------------------------------------------------------------------
  Registers a texture file to be used on sprites for one or more themes.
  @param {string} texture name
  @param {number} texture ID
  @param {number} file's width
  @param {number} file's height
  @param {THEME_|nil} theme to add this texture to (blank is default)
]]--------------------------------------------------------------------
function GSRCHUD.sprite.addTexture(name, texture, w, h, theme)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a texture with this name in the given theme
  if _theme.textures[name] then
    GSRCHUD.print(string.format('There was already a texture named %s in theme %s and has been overridden.', name, _theme.name), GSRCHUD.log.WARN)
  end

  -- add texture to theme
  _theme:addTexture(name, texture, w, h)
end

--[[------------------------------------------------------------------
  Registers a new sprite.
  @param {string} sprite name
  @param {string} texture file name it uses
  @param {number} sprite's x position in the file
  @param {number} sprite's y position in the file
  @param {number} sprite's width
  @param {number} sprite's height
  @param {THEME_|nil} theme to add this sprite to (blank is default)
]]--------------------------------------------------------------------
function GSRCHUD.sprite.add(sprite, texture, u, v, w, h, theme)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a sprite with this name in the given theme
  if _theme.sprites[sprite] then
    GSRCHUD.print(string.format('There was already a sprite named "%s" in theme "%s" and has been overridden.', sprite, _theme.name), GSRCHUD.log.WARN)
  end

  -- add sprite to theme
  _theme:addSprite(sprite, texture, u, v, w, h)
end

--[[------------------------------------------------------------------
  Gets a sprite's data.
  @param {string} sprite
  @param {THEME_|nil} theme to get sprite from (blank is default)
  @return {table} sprite data
]]--------------------------------------------------------------------
function GSRCHUD.sprite.get(sprite, theme)
  theme = theme or GSRCHUD.config.getTheme()
  return GSRCHUD.theme.get(theme).sprites[sprite] or GSRCHUD.theme.default().sprites[sprite]
end

--[[------------------------------------------------------------------
  Gets a sprite's size.
  @param {string} sprite
  @param {number|nil} scale to apply
  @param {THEME_|nil} theme to get sprite from (blank is default)
  @return {table} sprite data
]]--------------------------------------------------------------------
function GSRCHUD.sprite.getSize(sprite, scale, theme)
  theme = theme or GSRCHUD.config.getTheme()
  scale = scale or GSRCHUD.sprite.scale()
  local _sprite = GSRCHUD.sprite.get(sprite)
  return _sprite.w * scale, _sprite.h * scale
end

--[[------------------------------------------------------------------
  Returns the alpha amount used in sprites by default.
  @return {number} alpha
]]--------------------------------------------------------------------
function GSRCHUD.sprite.alpha()
  local alpha = GSRCHUD.hook.run(HOOK_ALPHA)
  return alpha or GSRCHUD.config.getAlpha()
end

--[[------------------------------------------------------------------
  Returns the alpha amount used in sprites' highlighting by default.
  @return {number} alpha
]]--------------------------------------------------------------------
function GSRCHUD.sprite.highlight()
  local highlight = GSRCHUD.hook.run(HOOK_HIGHLIGHT)
  return highlight or GSRCHUD.config.getHighlight()
end

--[[------------------------------------------------------------------
  Returns the scale used in sprites by default.
  @return {number} scale
]]--------------------------------------------------------------------
function GSRCHUD.sprite.scale()
  local scale = GSRCHUD.hook.run(HOOK_SCALE)
  return scale or GSRCHUD.config.getScale()
end

--[[------------------------------------------------------------------
  Returns the correct colour.
  @param {Color|boolean|nil} colour
    - if Color, will use it directly
    - if boolean, will switch between the theme's colour and it's critical colour
    - if not provided, will default to the theme's colour
  @param {THEME_|nil} theme
  @return {Color} resulting colour
]]--------------------------------------------------------------------
function GSRCHUD.sprite.colour(colour, theme)
  theme = theme or GSRCHUD.config.getTheme()
  local _theme = GSRCHUD.theme.get(theme)
  local hookColour, hookCritCol = GSRCHUD.hook.run(HOOK_COLOUR) -- check for override
  local _colour = hookColour or _theme.colour or DEFAULT_COLOUR
  if colour then
    if isbool(colour) then
      _colour = hookCritCol or _theme.critColour
    else
      _colour = colour
    end
  end
  return _colour
end

--[[------------------------------------------------------------------
  Returns the correct colour to use based on colouring configuration.
  @param {Color|boolean} base colour
  @param {boolean} whether the critical colour should be used
  @param {THEME_|nil} underlying theme
  @return {Color} resulting colour
]]--------------------------------------------------------------------
function GSRCHUD.sprite.userColour(colour, isCrit, theme)
  if not GSRCHUD.config.isColouringEnabled() then
    return GSRCHUD.sprite.colour(isCrit, theme) -- use default
  else
    if isCrit then
      if isbool(isCrit) then
        return GSRCHUD.config.getCritColour()
      else
        return isCrit
      end
    else
      return colour
    end
  end
end

--[[------------------------------------------------------------------
  Draws a sprite.
  @param {string} sprite
  @param {number} x
  @param {number} y
  @param {Color|boolean|nil} colour
    - if Color, will use it directly
    - if boolean, will switch between the theme's colour and it's critical colour
    - if not provided, will default to the theme's colour
  @param {TEXT_ALIGN_LEFT|TEXT_ALIGN_CENTER|TEXT_ALIGN_RIGHT|nil} horizontal alignment
  @param {TEXT_ALIGN_BOTTOM|TEXT_ALIGN_CENTER|TEXT_ALIGN_TOP|nil} vertical alignment
  @param {number|nil} scale
  @param {number|nil} alpha
  @param {THEME_|nil} theme (defaults to the selected theme)
  @return {number} sprite scaled width
  @return {number} sprite scaled height
]]--------------------------------------------------------------------
function GSRCHUD.sprite.draw(sprite, x, y, colour, halign, valign, scale, alpha, theme)
  alpha = alpha or GSRCHUD.sprite.alpha()
  scale = scale or GSRCHUD.sprite.scale()
  theme = theme or GSRCHUD.config.getTheme()
  halign = halign or TEXT_ALIGN_LEFT
  valign = valign or TEXT_ALIGN_TOP

  -- get theme information
  local _theme, default = GSRCHUD.theme.get(theme), GSRCHUD.theme.default()

  -- if this theme hasn't got the sprite, load it as the default
  if not _theme.sprites[sprite] then _theme = GSRCHUD.theme.default() end

  -- get sprite information
  local _sprite = _theme.sprites[sprite]

  -- if sprite does not exist, do not draw
  if not _sprite then
    -- warn
    if not missingSprites[sprite] then
      GSRCHUD.print(string.format('Attempted drawing non-existing sprite "%s".', sprite), GSRCHUD.log.WARN)
      missingSprites[sprite] = true
    end

    -- draw missing texture
    drawMissingTexture(x, y)
    return 32, 32
  end

  -- get texture information
  local texture = _theme.textures[_sprite.texture]

  -- if texture does not exist, do not draw
  if not texture then
    local id = theme or 0

    -- reserve missing textures table for this theme
    if not missingTextures[id] then missingTextures[id] = {} end

    -- warn
    if not missingTextures[id][_sprite.texture] then
      GSRCHUD.print(string.format('Theme "%s" does not have the texture "%s" required to draw sprite "%s".', _theme.name, _sprite.texture, sprite), GSRCHUD.log.WARN)
      missingTextures[id][_sprite.texture] = true
    end

    -- draw missing texture
    drawMissingTexture(x, y)

    return 32, 32
  end

  -- select the colour to use
  local _colour = GSRCHUD.sprite.colour(colour, theme)

  -- get sprite's size
  local w, h = _sprite.w * scale, _sprite.h * scale

  -- apply horizontal alignment
  if halign == TEXT_ALIGN_RIGHT then
    x = x - w
  elseif halign == TEXT_ALIGN_CENTER then
    x = x - w * .5
  end

  -- apply vertical alignment
  if valign == TEXT_ALIGN_BOTTOM then
    y = y - h
  elseif valign == TEXT_ALIGN_CENTER then
    y = y - h * .5
  end

  -- get sprite boundaries
  local u0, v0 = _sprite.u / texture.w, _sprite.v / texture.h
  local u1, v1 = (_sprite.u + _sprite.w) / texture.w, (_sprite.v + _sprite.h) / texture.h

  -- half pixel anticorrection
  local du = 0.5 / (texture.w * scale)
  local dv = 0.5 / (texture.h * scale)

  -- apply correction
  u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
  u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)

  -- apply alpha
  local _alpha = surface.GetAlphaMultiplier()
  surface.SetAlphaMultiplier(alpha / 255)

  -- draw sprite
  surface.SetTexture(texture.texture)
  surface.SetDrawColor(_colour)
  surface.DrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)

  -- recover alpha
  surface.SetAlphaMultiplier(_alpha)

  return _sprite.w * scale, _sprite.h * scale
end

--[[------------------------------------------------------------------
  Draws a sprite with a twin that can be used as highlighting.
  @param {string} sprite
  @param {number} x
  @param {number} y
  @param {number} how highlighted is the twin
  @param {Color|boolean|nil} colour
    - if Color, will use it directly
    - if boolean, will switch between the theme's colour and it's critical colour
    - if not provided, will default to the theme's colour
  @param {TEXT_ALIGN_LEFT|TEXT_ALIGN_CENTER|TEXT_ALIGN_RIGHT|nil} horizontal alignment
  @param {TEXT_ALIGN_BOTTOM|TEXT_ALIGN_CENTER|TEXT_ALIGN_TOP|nil} vertical alignment
  @param {number|nil} scale
  @param {number|nil} alpha
  @param {THEME_|nil} theme (defaults to the selected theme)
  @return {number} sprite scaled width
  @return {number} sprite scaled height
]]--------------------------------------------------------------------
function GSRCHUD.sprite.drawTwin(sprite, x, y, highlight, colour, halign, valign, scale, alpha, theme)
  local max = GSRCHUD.sprite.alpha() -- maximum alpha amount by default
  alpha = alpha or max -- if no alpha amount was provided, default to maximum
  local w, h = GSRCHUD.sprite.draw(sprite, x, y, colour, halign, valign, scale, alpha, theme)
  if highlight and highlight > 0 then
    GSRCHUD.sprite.draw(sprite, x, y, colour, halign, valign, scale, GSRCHUD.sprite.highlight() * highlight * (alpha / max), theme)
  end
  return w, h
end
