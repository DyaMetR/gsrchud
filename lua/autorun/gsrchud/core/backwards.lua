--[[------------------------------------------------------------------
  Backwards compatibility with version 1

  All methods from version 1 are considered deprecated and will be advised against.
  However, we'll enable backwards compatibility to not break any mods that
  may depend on it (e.g. Half-Life Co-op, etc.)
]]--------------------------------------------------------------------

local DEPRECATED = '%s is deprecated! Use %s instead.'
local THEME_ICONS = '%s is deprecated since each theme can hold their own icons now.'
local UNUSED = '%s is no longer in use.'
local HOOKS = '%s is deprecated since it has been replaced by the hooks system.'

local warnings = {} -- accumulate warnings to not spam the console

-- send warning to the console
local function warning(method, message)
  if warnings[method] or not GSRCHUD.config.getConsoleWarn() then return end
  GSRCHUD.print(message, GSRCHUD.log.WARN)
  warnings[method] = true
end

-- send warning to the console about a deprecated method
local function deprecated(old, new)
  warning(old, string.format(DEPRECATED, old, new))
end

-- send warning to the console about deprecated method by the new theme system
local function themeDeprecation(method)
  warning(method, string.format(THEME_ICONS, method))
end

-- send warning to the console about an unused method
local function unused(method)
  warning(method, string.format(UNUSED, method))
end

-- send warning to the console about a deprecated method by the new hooks system
local function hook(method)
  warning(method, string.format(HOOKS, method))
end

GSRCHUD.DefaultConfig = {
  DefaultTheme = GSRCHUD.THEME_HALFLIFE
}

function GSRCHUD:IsEnabled()
  deprecated('GSRCHUD:IsEnabled', 'GSRCHUD.isEnabled')
  return GSRCHUD.isEnabled()
end

function GSRCHUD:GetCurrentTheme()
  deprecated('GSRCHUD:GetCurrentTheme', 'GSRCHUD.getCurrentTheme')
  return GSRCHUD.getCurrentTheme()
end

function GSRCHUD:GetThemeDefaultColor(theme)
  deprecated('GSRCHUD:GetThemeDefaultColor', 'GSRCHUD.getCurrentColour')
  return GSRCHUD.getCurrentColour()
end

function GSRCHUD:GetAmmoIcons()
  themeDeprecation('GSRCHUD:GetAmmoIcons')
  return GSRCHUD.theme.default().ammo
end

function GSRCHUD:AddAmmoIcon(ammoType, sprite)
  deprecated('GSRCHUD:AddAmmoIcon', 'GSRCHUD.ammunition.setSprite')
  if GSRCHUD.ammunition.has(ammoType) then return end
  GSRCHUD.ammunition.setSprite(ammoType, sprite)
end

function GSRCHUD:GetAmmoIcon(ammoType)
  themeDeprecation('GSRCHUD:GetAmmoIcon')
  return GSRCHUD.theme.default().ammo[ammoType]
end

function GSRCHUD:GetWeaponIcons()
  themeDeprecation('GSRCHUD:GetWeaponIcons')
  return GSRCHUD.theme.default().weapons
end

function GSRCHUD:AddWeaponIcon(weapon, texture, notSlotSized)
  themeDeprecation('GSRCHUD:AddWeaponIcon')
  if GSRCHUD.theme.default().weapons[weapon] then return end
  GSRCHUD.weapon.setSprite(weapon, texture, texture)
end

function GSRCHUD:GetWeaponIcon(weapon)
  themeDeprecation('GSRCHUD:GetWeaponIcon')
  return GSRCHUD.theme.default().weapons[weapon]
end

function GSRCHUD:IsIconNotSlotSized(weapon)
  unused('GSRCHUD:IsIconNotSlotSized')
  return false
end

function GSRCHUD:HasWeaponIcon(weapon)
  themeDeprecation('GSRCHUD:HasWeaponIcon')
  return GSRCHUD.theme.default().weapons[weapon] ~= nil
end

function GSRCHUD:AddHazard(dmgType, sprite)
  themeDeprecation('GSRCHUD:AddHazard')
  return GSRCHUD.hazard.setSprite(dmgType, sprite)
end

function GSRCHUD:AddHazardCustomSprite(dmgType, customSprite)
  themeDeprecation('GSRCHUD:AddHazardCustomSprite')
  return GSRCHUD.hazard.setSprite(dmgType, customSprite)
end

function GSRCHUD:GetHazard(dmgType)
  themeDeprecation('GSRCHUD:GetHazard')
  return GSRCHUD.theme.default().hazards[dmgType]
end

