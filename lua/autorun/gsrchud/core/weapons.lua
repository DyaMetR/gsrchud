--[[------------------------------------------------------------------
  Weapon icons rendering.
]]--------------------------------------------------------------------

GSRCHUD.weapon = {} -- namespace

local BUCKET = 'bucket'
local MISSING_ICON = '%s icon'
local DEFAULT_ALPHA = 255

--[[------------------------------------------------------------------
  Base function for adding new weapon icons.
]]--------------------------------------------------------------------
local function addWeaponIcon(theme, func, class, ...)
  local _theme = GSRCHUD.theme.get(theme)

  -- warn if there's already a sprite with this name in the given theme
  if _theme.weapons[class] then
    GSRCHUD.print(string.format('Weapon "%s" had already an icon set in theme "%s" and has been overridden.', class, _theme.name), GSRCHUD.log.WARN)
  end

  -- add weapon icon to theme
  _theme[func](_theme, class, ...)
end

--[[------------------------------------------------------------------
  Adds a sprite as a weapon icon.
  @param {string} weapon class
  @param {table} sprites data
    - weapon: idle sprite
    - weapon_s: selected sprite
      - texture name
      - x position in file
      - y position in file
      - sprite width
      - sprite height
  @param {boolean} whether the icon does not have a background (will render one)
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.addSprite(class, spriteData, noBackground, theme)
  addWeaponIcon(theme, 'addWeaponSprite', class, spriteData, noBackground)
end

--[[------------------------------------------------------------------
  Uses already defined sprites as weapon icons.
  @param {string} weapon class
  @param {string} sprite for the idle icon
  @param {string} sprite for the selected icon
  @param {boolean} whether the icon does not have a background (will render one)
  @param {THEME_|nil} theme to apply this to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.setSprite(class, idle, selected, noBackground, theme)
  addWeaponIcon(theme, 'setWeaponSprite', class, idle, selected, noBackground)
end

--[[------------------------------------------------------------------
  Makes a weapon use the same sprites (and background logic) than another weapon.
  @param {string} weapon class
  @param {string} class of the weapon to take the sprites from
  @param {THEME_|nil} theme to apply this to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.inheritSprite(class, sprited_class, theme)
  -- if no theme was specified, add inheritance to all themes that have uninherited sprites
  if not theme then
    for _, _theme in pairs(GSRCHUD.theme.all()) do
      local sprite = _theme.weapons[class]
      if not sprite or isstring(sprite) then continue end
      _theme.weapons[class] = sprited_class
    end
  end

  -- add to given theme (or default)
  addWeaponIcon(theme, 'inheritWeaponSprite', class, sprited_class)
end

--[[------------------------------------------------------------------
  Adds a sprite as a weapon icon.
  @param {string} weapon class
  @param {number} texture ID of the icon as idle
  @param {number} texture ID of the icon as selected
  @param {number} width
  @param {number} height
  @param {boolean} whether the icon does not have a background (will render one)
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.addTexture(class, idle, selected, w, h, noBackground, theme)
  addWeaponIcon(theme, 'addWeaponTexture', class, idle, selected, w, h, noBackground)
end

--[[------------------------------------------------------------------
  Adds a sprite as a weapon icon.
  @param {string} weapon class
  @param {table} icon data
    - weapon: idle icon
    - weapon_s: selected icon
      - texture ID
      - file width
      - file height
      - x position in file
      - y position in file
      - icon width
      - icon height
  @param {boolean} whether the icon does not have a background (will render one)
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.addTextureUV(class, iconData, noBackground, theme)
  addWeaponIcon(theme, 'addWeaponTextureUV', class, iconData, noBackground)
end

--[[------------------------------------------------------------------
  Adds a function to be called when asking for this weapon's icon.
  @param {string} weapon class
  @param {function} drawing function
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.addDynamicIcon(class, func, theme)
  addWeaponIcon(theme, 'addWeaponDynamicIcon', class, func)
end

--[[------------------------------------------------------------------
  Draws the given weapon icon.
  @param {number} x
  @param {number} y
  @param {Weapon} weapon entity
  @param {boolean} should show the 'selected' icon
  @param {Color|boolean|nil} colour
  @param {number|nil} scale
  @param {number|nil} alpha component
  @param {THEME_|nil} theme to add this icon to
]]--------------------------------------------------------------------
function GSRCHUD.weapon.draw(x, y, weapon, selected, colour, scale, alpha, theme)
  if not IsValid(weapon) then return end -- do not draw if the weapon isn't valid
  scale = scale or GSRCHUD.sprite.scale()
  alpha = alpha or DEFAULT_ALPHA
  theme = theme or GSRCHUD.config.getTheme()
  local _theme = GSRCHUD.theme.get(theme)
  local class = weapon:GetClass()
  local icon = _theme.weapons[class] or GSRCHUD.theme.default().weapons[class]

  -- check if the icon was inherited from another weapon
  if icon and isstring(icon) then
    icon = _theme.weapons[icon] or GSRCHUD.theme.default().weapons[icon]
  end

  -- draw background
  if not icon or icon.noBackground then
    GSRCHUD.sprite.draw(BUCKET, x, y, colour, nil, nil, scale, alpha, theme)
  end

  -- get frame size
  local frameW, frameH = GSRCHUD.sprite.getSize(BUCKET, scale, theme)

  -- limit any weapon icon to the bucket's size
  render.SetScissorRect(x, y, x + frameW, y + frameH, true)

  -- if no icon is present, draw the original icon
  if not icon then
    local w, h = 128 * scale, 96 * scale

    -- draw the weapon's name if they have no icon
    if not weapon.DrawWeaponSelection then
      local name = weapon:GetClass() -- default to class
      if weapon.GetPrintName then name = weapon:GetPrintName() end -- fail-proof printname retrieving
      draw.SimpleText(string.format(MISSING_ICON, language.GetPhrase(name)), 'default', x + frameW * .5, y + frameH * .5, GSRCHUD.sprite.colour(colour, theme), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else -- otherwise, draw the icon
      -- disable bouncy icon
      local bounce = weapon.BounceWeaponIcon
      weapon.BounceWeaponIcon = false

      -- draw icon
      weapon:DrawWeaponSelection(x + (frameW * .5) - (w * .5), y + (frameH * .5) - (h * .4), w, h, alpha or DEFAULT_ALPHA)

      -- restore bouncy icon
      weapon.BounceWeaponIcon = bounce
    end
  else -- otherwise, search for the correct icon
    if icon.isSprite then
      local sprite = icon.idle
      if selected then sprite = icon.selected end
      GSRCHUD.sprite.draw(sprite, x + frameW * .5, y + frameH * .5, colour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, scale, alpha, theme)
    elseif icon.isDynamic then
      icon.func(x + frameW * .5, y + frameH * .5, weapon, selected, colour, scale, alpha, theme)
    else
      local _alpha = surface.GetAlphaMultiplier()
      surface.SetAlphaMultiplier(alpha / 255)
      if icon.isTextureUV then
        local texture, fileW, fileH, u, v, _w, _h
        if not selected then
          texture, fileW, fileH, u, v, _w, _h = unpack(icon.data.weapon)
        else
          texture, fileW, fileH, u, v, _w, _h = unpack(icon.data.weapon_s)
        end
        local w, h = _w * scale, _h * scale
        surface.SetTexture(texture)
        surface.SetDrawColor(GSRCHUD.sprite.colour(colour))
        surface.DrawTexturedRect(x + (frameW * .5) - (w * .5), y + (frameH * .5) - (h * .5), w, h, u/fileW, v/fileH, (u + _w)/fileW, (v + _h)/fileH)
      else
        local texture = icon.idle
        if selected then texture = icon.selected end
        local w, h = icon.w * scale, icon.h * scale
        surface.SetTexture(texture)
        surface.SetDrawColor(GSRCHUD.sprite.colour(colour))
        surface.DrawTexturedRect(x + (frameW * .5) - (w * .5), y + (frameH * .5) - (h * .5), w, h)
      end
      surface.SetAlphaMultiplier(_alpha)
    end
  end

  -- end scissor rect
  render.SetScissorRect(0, 0, 0, 0, false)
end

--[[------------------------------------------------------------------
  Retrieves the primary and secondary ammunition amounts
  @param {Weapon} weapon
  @return {boolean} is ammunition data valid
  @return {number} primary ammunition type
  @return {number} secondary ammunition type
  @return {number} clip ammunition amount
  @return {number} primary reserve ammunition
  @return {number} secondary ammunition
]]--------------------------------------------------------------------
function GSRCHUD.weapon.ammo(weapon)
  local localPlayer = GSRCHUD.localPlayer()
  local isValid = true

  -- select ammunition types
  local clip1, primary, secondary = weapon:Clip1(), weapon:GetPrimaryAmmoType(), weapon:GetSecondaryAmmoType()
  local reserve, alt = localPlayer:GetAmmoCount(primary), localPlayer:GetAmmoCount(secondary)

  -- check for custom ammo display
  if weapon.CustomAmmoDisplay and weapon:CustomAmmoDisplay() then
    local ammoData = weapon:CustomAmmoDisplay()

    -- do not draw if the custom ammo display is disabled
    if not ammoData.Draw then
      isValid = false
    end

    -- get ammunition data
    clip1 = ammoData.PrimaryClip or -1
    reserve = ammoData.PrimaryAmmo or -1
    alt = ammoData.SecondaryAmmo or -1

    -- if reserve is unavailable, show clip instead
    if reserve <= -1 then
      reserve = clip1
      clip1 = -1
    end
  else
    -- check if secondary ammunition is the only valid type
    if primary <= 0 and secondary > 0 then
      primary = secondary
      reserve = alt
      clip1 = -1
      secondary = -1
      alt = -1
    end

    -- do not draw if both ammo types are invalid
    if primary <= 0 and secondary <= 0 then
      isValid = false
    end
  end

  return isValid, primary, secondary, clip1, reserve, alt
end
