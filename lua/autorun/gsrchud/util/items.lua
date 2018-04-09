--[[
  ITEM ICON DRAWING
]]

if CLIENT then

  -- Parameters
  local SELECTED_SPRITE = "weapon_selected";
  local SLOT_SPRITE = "weapon_slot";
  local DEFAULT_ICON = surface.GetTextureID("weapons/swep");

  -- Variables
  GSRCHUD.Items = {}; -- Item table

  -- Methods
  --[[
    Links a sprite with an itemClass
    @param {string} itemClass
    @param {string} sprite
    @void
  ]]
  function GSRCHUD:AddItemSprite(itemClass, sprite)
    self.Items[itemClass] = sprite;
  end

  --[[
    Returns an item sprite
    @param {string} itemClass
    @return {string} sprite
  ]]
  function GSRCHUD:GetItemSprite(itemClass)
    return self.Items[itemClass] or itemClass;
  end

  --[[
    Draws the selector icon of a specific weapon
    @param {number} x
    @param {number} y
    @param {Weapon} weapon
    @param {number} scale
    @param {number} alpha
  ]]
  function GSRCHUD:DrawWeaponIcon(x, y, weapon, scale, alpha)
    alpha = alpha or 255;
    local w, h = 128 * scale, 64 * scale;
    local sW, sH = self:GetSpriteDimensions(SLOT_SPRITE);

    y = y - (h/2);

    if weapon.WepSelectIcon ~= nil and type(weapon.WepSelectIcon) == "number" and weapon.WepSelectIcon ~= DEFAULT_ICON then -- If the weapon has a selection icon
        local tW, tH = surface.GetTextureSize(weapon.WepSelectIcon);
        w, h = math.Clamp(tW, 0, 128) * scale, math.Clamp(tH, 0, 64) * scale;
        x = x - (w/2);
        surface.SetTexture(weapon.WepSelectIcon);
        surface.SetDrawColor(Color(255,255,255,alpha));
  			surface.DrawTexturedRectUV(x, y + 10 * scale, w, h - 20 * scale, 0, 0.15, 1, 1 - 0.15);
    else
        x = x - (w/2);

        if weapon.DrawWeaponSelection ~= nil then -- If instead of an icon, has a custom slot rendering
            weapon:DrawWeaponSelection(x, y, w, h, alpha);
        else
            surface.SetTexture(DEFAULT_ICON);
            surface.SetDrawColor(Color(255,255,255,alpha));
            surface.DrawTexturedRect(x, y, w, h);
        end
    end
  end

  --[[
    Draws a predefined weapon icon
    @param {number} x
    @param {number} y
    @param {Weapon} weapon
    @param {number} scale
    @param {number} alpha
  ]]
  function GSRCHUD:DrawDefaultWeaponIcon(x, y, weapon, scale, alpha, crit)
    if not self:HasWeaponIcon(weapon:GetClass()) then return false end
    crit = crit or false;

    local add = math.Clamp(alpha - 255, 0, 255)/255;
    local color = self:GetThemeDefaultColor(self:GetCurrentTheme());
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    local w, h = 256, 64; -- The file dimensions
    local cW, cH = 170, 45; -- The weapon icon default size
    local sW, sH = self:GetSpriteDimensions(SLOT_SPRITE); -- The slot size

    if (crit) then
      color = self:GetThemeDefaultCritColor(self:GetCurrentTheme());
      if (GSRCHUD:IsCustomColouringEnabled()) then
        color = self:GetCustomCritColor();
      end
    end

    surface.SetTexture(surface.GetTextureID(self:GetWeaponIcon(weapon:GetClass())));
    surface.SetDrawColor(Color(color.r + 255 * add, color.g + 255 * add, color.b + 255 * add, color.a * (alpha/255)));
    surface.DrawTexturedRectUV(x, y - sH * (scale - 1), sW * scale, sH * scale, 0, 0, cW/w, cH/h);
  end

  --[[
    Draws a weapon icon with background, used in pickup and weapon selector
    @param {number} x
    @param {number} y
    @param {Weapon} weapon
    @param {number} scale
    @param {number} alpha
    @param {boolean} selected
  ]]
  function GSRCHUD:DrawWeaponSlot(x, y, weapon, scale, alpha, selected, crit)
    if not IsValid(weapon) then return false end;
    if not LocalPlayer():HasWeapon(weapon:GetClass()) then return false end;
    crit = crit or false;
    alpha = alpha or 255;

    local color = self:GetThemeDefaultColor(self:GetCurrentTheme());
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    local w, h = self:GetSpriteDimensions(SLOT_SPRITE);
    self:DrawSprite(x, y, SLOT_SPRITE, scale, alpha, crit, nil, color);

    if selected then
      self:DrawSprite(x, y, SLOT_SPRITE, scale, alpha, crit, nil, color);
      self:DrawSprite(x, y, SELECTED_SPRITE, scale, alpha, nil, nil, color);
    end

    if (self:HasWeaponIcon(weapon:GetClass())) then
      self:DrawDefaultWeaponIcon(x, y, weapon, scale, alpha, crit);
    else
      self:DrawWeaponIcon(x + (w * scale)/2, y + ((h * scale)/2) - (h * (scale - 1)), weapon, scale, alpha);
    end
  end

  --[[
    Draws an ammunition icon
    @param {number} x
    @param {number} y
    @param {string} ammo
    @param {number} amount
    @param {number} scale
    @void
  ]]
  function GSRCHUD:DrawAmmoIcon(x, y, ammo, amount, scale, alpha)
    local color = self:GetThemeDefaultColor(self:GetCurrentTheme());
    local w, h = self:GetSpriteDimensions(self:GetAmmoIcon(ammo));
    local nW, nH = self:GetSpriteDimensions("s0");

    local color = self:GetThemeDefaultColor(self:GetCurrentTheme());
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    self:DrawSprite(x - w * scale, y, self:GetAmmoIcon(ammo), scale, alpha, nil, nil, color);
    self:RenderNumber(x - (w + 8) * scale, y + (nH - 8 * scale), amount, scale, crit, alpha, true, color);
  end

end
