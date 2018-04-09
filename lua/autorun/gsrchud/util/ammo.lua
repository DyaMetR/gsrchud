--[[
  AMMUNITION ICONS
]]

if CLIENT then

  -- Parameters
  local DEFAULT_AMMO_ICON = "Pistol";

  -- Ammunition icons list
  GSRCHUD.Ammunitions = {};

  -- Methods
  --[[
    Returns the ammunition icons list
    @return GSRCHUD.Ammunitions
  ]]
  function GSRCHUD:GetAmmoIcons()
    return self.Ammunitions;
  end

  --[[
    Links a sprite to an ammo type
    @param {string} ammoType
    @param {string} sprite
    @void
  ]]
  function GSRCHUD:AddAmmoIcon(ammoType, sprite)
    self.Ammunitions[ammoType] = sprite;
  end

  --[[
    Returns the sprite depending on the ammunition type
    @param {string} ammoType
    @return {string} sprite
  ]]
  function GSRCHUD:GetAmmoIcon(ammoType)
    return self:GetThemeAmmoIcons(self:GetCurrentTheme())[ammoType] or self.Ammunitions[ammoType] or self.Ammunitions[DEFAULT_AMMO_ICON];
  end
end
