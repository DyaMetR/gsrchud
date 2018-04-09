--[[
  WEAPONS ICONS
]]

if CLIENT then

  -- Weapon icons list
  GSRCHUD.Weapons = {};

  -- Methods
  --[[
    Returns the weapons icons list
    @return GSRCHUD.Weapons
  ]]
  function GSRCHUD:GetWeaponIcons()
    return self.Weapons;
  end

  --[[
    Adds a texture to the list
    @param {string} weapon
    @param {string} texture
    @void
  ]]
  function GSRCHUD:AddWeaponIcon(weapon, texture)
    self.Weapons[weapon] = texture;
  end

  --[[
    Returns the texture according to the weapon selected
    @param {string} weapon
    @return {string} texture
  ]]
  function GSRCHUD:GetWeaponIcon(weapon)
    return self.Weapons[weapon] or nil;
  end

  --[[
    Returns whether there's a predefined weapon icon for the given weapon
    @param {string} weapon
    @return {boolean} hasIcon
  ]]
  function GSRCHUD:HasWeaponIcon(weapon)
    return self.Weapons[weapon] ~= nil;
  end
end
