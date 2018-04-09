--[[
  WEAPON SELECTOR
]]

if CLIENT then

  local SELECTED_SPRITE = "weapon_selected";
  local SLOT_SPRITE = "weapon_slot";
  local DEFAULT_ICON = surface.GetTextureID("weapons/swep");
  local ALPHA_AMMO_BAR = 100; -- Alpha amount for the ammunition background

  --[[
    Draws the header of the weapon inventory
    @param {number} x
    @param {number} y
    @param {number} slot
    @void
  ]]
  function GSRCHUD:DrawWeaponSelectorHeader(x, y, slot, separate)
    if (separate == nil) then separate = true end;
    local scale = self:GetHUDScale();
    local sW, sH = self:GetSpriteDimensions(SLOT_SPRITE);
    local w, h = self:GetSpriteDimensions("bucket1");
    local offset = 0;

    local color = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    for i=1, 6 do
      if (slot <= i and separate) then
        offset = (sW - w) * scale;
      end
      self:DrawSprite(x + ((w + 5) * (i - 1) * scale) + offset, y + h * (scale - 1), "bucket"..i, scale, self:GetWeaponHighlightAlpha(), nil, nil, color);
      offset = 0;
    end
  end

  --[[
    Draws the weapon inventory
    @param {number} x
    @param {number} y
    @param {number} slot
    @param {table} weapons
    @param {number} slotPos
    @void
  ]]
  function GSRCHUD:DrawWeaponSelector(x, y, slot, weapons, slotPos)
    local separate = slotPos > 0;
    local scale = self:GetHUDScale();
    local w, h = self:GetSpriteDimensions("bucket1");
    local sW, sH = self:GetSpriteDimensions(SLOT_SPRITE);

    local color = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    self:DrawWeaponSelectorHeader(x, y, slot, separate);
    for k, weaponSlot in pairs(weapons) do
      if (k == slot - 1 and slotPos > 0) then
        -- Draw the weapons on the current slot
        local x = x + w * (slot - 2) * scale;
        local y = y + (h * scale) + (sH * (scale - 1));
        for c, weapon in pairs(weaponSlot) do
          local alpha = self:GetWeaponBaseAlpha();

          if (weapon.DrawWeaponInfoBox) then
            weapon.DrawWeaponInfoBox = false;
          end

          if (c == slotPos) then
            alpha = self:GetWeaponHighlightAlpha();

            if (not weapon.DrawWeaponInfoBox) then
              weapon.DrawWeaponInfoBox = true;
            end
          end
          self:DrawWeaponSlot(x + 5 * (slot - 2) * scale, y + (sH * (c - 1) * scale) + (5 * (c - 1) * scale), weapon, scale, alpha, c == slotPos, not self:HasAmmoForWeapon(weapon));
          self:DrawAmmoBar(x + 5 * (slot - 2) * scale + 9 * scale, y + (sH * (c - 1) * scale) + (5 * (c - 1) * scale) - (sH * (scale - 1)), weapon);
        end
      else
        -- Draw the squares for non-slot weapons
        local offset = 0;
        for c, weapon in pairs(weaponSlot) do
          if (slot <= k and separate) then
            offset = (sW - w) * scale;
          end

          for i=0, 1 do
            self:DrawSprite(x + (5 * scale * (k - 1)) + (w * (k - 1) * scale) + offset, y + (h * c * scale) + (5 * (c - 1) * scale) + (h * (scale - 1)), "bucket0", scale, self:GetWeaponHighlightAlpha(), not self:HasAmmoForWeapon(weapon), nil, color);
          end
          offset = 0;
        end
      end
    end
  end

  --[[
    Return whether the player has ammunition for a specific weapon
    @param {Weapon} weapon
    @return {boolean} hasAmmo
  ]]
  function GSRCHUD:HasAmmoForWeapon(weapon)
    if not IsValid(weapon) then return false end;
	local PrimaryType = weapon:GetPrimaryAmmoType();
	local SecondaryType = weapon:GetSecondaryAmmoType();
    if (PrimaryType <= 0 and SecondaryType <= 0) then return true end;
    local clip = math.Clamp(weapon:Clip1(), 0, 1);
    local primary = math.Clamp(LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()), 0, 1);
    local secondary = math.Clamp(LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType()), 0, 1);
    return (clip + primary + secondary) > 0;
  end

  --[[
    Draws the ammunition bar on the weapon slot
    @param {number} x
    @param {number} y
    @param {Weapon} weapon
    @void
  ]]
  function GSRCHUD:DrawAmmoBar(x, y, weapon)
    if not IsValid(weapon) then return false end;
    if (weapon:GetPrimaryAmmoType() <= -1 and weapon:GetSecondaryAmmoType() <= -1) then return true end;
    local barAlpha = ALPHA_AMMO_BAR;

    local c = self:GetThemeDefaultColor(self:GetCurrentTheme()); -- Default colour
    if (GSRCHUD:IsCustomColouringEnabled()) then
      c = GSRCHUD:GetCustomSelectorColor();
    end

    local w, h = 20, 4;
    local color = Color(0,255,0);
    local color2 = Color(c.r, c.g, c.b, barAlpha);
    local scale = self:GetHUDScale();
    local primary = weapon:GetPrimaryAmmoType();
    local secondary = weapon:GetSecondaryAmmoType();
    local ammo1 = LocalPlayer():GetAmmoCount(primary);
    local ammo2 = LocalPlayer():GetAmmoCount(secondary);

    if (primary > -1 and ammo1 > 0) then
      draw.RoundedBox(0, x, y, w * scale, h * scale, color2);
      draw.RoundedBox(0, x, y, w * scale * math.Clamp(ammo1/game.GetAmmoMax(primary), 0, 1), h * scale, color);
    end

    if (secondary > -1 and ammo2 > 0) then
      draw.RoundedBox(0, x + (w + 5) * scale, y, w * scale, h * scale, color2);
      draw.RoundedBox(0, x + (w + 5) * scale, y, w * scale * math.Clamp(ammo2/game.GetAmmoMax(secondary), 0, 1), h * scale, color);
    end
  end
end
