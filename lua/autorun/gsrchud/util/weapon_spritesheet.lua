--[[
  WEAPONS SPRITESHEET ICONS
]]

if CLIENT then

  -- Weapon spritesheet list
  GSRCHUD.WeaponSpritesheet = {};

  -- Methods
  --[[
    Adds a weapon icon from a spritesheet
    @param {string} weapon
    @param {string} texture
    @param {number} fileW
    @param {number} fileH
    @param {number} x
    @param {number} y
    @param {number} w
    @param {number} h
    @void
  ]]
  function GSRCHUD:AddWeaponSpritesheet(weapon, texture, fileW, fileH, x, y, w, h)
    self.WeaponSpritesheet[weapon] = {texture = texture, fileW = fileW, fileH = fileH, x = x, y = y, w = w, h = h};
  end

  --[[
    Returns the spritesheet based icon data from a weapon
    @param {string} weapon
    @return {table} iconData
  ]]
  function GSRCHUD:GetWeaponSpritesheet(weapon)
    return self.WeaponSpritesheet[weapon];
  end

  --[[
    Returns whether the weapon has a spritesheet based icon
    @param {string} weapon
    @return {boolean} hasIcon
  ]]
  function GSRCHUD:HasWeaponSpritesheet(weapon)
    return self.WeaponSpritesheet[weapon] != nil;
  end

end
