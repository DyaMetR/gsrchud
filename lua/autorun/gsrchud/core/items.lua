--[[------------------------------------------------------------------
  Item icon rendering.
]]--------------------------------------------------------------------

GSRCHUD.item = {} -- namespace


--[[------------------------------------------------------------------
  Base function for adding new item icons.
]]--------------------------------------------------------------------
local function addItemIcon(theme, func, item, ...)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a sprite with this name in the given theme
  if _theme.items[item] then
    GSRCHUD.print(string.format('Item type "%s" had already an icon set in theme "%s" and has been overridden.', item, _theme.name), GSRCHUD.log.WARN)
  end

  -- add item icon to theme
  _theme[func](_theme, item, ...)
end

--[[------------------------------------------------------------------
  Adds a sprite as an item icon.
  @param {string} item class
  @param {number} texture ID
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.item.addSprite(item, texture, u, v, w, h, theme)
  addItemIcon(theme, 'addItemSprite', item, texture, u, v, w, h)
end

--[[------------------------------------------------------------------
  Uses already defined sprites as an item icon.
  @param {string} ammunition type
  @param {string} sprite
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.item.setSprite(item, sprite, theme)
  addItemIcon(theme, 'setItemSprite', item, sprite)
end

--[[------------------------------------------------------------------
  Adds a sprite as an item icon.
  @param {string} ammunition type
  @param {number} texture ID of the icon
  @param {number} width
  @param {number} height
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.item.addTexture(item, texture, w, h, theme)
  addItemIcon(theme, 'addItemTexture', item, texture, w, h)
end

--[[------------------------------------------------------------------
  Whether the given item icon exists.
  @param {string} item class
  @param {THEME_|nil} theme to look up the icon from
  @return {boolean} has ammunition type
]]--------------------------------------------------------------------
function GSRCHUD.item.has(item, theme)
  return GSRCHUD.theme.get(theme).items[item] or GSRCHUD.theme.default().items[item]
end

--[[------------------------------------------------------------------
  Returns the size of the given item icon.
  @param {string} item class
  @param {THEME_|nil} theme to look into
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
function GSRCHUD.item.getSize(item, theme)
  local _theme = GSRCHUD.theme.get(theme or GSRCHUD.config.getTheme())
  local icon = _theme.items[item] or GSRCHUD.theme.default().items[item]
  if not icon then return 0, 0 end
  if icon.isSprite then
    return GSRCHUD.sprite.getSize(icon.sprite)
  else
    return icon.w, icon.h
  end
end

--[[------------------------------------------------------------------
  Draws the given item's icon.
  @param {number} x
  @param {number} y
  @param {string} item class
  @param {Color|boolean|nil} colour
  @param {TEXT_ALIGN_LEFT|TEXT_ALIGN_CENTER|TEXT_ALIGN_RIGHT|nil} horizontal alignment
  @param {TEXT_ALIGN_BOTTOM|TEXT_ALIGN_CENTER|TEXT_ALIGN_TOP|nil} vertical alignment
  @param {number|nil} scale
  @param {number|nil} alpha component
  @param {THEME_|nil} theme to draw this icon from
  @return {number} icon width
  @return {number} icon height
]]--------------------------------------------------------------------
function GSRCHUD.item.draw(x, y, item, colour, halign, valign, scale, alpha, theme)
  theme = theme or GSRCHUD.config.getTheme()
  local _theme = GSRCHUD.theme.get(theme)
  local icon = _theme.items[item] or GSRCHUD.theme.default().items[item]
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