function GSRCHUD:HasHazardCustomSprite(dmgType)
  themeDeprecation('GSRCHUD:HasHazardCustomSprite')
  return GSRCHUD.theme.default().hazards[dmgType]
end

function GSRCHUD:GetHazards()
  themeDeprecation('GSRCHUD:GetHazards')
  return GSRCHUD.theme.default().hazards
end

function GSRCHUD:IsValidHazard(dmgType)
  themeDeprecation('GSRCHUD:IsValidHazard')
  return GSRCHUD.theme.default().hazards[dmgType] ~= nil
end

function GSRCHUD:AddItemSprite(class, sprite)
  themeDeprecation('GSRCHUD:AddItemSprite')
  return GSRCHUD.theme.default():setItemSprite(class, sprite)
end

function GSRCHUD:GetItemSprite(class)
  themeDeprecation('GSRCHUD:GetItemSprite')
  return GSRCHUD.theme.default().items[class]
end

function GSRCHUD:DrawWeaponIcon(x, y, weapon, scale, alpha)
  deprecated('GSRCHUD:DrawWeaponIcon', 'GSRCHUD.weapon.draw')
  GSRCHUD.weapon.draw(x, y, weapon, nil, nil, scale, alpha)
end

function GSRCHUD:DrawWeaponIconFromSpritesheet(x, y, weapon, scale, alpha, crit)
  deprecated('GSRCHUD:DrawWeaponIconFromSpritesheet', 'GSRCHUD.weapon.draw')
  GSRCHUD.weapon.draw(x, y, weapon, nil, crit, scale, alpha)
end

function GSRCHUD:DrawDefaultWeaponIcon(x, y, weapon, scale, alpha, crit)
  deprecated('GSRCHUD:DrawDefaultWeaponIcon', 'GSRCHUD.weapon.draw')
  GSRCHUD.weapon.draw(x, y, weapon, nil, crit, scale, alpha)
end

function GSRCHUD:DrawWeaponSlot(x, y, weapon, scale, alpha, selected, crit)
  deprecated('GSRCHUD:DrawWeaponSlot', 'GSRCHUD.weapon.draw')
  GSRCHUD.weapon.draw(x, y, weapon, selected, crit, scale, alpha)
end

function GSRCHUD:DrawAmmoIcon(x, y, ammo, amount, scale, alpha)
  unused('GSRCHUD:DrawAmmoIcon')
end

function GSRCHUD:AddWeaponSpritesheet(weapon, texture, fileW, fileH, x, y, w, h)
  themeDeprecation('GSRCHUD:AddWeaponSpritesheet')
  if GSRCHUD.theme.default().weapons[weapon] then return end
  local data = {texture, fileW, fileH, x or 0, y or 0, w or fileW, h or fileH}
  GSRCHUD.weapon.addTextureUV(weapon, {weapon = data, weapon_s = data}, true)
end

function GSRCHUD:GetWeaponSpritesheet(weapon)
  themeDeprecation('GSRCHUD:GetWeaponSpritesheet')
  return GSRCHUD.theme.default().weapons[weapon]
end

function GSRCHUD:GetWeaponSpritesheet(weapon)
  themeDeprecation('GSRCHUD:HasWeaponSpritesheet')
  return GSRCHUD.theme.default().weapons[weapon] ~= nil
end

function GSRCHUD:AddTheme(name, color, critColor, spriteData, ammoData, script)
  warning('GSRCHUD:AddTheme', string.format('Attempted to add an unsupported theme (%s). Refer to the documentation to know how to add themes.', name))
end

function GSRCHUD:GetThemes()
  deprecated('GSRCHUD:GetThemes', 'GSRCHUD.theme.all')
  return GSRCHUD.theme.all()
end

function GSRCHUD:GetTheme(theme)
  deprecated('GSRCHUD:GetTheme', 'GSRCHUD.theme.get')
  return GSRCHUD.theme.get(theme)
end

function GSRCHUD:GetThemeSprite(theme, sprite)
  unused('GSRCHUD:GetThemeSprite')
  return GSRCHUD.theme.get(theme).sprites[sprite]
end

function GSRCHUD:GetThemeDefaultColor(theme)
  unused('GSRCHUD:GetThemeDefaultColor')
  return GSRCHUD.theme.get(theme).colour
end

function GSRCHUD:GetThemeDefaultCritColor(theme)
  unused('GSRCHUD:GetThemeDefaultCritColor')
  return GSRCHUD.theme.get(theme).critColour
end

function GSRCHUD:GetThemeAmmoIcons(theme)
  unused('GSRCHUD:GetThemeAmmoIcons')
  return GSRCHUD.theme.get(theme).ammo
