--[[------------------------------------------------------------------
  Damage types icon rendering.
]]--------------------------------------------------------------------

GSRCHUD.hazard = {} -- namespace

--[[------------------------------------------------------------------
  Base function for adding new hazard icons.
]]--------------------------------------------------------------------
local function addHazardIcon(theme, func, hazard, ...)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a sprite with this name in the given theme
  if _theme.hazards[hazard] then
    GSRCHUD.print(string.format('Hazard "%s" had already an icon set in theme "%s" and has been overridden.', hazard, _theme.name), GSRCHUD.log.WARN)
  end

  -- add hazard icon to theme
  _theme[func](_theme, hazard, ...)
end

--[[------------------------------------------------------------------
  Adds a sprite as a hazard icon.
  @param {DMG_} damage type
  @param {number} texture ID
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.hazard.addSprite(hazard, texture, u, v, w, h, theme)
  addHazardIcon(theme, 'addHazardSprite', hazard, texture, u, v, w, h)
end

--[[------------------------------------------------------------------
  Uses already defined sprites as a hazard icon.
  @param {DMG_} damage type
  @param {string} sprite
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.hazard.setSprite(hazard, sprite, theme)
  addHazardIcon(theme, 'setHazardSprite', hazard, sprite)
end

--[[------------------------------------------------------------------
  Adds a sprite as a hazard icon.
  @param {DMG} damage type
  @param {number} texture ID of the icon
  @param {number} width
  @param {number} height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.hazard.addTexture(hazard, texture, w, h, theme)
  addHazardIcon(theme, 'addHazardTexture', hazard, texture, w, h)
end

--[[------------------------------------------------------------------
  Whether the given hazard icon exists.
  @param {DMG_} damage type
  @param {THEME_|nil} theme to look up the icon from
  @return {boolean} has ammunition type
]]--------------------------------------------------------------------
function GSRCHUD.hazard.has(hazard, theme)
  local _hazard = GSRCHUD.theme.get(theme).hazards[hazard]
  if _hazard and _hazard.sprite == NULL then return false end -- if it's NULL, skip it
  return _hazard or GSRCHUD.theme.default().hazards[hazard]
end

--[[------------------------------------------------------------------
  Returns the size of the given hazard icon.
  @param {DMG_} damage type
  @param {THEME_|nil} theme to look into
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
function GSRCHUD.hazard.getSize(hazard, theme)
  local _theme = GSRCHUD.theme.get(theme or GSRCHUD.config.getTheme())
  local icon = _theme.hazards[hazard] or GSRCHUD.theme.default().hazards[hazard]
  if not icon then return 0, 0 end
  if icon.isSprite then
    return GSRCHUD.sprite.getSize(icon.sprite)
  else
    return icon.w, icon.h
  end
end

--[[------------------------------------------------------------------
  Draws the given hazard's icon.
  @param {number} x
  @param {number} y
  @param {DMG_} damage type
  @param {Color|boolean|nil} colour
  @param {TEXT_ALIGN_LEFT|TEXT_ALIGN_CENTER|TEXT_ALIGN_RIGHT|nil} horizontal alignment
  @param {TEXT_ALIGN_BOTTOM|TEXT_ALIGN_CENTER|TEXT_ALIGN_TOP|nil} vertical alignment
  @param {number|nil} scale
  @param {number|nil} alpha component
  @param {THEME_|nil} theme to draw this icon from
  @return {number} icon width
  @return {number} icon height
]]--------------------------------------------------------------------
function GSRCHUD.hazard.draw(x, y, hazard, colour, halign, valign, scale, alpha, theme)
  theme = theme or GSRCHUD.config.getTheme()
  local _theme = GSRCHUD.theme.get(theme)
  local icon = _theme.hazards[hazard] or GSRCHUD.theme.default().hazards[hazard]
  if not icon then return end

  -- draw icon
  if icon.isSprite then
    return GSRCHUD.sprite.draw(icon.sprite, x, y, colour, halign, valign, scale, alpha, theme)
  else
    -- get size
    local w, h = icon.w * scale, icon.h * scale

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

    -- draw
    surface.SetDrawColor(GSRCHUD.sprite.colour(colour))
    surface.SetTexture(icon.texture)
    surface.DrawTexturedRect(x, y, w, h)

    return w, h
  end
end
