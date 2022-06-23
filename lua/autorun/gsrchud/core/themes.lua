--[[------------------------------------------------------------------
  Backwards compatibility with version 1
]]--------------------------------------------------------------------

GSRCHUD.theme = {} -- namespace

local DEFAULT_COLOUR, DEFAULT_CRITICAL_COLOUR = Color(255, 160, 0), Color(255, 0, 0)

local HOOK_THEME = 'GetTheme'

local themes = {} -- registered themes
local default -- default theme

local THEME = { -- prototype
  children = {}, -- which themes use this one as a base
  textures = {},
  sprites = {},
  colour = DEFAULT_COLOUR,
  critColour = DEFAULT_CRITICAL_COLOUR,
  elements = {},
  ammo = {},
  weapons = {},
  items = {},
  hazards = {}
}

--[[------------------------------------------------------------------
  Sets the default drawing colour.
  @param {Color} colour
]]--------------------------------------------------------------------
function THEME:setColour(colour)
  self.colour = colour
end

--[[------------------------------------------------------------------
  Sets the default drawing critical status colour.
  @param {Color} colour
]]--------------------------------------------------------------------
function THEME:setCriticalColour(colour)
  self.critColour = colour
end

--[[------------------------------------------------------------------
  Sets the default alpha colour component.
  @param {number} alpha
]]--------------------------------------------------------------------
function THEME:setDefaultAlpha(alpha)
  self.alpha = alpha
end

--[[------------------------------------------------------------------
  Adds a texture file to be used by sprites.
  @param {string} texture name
  @param {number} texture identifier
  @param {number} file width
  @param {number} file height
]]--------------------------------------------------------------------
function THEME:addTexture(name, texture, w, h)
  self.textures[name] = {texture = texture, w = w, h = h}

  -- add to children
  for _, child in pairs(self.children) do
    child:addTexture(name, texture, w, h)
  end
end

--[[------------------------------------------------------------------
  Adds a sprite to the theme.
  @param {string} sprite name
  @param {string} texture name
  @param {number} sprite's x position in the file
  @param {number} sprite's y position in the file
  @param {number} sprite's width
  @param {number} sprite's height
]]--------------------------------------------------------------------
function THEME:addSprite(sprite, texture, u, v, w, h)
  self.sprites[sprite] = {texture = texture, u = u, v = v, w = w, h = h}

  -- add to children
  for _, child in pairs(self.children) do
    child:addSprite(sprite, texture, u, v, w, h)
  end
end

