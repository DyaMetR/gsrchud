--[[
  PICKUP HISTORY
]]

if CLIENT then

  -- Parameters
  local AMMO = "ammo";
  local WEAPON = "weapon";
  local ITEM = "item";
  local FREQ = 0.02; -- How fast does the icons fade out
  local TIME = 3; -- How much time it takes for the icons to start fading out
  local XOFFSET = 10; -- How far is the HUD element from the screen X axis
  local YOFFSET = 130; -- How far is the HUD element from the screen Y axis
  local SEPARATION = 5; -- How separated are each icon
  local PICKUP_SOUND = "gsrchud/gunpickup2.wav"; -- The weapon pickup sound

  -- Variables
  local count = 0;
  local history = {};
  local think = 0;

  -- Methods
  --[[
    Draws a history entry
    @param {table} entry
    @void
  ]]
  local function DrawItem(entry)
    local sW, sH = GSRCHUD:GetSpriteDimensions("weapon_slot");
    local scale = GSRCHUD:GetHUDScale();
    local x, y = 0, ScrH() - (YOFFSET * scale) - ((sH + SEPARATION) * scale * entry.count);
    local t = entry.category; -- The item category
    local a = GSRCHUD:GetWeaponHighlightAlpha(); -- Alpha channel

    local color = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomSelectorColor();
    end

    if (t == AMMO) then -- If the item picked up was ammunition

      local w, h = GSRCHUD:GetSpriteDimensions(GSRCHUD:GetAmmoIcon(entry.itemName));
      x = ScrW() - (w * scale);
      GSRCHUD:DrawAmmoIcon(x, y, entry.itemName, entry.amount, scale, entry.alpha * a);

    elseif (t == WEAPON) then -- If the item picked up was a weapon

      if (entry.itemName.DrawWeaponInfoBox) then
        entry.itemName.DrawWeaponInfoBox = false;
      end

      x = ScrW() - (sW * scale) - XOFFSET;
      GSRCHUD:DrawWeaponSlot(x, y, entry.itemName, scale, entry.alpha * a, false, not GSRCHUD:HasAmmoForWeapon(entry.itemName));

    elseif (t == ITEM) then -- If the item pickued up was an item

      local w, h = GSRCHUD:GetSpriteDimensions(entry.itemName);
      x = ScrW() - (w * scale) - XOFFSET;
      GSRCHUD:DrawSprite(x, y, GSRCHUD:GetItemSprite(entry.itemName), scale, entry.alpha * a, nil, nil, color);

    end
  end

  --[[
    Animates the item pickup history
    @void
  ]]
  local function Animation()
    if #history > 0 and think < CurTime() then
      for k, entry in pairs(history) do
        if (entry.time < CurTime()) then
          if (entry.alpha - 0.01 > 0) then
            entry.alpha = entry.alpha - 0.01;
          else
            entry.alpha = 0;
            table.remove(history, k);
          end
        end
      end
      think = CurTime() + FREQ;
    else
      if #history <= 0 and count > 0 then
        count = 0;
      end
    end
  end

  --[[
    Draws the entire pickup history
    @void
  ]]
  local function PickupHistory()
    if (not GSRCHUD:IsPickupEnabled()) then return true end;
    Animation();
    for _, item in pairs(history) do
      DrawItem(item);
    end
  end
  GSRCHUD:AddElement(PickupHistory);

  --[[
    Returns the maximum amount of items on display at once
    @return {number} maxItems
  ]]
  local function GetMaxItems()
    local sW, sH = GSRCHUD:GetSpriteDimensions("weapon_slot");
    local scale = GSRCHUD:GetHUDScale();
    sH = sH * scale;
    return ((ScrH() - YOFFSET * scale)/sH) - 2;
  end

  local function AddPickupHistory(category, itemName, amount)
    amount = amount or 0;
    table.insert(history, {count = count, category = category, itemName = itemName, amount = amount, alpha = 1, time = CurTime() + TIME});
    if (count > GetMaxItems()) then
      count = 0;
    else
      count = count + 1;
    end
  end

  --[[
    Adds an ammo icon to the item pickup history
    @void
  ]]
  local function AddAmmoIcon(itemName, amount)
    AddPickupHistory(AMMO, itemName, amount);
  end

  --[[
    Adds a weapon icon to the pickup history
    @void
  ]]
  local function AddWeaponIcon(weapon)
    AddPickupHistory(WEAPON, weapon);
    surface.PlaySound(PICKUP_SOUND);
  end

  --[[
    Adds a item icon to the pickup history
    @void
  ]]
  local function AddItemIcon(itemName)
    AddPickupHistory(ITEM, itemName);
  end

  --[[
    HOOKS
  ]]
  hook.Add("HUDAmmoPickedUp", "gsrchud_ammo_pickup", function(itemName, amount)
    if (GSRCHUD:IsEnabled() and GSRCHUD:IsPickupEnabled()) then
      AddAmmoIcon(itemName, amount);
      return true;
    end
  end);

  hook.Add("HUDWeaponPickedUp", "gsrchud_weapon_pickup", function(weapon)
    if (GSRCHUD:IsEnabled() and GSRCHUD:IsPickupEnabled()) then
      AddWeaponIcon(weapon);
      return true;
    end
  end);

  hook.Add("HUDItemPickedUp", "gsrchud_item_pickup", function(itemName)
    if (GSRCHUD:IsEnabled() and GSRCHUD:IsPickupEnabled()) then
      AddItemIcon(itemName);
      return true;
    end
  end);


end
