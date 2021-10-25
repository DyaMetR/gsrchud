--[[------------------------------------------------------------------
  Ammunition icons rendering.
]]--------------------------------------------------------------------

GSRCHUD.ammunition = {} -- namespace

local DEFAULT_AMMO = 'Pistol'

--[[------------------------------------------------------------------
  Base function for adding new ammunition type icons.
]]--------------------------------------------------------------------
local function addAmmoIcon(theme, func, ammoType, ...)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a sprite with this name in the given theme
  if _theme.ammo[ammoType] then
    GSRCHUD.print(string.format('Ammunition type "%s" had already an icon set in theme "%s" and has been overridden.', ammoType, _theme.name), GSRCHUD.log.WARN)
  end

  -- add ammo icon to theme
  _theme[func](_theme, ammoType, ...)
end

--[[------------------------------------------------------------------
  Adds a sprite as an ammunition icon.
  @param {string} ammunition type
  @param {number} texture ID
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.addSprite(ammoType, texture, u, v, w, h, theme)
  addAmmoIcon(theme, 'addAmmoSprite', ammoType, texture, u, v, w, h)
end

--[[------------------------------------------------------------------
  Uses already defined sprites a an ammunition icon.
  @param {string} ammunition type
  @param {string} sprite
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.setSprite(ammoType, sprite, theme)
  addAmmoIcon(theme, 'setAmmoSprite', ammoType, sprite)
end

--[[------------------------------------------------------------------
  Adds a sprite as an ammunition icon.
  @param {string} ammunition type
  @param {number} texture ID of the icon
  @param {number} width
  @param {number} height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.addTexture(ammoType, texture, w, h, theme)
  addAmmoIcon(theme, 'addAmmoTexture', ammoType, texture, w, h)
end

--[[------------------------------------------------------------------
  Whether the given ammunition icon exists.
  @param {string} ammunition type
  @param {THEME_|nil} theme to look up the icon from
  @return {boolean} has ammunition type
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.has(ammoType, theme)
  return GSRCHUD.theme.get(theme or GSRCHUD.config.getTheme()).ammo[ammoType] or GSRCHUD.theme.default().ammo[ammoType]
end

--[[------------------------------------------------------------------
  Returns the size of the given ammunition icon.
  @param {string} ammunition type
  @param {THEME_|nil} theme to look into
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.getSize(ammoType, theme)
  local _theme = GSRCHUD.theme.get(theme)
  local icon = _theme.ammo[ammoType] or GSRCHUD.theme.default().ammo[ammoType] or _theme.ammo[DEFAULT_AMMO] or GSRCHUD.theme.default().ammo[DEFAULT_AMMO]
  if not icon then return 0, 0 end
  if icon.isSprite then
    return GSRCHUD.sprite.getSize(icon.sprite)
  else
    return icon.w, icon.h
  end
end

--[[------------------------------------------------------------------
  Draws the given ammunition's icon.
  @param {number} x
  @param {number} y
  @param {string} ammunition type
  @param {number|nil} highlighting amount
  @param {Color|boolean|nil} colour
  @param {TEXT_ALIGN_LEFT|TEXT_ALIGN_CENTER|TEXT_ALIGN_RIGHT|nil} horizontal alignment
  @param {TEXT_ALIGN_BOTTOM|TEXT_ALIGN_CENTER|TEXT_ALIGN_TOP|nil} vertical alignment
  @param {number|nil} scale
  @param {number|nil} alpha component
  @param {THEME_|nil} theme to draw this icon from
  @return {number} icon width
  @return {number} icon height
]]--------------------------------------------------------------------
function GSRCHUD.ammunition.draw(x, y, ammoType, highlight, colour, halign, valign, scale, alpha, theme)
  theme = theme or GSRCHUD.config.getTheme()
  local _theme = GSRCHUD.theme.get(theme)
  local icon = _theme.ammo[ammoType] or GSRCHUD.theme.default().ammo[ammoType] or _theme.ammo[DEFAULT_AMMO] or GSRCHUD.theme.default().ammo[DEFAULT_AMMO]
  if not icon then return end

  -- draw icon
  if icon.isSprite then
    return GSRCHUD.sprite.drawTwin(icon.sprite, x, y, highlight, colour, halign, valign, scale, alpha, theme)
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

    -- draw base texture
    surface.SetDrawColor(GSRCHUD.sprite.colour(colour))
    surface.SetTexture(icon.texture)
    surface.DrawTexturedRect(x, y, w, h)

    -- simulate twin sprite drawing
    if highlight and highlight > 0 then
      surface.SetDrawColor(GSRCHUD.sprite.colour(colour))
      surface.SetTexture(icon.texture)
      surface.DrawTexturedRect(x, y, w, h)
    end

    return w, h
  end
end
