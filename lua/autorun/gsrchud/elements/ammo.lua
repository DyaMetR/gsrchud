--[[
  HEALTH AND ARMOR ELEMENTS
]]

if CLIENT then

  local function Ammo()
    if (not GSRCHUD:IsAmmoEnabled()) then return true end;

    local localPlayer = GSRCHUD:GetLocalPlayer();
    if not localPlayer.GetActiveWeapon == nil or not IsValid(localPlayer:GetActiveWeapon()) or (localPlayer:GetActiveWeapon():GetPrimaryAmmoType() <= -1 and localPlayer:GetActiveWeapon():GetSecondaryAmmoType() <= -1) then return; end
    local scale = GSRCHUD:GetHUDScale();
    local x, y = ScrW() - 10, ScrH() - 40;
    local weapon = localPlayer:GetActiveWeapon();
    local primary = weapon:GetPrimaryAmmoType();
    local secondary = weapon:GetSecondaryAmmoType();
    local clip = weapon:Clip1();
    local reserve = 0;
    local alt = 0;
    if (localPlayer:IsPlayer()) then reserve = localPlayer:GetAmmoCount(primary); alt = localPlayer:GetAmmoCount(secondary); end

    local clipColor = nil;
    local ammoColor = nil;
    local sepColor = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      clipColor = GSRCHUD:GetCustomClipColor();
      ammoColor = GSRCHUD:GetCustomAmmoColor();
      sepColor = GSRCHUD:GetCustomRSepColor();
    end

    --[[
      PRIMARY AMMO
    ]]
      if primary <= -1 then
        reserve = alt;
      end

      -- Clip
      if clip > -1 and primary > -1 then
        GSRCHUD:DrawNumber(x - 110 * scale, y, "clip", clip, scale, nil, nil, clipColor);
        GSRCHUD:DrawSprite(x - 100 * scale, y, "separator", scale, GSRCHUD:GetNumberAlpha("clip"), nil, nil, sepColor, nil, true);
      end

      -- Reserve ammo
      local alpha = GSRCHUD:GetNumberAlpha("clip") or nil;
      if (clip <= -1) then
        alpha = nil;
      end
      GSRCHUD:DrawNumber(x - 30 * scale, y, "reserve", reserve, scale, nil, alpha, ammoColor);

      -- Icon
      local ammo = game.GetAmmoName(primary);
      if (primary <= -1) then
        ammo = game.GetAmmoName(secondary);
      end
      if (clip <= -1) then
        alpha = GSRCHUD:GetNumberAlpha("reserve");
      end

      local icon = GSRCHUD:GetAmmoIcon(ammo);
      if (GSRCHUD:HasCustomSprite(icon)) then
        GSRCHUD:DrawCustomSprite(icon, x - 28 * scale, y - 4, scale, alpha, ammoColor, nil, true);
      else
        GSRCHUD:DrawSprite(x - 28 * scale, y - 4, GSRCHUD:GetAmmoIcon(ammo), scale, alpha, nil, nil, ammoColor, nil, true);
      end

    --[[
      SECONDARY AMMO
    ]]
    if (primary > -1 and secondary > -1 and alt > 0) then
      GSRCHUD:DrawNumber(x - 30 * scale, y - 28 * scale, "secondary", alt, scale, nil, alpha, ammoColor);
      GSRCHUD:DrawSprite(x - 28 * scale, y - 4 - 28 * scale, GSRCHUD:GetAmmoIcon(game.GetAmmoName(secondary)), scale, alpha, nil, nil, ammoColor, nil, true);
    end
  end

  GSRCHUD:AddElement(Ammo);

end