end

function GSRCHUD:GetThemeCustomScript(theme)
  unused('GSRCHUD:GetThemeCustomScript')
  return
end

function GSRCHUD:AddNumber(id, value)
  warning('GSRCHUD:AddNumber', string.format('Attempted creating a number (%s) using the old methods which are unsupported. Refer to the documentation to know how to use numbers.'))
end

function GSRCHUD:GetNumbers()
  unused('GSRCHUD:GetNumbers')
  return
end

function GSRCHUD:GetNumber(id)
  unused('GSRCHUD:GetNumber')
  return
end

function GSRCHUD:NumberExists(id)
  unused('GSRCHUD:NumberExists')
  return false
end

function GSRCHUD:SetCustomNumberCrit(id, crit)
  unused('GSRCHUD:SetCustomNumberCrit')
end

function GSRCHUD:ClearCustomNumberCrit()
  unused('GSRCHUD:ClearCustomNumberCrit')
end

function GSRCHUD:GetCustomNumberCrit()
  unused('GSRCHUD:GetCustomNumberCrit')
  return
end

function GSRCHUD:UpdateNumber()
  unused('GSRCHUD:UpdateNumber')
end

function GSRCHUD:RenderNumber(x, y, value, scale, crit, alpha, small, color)
  unused('GSRCHUD:RenderNumber')
end

function GSRCHUD:DrawNumber(x, y, id, value, scale, crit, alpha, color)
  unused('GSRCHUD:DrawNumber')
end

function GSRCHUD:SetNumberAlpha(id, alpha)
  unused('GSRCHUD:SetNumberAlpha')
end

function GSRCHUD:GetNumberAlpha(id)
  unused('GSRCHUD:GetNumberAlpha')
  return 0
end

function GSRCHUD:AddCustomSprite(id, texture, fileW, fileH, x, y, w, h)
  themeDeprecation('GSRCHUD:AddCustomSprite')
  local name = 'backwards_' .. id
  GSRCHUD.sprite.addTexture(name, texture, fileW, fileH)
  GSRCHUD.sprite.add(id, name, x or 0, y or 0, w or fileW, h or fileH)
end

function GSRCHUD:GetCustomSprite(id)
  themeDeprecation('GSRCHUD:GetCustomSprite')
  return GSRCHUD.theme.default().sprites[id]
end

function GSRCHUD:HasCustomSprite(id)
  themeDeprecation('GSRCHUD:HasCustomSprite')
  return false
end

function GSRCHUD:RenderCustomSprite(id, x, y, scale, alpha, color, crit)
  themeDeprecation('GSRCHUD:RenderCustomSprite')
  GSRCHUD.sprite.draw(id, x, y, color or crit, nil, nil, scale, alpha)
end

function GSRCHUD:DrawCustomSprite(id, x, y, scale, alpha, color, crit, overlap)
  themeDeprecation('GSRCHUD:DrawCustomSprite')
  GSRCHUD.sprite.draw(id, x, y, color or crit, nil, nil, scale, alpha)
end

function GSRCHUD:AddGamemodeOverride(gamemode, func)
  hook('GSRCHUD:AddGamemodeOverride')
end

function GSRCHUD:AddSpectateBlock(gamemode)
  hook('GSRCHUD:AddSpectateBlock')
end

function GSRCHUD:AddDeathScreenOverride(gamemode)
  hook('GSRCHUD:AddDeathScreenOverride')
end

function GSRCHUD:AddElement(func)
  warning('GSRCHUD:AddElement', 'GSRCHUD:AddElement has been deprecated in favour of the new element creation system.')
  local ELEMENT = GSRCHUD.element.create()
  ELEMENT.draw = func
  GSRCHUD.element.register('backwards_' .. tostring(func), {}, ELEMENT, true)
end

function GSRCHUD:GetSpriteDimensions(sprite)
  deprecated('GSRCHUD:GetSpriteDimensions', 'GSRCHUD.sprite.getSize')
  return GSRCHUD.sprite.getSize(sprite)
end

function GSRCHUD:GetHUDScale()
  deprecated('GSRCHUD:GetHUDScale', 'GSRCHUD.sprite.scale')
  return GSRCHUD.sprite.scale()
end

function GSRCHUD:DrawSprite(x, y, sprite, scale, alpha, crit, scissor, color, limitOffset, overlap, hScissor, invHScis)
  deprecated('GSRCHUD:DrawSprite', 'GSRCHUD.sprite.draw')
  GSRCHUD.sprite.draw(sprite, x, y, color or crit, nil, nil, scale, alpha)
end
