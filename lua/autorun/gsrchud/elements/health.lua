--[[
  HEALTH AND ARMOR ELEMENTS
]]

if CLIENT then

  local function Health()
    if (not GSRCHUD:IsHealthEnabled()) then return true end;
    local localPlayer = GSRCHUD:GetLocalPlayer();
    local scale = GSRCHUD:GetHUDScale();
    local x, y = 10, ScrH() - 40;
    local hp = localPlayer:Health();
    local ap = 0;
    if (localPlayer:IsPlayer()) then ap = localPlayer:Armor(); end
    local crit = (hp <= 25);

    local hpColor = nil;
    local apColor = nil;
    local sepColor = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      hpColor = GSRCHUD:GetCustomHealthColor();
      apColor = GSRCHUD:GetCustomArmorColor();
      sepColor = GSRCHUD:GetCustomLSepColor();
    end

    -- HEALTH
    local w, h = GSRCHUD:GetSpriteDimensions("cross");
    local wOffset, hOffset = GSRCHUD:GetSpriteMargins("cross");
    GSRCHUD:DrawNumber(x + (50 + w + wOffset) * scale, y, "health", math.max(hp, 0), scale, crit, nil, hpColor);
    GSRCHUD:DrawSprite(x, y, "cross", scale, GSRCHUD:GetNumberAlpha("health"), crit, nil, hpColor, nil, true);
    GSRCHUD:DrawSprite(x + (92 + wOffset) * scale, y, "separator", scale, GSRCHUD:GetNumberAlpha("health"), nil, nil, sepColor, nil, true);

    if hp <= 15 then
      GSRCHUD:GetNumber("health").alpha = 1;
    end

    -- ARMOR
    local aX, aY = x + math.Clamp((25 * scale) + ScrW()/6.5, 100 * scale, ScrW()), y - 4;
    GSRCHUD:DrawNumber(aX + (96 + wOffset) * scale, y, "armor", math.Clamp(ap, 0, ap), scale, nil, nil, apColor);

    local numberAlpha, numberCrit = GSRCHUD:GetNumberAlpha("armor"), GSRCHUD:GetCustomNumberCrit("armor");
    GSRCHUD:DrawSprite(aX + (wOffset * scale), aY, "suit_empty", scale, numberAlpha, numberCrit, nil, apColor, nil, true);
    GSRCHUD:DrawSprite(aX + (wOffset * scale), aY, "suit_full", scale, numberAlpha, numberCrit, math.Clamp(ap/100, 0, 1), apColor, nil, true);

    if numberCrit and ap <= 15 then
      GSRCHUD:GetNumber("armor").alpha = 1;
    end
  end

  GSRCHUD:AddElement(Health);

end
