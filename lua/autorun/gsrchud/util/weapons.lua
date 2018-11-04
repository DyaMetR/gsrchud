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
    @param {boolean|null} isSprite
    @param {boolean|null} notSlotSized
    @void
  ]]
  function GSRCHUD:AddWeaponIcon(weapon, texture, notSlotSized)
    notSlotSized = notSlotSized or false;
    self.Weapons[weapon] = {texture = texture, notSlotSized = notSlotSized};
  end

  --[[
    Returns the texture according to the weapon selected
    @param {string} weapon
    @return {string} texture
  ]]
  function GSRCHUD:GetWeaponIcon(weapon)
    return self.Weapons[weapon].texture or nil;
  end

  --[[
    Returns whether the texture has the dimensions of a weapon slot
    @param {string} weapon
    @return {boolean} isSlotSized
  ]]
  function GSRCHUD:IsIconNotSlotSized(weapon)
    return self.Weapons[weapon].notSlotSized or false;
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