--[[------------------------------------------------------------------
  Uses already defined sprites as weapon icons.
  @param {string} weapon class
  @param {string} sprite to use as the idle icon
  @param {string} sprite to use as the selected icon
  @param {boolean} whether the icon/s do not have a background (will render one)
]]--------------------------------------------------------------------
function THEME:setWeaponSprite(class, idle, selected, noBackground)
  self.weapons[class] = {
    idle = idle,
    selected = selected,
    noBackground = noBackground,
    isSprite = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:setWeaponSprite(class, idle, selected, noBackground)
  end
end

--[[------------------------------------------------------------------
  Makes a weapon use the same sprites (and background logic) than another weapon.
  @param {string} weapon class
  @param {string} class of the weapon to take the sprites from
]]--------------------------------------------------------------------
function THEME:inheritWeaponSprite(class, sprited_class)
  self.weapons[class] = sprited_class

  -- add to children
  for _, child in pairs(self.children) do
    child:inheritWeaponSprite(class, sprited_class)
  end
end

--[[------------------------------------------------------------------
  Generates a sprite to use as a weapon icon.
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
]]--------------------------------------------------------------------
function THEME:addWeaponSprite(class, spriteData, noBackground)
  local selected = class .. '_s'

  -- create sprites
  self:addSprite(class, spriteData.weapon[1], spriteData.weapon[2], spriteData.weapon[3], spriteData.weapon[4], spriteData.weapon[5])

  -- default to idle if no selected icon is provided
  if spriteData.weapon_s then
    self:addSprite(selected, spriteData.weapon_s[1], spriteData.weapon_s[2], spriteData.weapon_s[3], spriteData.weapon_s[4], spriteData.weapon_s[5])
  else
    selected = class
  end

  -- link sprites
  self:setWeaponSprite(class, class, selected, noBackground)

  -- add to children
  for _, child in pairs(self.children) do
    child:addWeaponSprite(class, spriteData, noBackground)
  end
end

--[[------------------------------------------------------------------
  Adds two textures as a weapon icon.
  @param {string} weapon class
  @param {number} texture ID of the icon as idle
  @param {number} texture ID of the icon as selected
  @param {number} texture width
  @param {number} texture height
  @param {boolean} whether the icon does not have a background (will render one)
]]--------------------------------------------------------------------
function THEME:addWeaponTexture(class, idle, selected, w, h, noBackground)
  self.weapons[class] = {
    idle = idle,
    selected = selected,
    w = w,
    h = h,
    noBackground = noBackground,
    isTexture = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addWeaponTexture(class, idle, selected, w, h, noBackground)
  end
end

--[[------------------------------------------------------------------
  Adds two textures as a weapon icon.
  @param {string} weapon class
  @param {table} icons data
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
]]--------------------------------------------------------------------
function THEME:addWeaponTextureUV(class, iconsData, noBackground)
  self.weapons[class] = {
    data = iconsData,
    noBackground = noBackground,
    isTextureUV = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addWeaponTextureUV(class, iconsData, noBackground)
  end
end

--[[------------------------------------------------------------------
  Adds a function to be called when asking for this weapon's icon.
  @param {string} weapon class
  @param {function} drawing function
]]--------------------------------------------------------------------
function THEME:addWeaponDynamicIcon(class, func)
  self.weapons[class] = {
    isDynamic = true,
    func = func
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addWeaponDynamicIcon(class, func)
  end
end

--[[------------------------------------------------------------------
  Uses a sprite as an ammunition icon.
  @param {string} ammunition type
  @param {string} sprite
]]--------------------------------------------------------------------
function THEME:setAmmoSprite(ammoType, sprite)
  self.ammo[ammoType] = {
    sprite = sprite,
    isSprite = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:setAmmoSprite(ammoType, sprite)
  end
end

--[[------------------------------------------------------------------
  Adds a sprite as an ammunition icon.
  @param {string} ammunition type
  @param {string} texture name
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
]]--------------------------------------------------------------------
function THEME:addAmmoSprite(ammoType, texture, u, v, w, h)
  local name = 'ammo_' .. ammoType
  self:addSprite(name, texture, u, v, w, h)
  self:setAmmoSprite(ammoType, name)

  -- add to children
  for _, child in pairs(self.children) do
    child:addAmmoSprite(ammoType, texture, u, v, w, h)
  end
end

--[[------------------------------------------------------------------
  Adds a texture as an ammunition icon.
  @param {string} ammunition type
  @param {number} texture ID
  @param {number} width
  @param {number} height
]]--------------------------------------------------------------------
function THEME:addAmmoTexture(ammoType, texture, w, h)
  self.ammo[ammoType] = {
    texture = texture,
    w = w,
    h = h,
    isTexture = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addAmmoTexture(ammoType, texture, w, h)
  end
end

--[[------------------------------------------------------------------
  Sets an already existing sprite as the icon for the given item.
  @param {string} item class
  @param {string} sprite
]]--------------------------------------------------------------------
function THEME:setItemSprite(item, sprite)
  self.items[item] = {
    sprite = sprite,
    isSprite = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:setItemSprite(item, sprite)
  end
end

--[[------------------------------------------------------------------
  Adds a sprite as an item icon.
  @param {string} ammunition type
  @param {string} texture name
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
]]--------------------------------------------------------------------
function THEME:addItemSprite(item, texture, u, v, w, h)
  local name = 'item_' .. item
  self:addSprite(name, texture, u, v, w, h)
  self:setItemSprite(item, name)

  -- add to children
  for _, child in pairs(self.children) do
    child:addItemSprite(item, texture, u, v, w, h)
  end
end

--[[------------------------------------------------------------------
  Adds a texture as an item icon.
  @param {string} item class
  @param {number} texture ID
  @param {number} width
  @param {number} height
]]--------------------------------------------------------------------
function THEME:addItemTexture(item, texture, w, h)
  self.items[item] = {
    texture = texture,
    w = w,
    h = h,
    isTexture = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addItemTexture(item, texture, w, h)
  end
end

--[[------------------------------------------------------------------
  Sets an already existing sprite as the icon for a damage type.
  @param {DMG_} damage type
  @param {string} sprite
]]--------------------------------------------------------------------
function THEME:setHazardSprite(hazard, sprite)
  self.hazards[hazard] = {
    sprite = sprite,
    isSprite = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:setHazardSprite(hazard, sprite)
  end
end

--[[------------------------------------------------------------------
  Adds a sprite as a damage type icon.
  @param {DMG_} damage type
  @param {string} texture name
  @param {number} x position in file
  @param {number} y position in file
  @param {number} sprite width
  @param {number} sprite height
]]--------------------------------------------------------------------
function THEME:addHazardSprite(hazard, texture, u, v, w, h)
  local name = 'dmg_' .. hazard
  self:addSprite(name, texture, u, v, w, h)
  self:setHazardSprite(hazard, name)

  -- add to children
  for _, child in pairs(self.children) do
    child:addHazardSprite(hazard, texture, u, v, w, h)
  end
end

--[[------------------------------------------------------------------
  Adds a texture as a hazard icon.
  @param {DMG_} damage type
  @param {number} texture ID
  @param {number} width
  @param {number} height
]]--------------------------------------------------------------------
function THEME:addHazardTexture(hazard, texture, w, h)
  self.hazards[hazard] = {
    texture = texture,
    w = w,
    h = h,
    isTexture = true
  }

  -- add to children
  for _, child in pairs(self.children) do
    child:addHazardTexture(hazard, texture, w, h)
  end
end

--[[------------------------------------------------------------------
  Adds a function ran before an element's draw call, allowing for parametrization.
  @param {string} element identifier
  @param {function} pre draw function
]]--------------------------------------------------------------------
function THEME:addPreDraw(element, func)
  self.elements[element] = func
end

--[[------------------------------------------------------------------
  Creates a new theme table and registers it as the default theme.
  @param {string} default theme name
  @param {table} theme data
  @return {number} default theme enumerator
]]--------------------------------------------------------------------
function GSRCHUD.theme.registerDefault(name, theme)
  default = theme
  return GSRCHUD.theme.register(name, theme)
end

--[[------------------------------------------------------------------
  Creates a new theme table and returns it.
  @param {THEME_|nil} what theme should it derive from
  @return {table} theme data
]]--------------------------------------------------------------------
function GSRCHUD.theme.create(baseClass)
  if baseClass and GSRCHUD.theme.get(baseClass) then
    local theme = table.Copy(GSRCHUD.theme.get(baseClass))
    theme.baseClass = baseClass -- store base class
    theme.name = nil -- clear base theme name
    return theme
  else
    return table.Copy(THEME)
  end
end

--[[------------------------------------------------------------------
  Registers the given theme.
  @param {string} name
  @param {table} theme data
  @return {THEME_} theme position in table
]]--------------------------------------------------------------------
function GSRCHUD.theme.register(name, theme)
  -- add to the tool menu
  GSRCHUD.toolmenu.registerTheme(#themes + 1, name)

  -- add name
  theme.name = name

  -- add to list
  local enum = table.insert(themes, theme)

  -- add to base class's children list
  if theme.baseClass then
    GSRCHUD.theme.get(theme.baseClass).children[enum] = theme
  end

  return enum
end

--[[------------------------------------------------------------------
  Returns the default theme's data
  @return {table} default theme data
]]--------------------------------------------------------------------
function GSRCHUD.theme.default()
  return default
end

--[[------------------------------------------------------------------
  Returns a theme's data
  @param {THEME_} theme
  @return {table} theme's data
]]--------------------------------------------------------------------
function GSRCHUD.theme.get(theme)
	if not theme then return default end
	return themes[theme] or default
end

--[[------------------------------------------------------------------
  Returns the theme currently used by the user.
	@return {THEME_} theme
]]--------------------------------------------------------------------
function GSRCHUD.theme.used()
	return GSRCHUD.hook.run(HOOK_THEME) or GSRCHUD.config.getTheme()
end

--[[------------------------------------------------------------------
  Returns all available themes (plus default)
  @return {table} themes
  @return {table} default theme
]]--------------------------------------------------------------------
function GSRCHUD.theme.all()
  return themes, default
end
