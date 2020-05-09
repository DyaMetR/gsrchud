--[[
  VANILLA AND ADDON AUXILIARY POWER SUPPORT
]]

if CLIENT then

  -- Variables
  local flashlight = 1;

  --[[
    Draws the flashlight representing aux. power in the top right corner
    @void
  ]]
  local function Flashlight()
    local IsVanillaEnabled = GetConVar("gmod_suit"):GetInt() > 0
    if ((not IsVanillaEnabled and (not AUXPOW or not AUXPOW:IsEnabled())) or not GSRCHUD:IsAuxPowerEnabled()) then return end

    -- if vanilla is enabled and not auxiliary power, get that one
    if IsVanillaEnabled and (not AUXPOW or not AUXPOW:IsEnabled()) then
      flashlight = LocalPlayer():GetSuitPower() * 0.01
    end

    local margin, _ = GSRCHUD:GetSpriteDimensions("flash_beam");
    local w, h = GSRCHUD:GetSpriteDimensions("flash_empty");
    local x, y = ScrW() - (w + margin) * GSRCHUD:GetHUDScale(), 10 + h * (GSRCHUD:GetHUDScale() - 1);

    -- Draw flashlight beam when on and hightlight
    local alpha = 0.5;
    if (LocalPlayer():FlashlightIsOn()) then
      alpha = 1;
      GSRCHUD:DrawSprite(x + w * GSRCHUD:GetHUDScale(), y, "flash_beam", GSRCHUD:GetHUDScale(), nil, flashlight <= 0.25);
    end

    -- Draw flashlight
    GSRCHUD:DrawSprite(x, y, "flash_empty", GSRCHUD:GetHUDScale(), nil, flashlight <= 0.25);
    render.SetScissorRect(x + (w * GSRCHUD:GetHUDScale() * (1 - flashlight)), 0, x + (w * GSRCHUD:GetHUDScale()), y + (h * GSRCHUD:GetHUDScale()), true);
    GSRCHUD:DrawSprite(x, y, "flash_full", GSRCHUD:GetHUDScale(), alpha * 255, flashlight <= 0.25);
    render.SetScissorRect(0, 0, 0, 0, false);
  end

  GSRCHUD:AddElement(Flashlight);

  -- Get flashlight power and hide default HUD
  hook.Add("AuxPowerHUDPaint", "auxpower_gsrchud_vanilla", function(power, labels)
    if (not GSRCHUD:IsEnabled() or not AUXPOW:IsEnabled() or AUXPOW:IsEP2Mode() or not GSRCHUD:IsAuxPowerEnabled()) then return; end
    flashlight = power;
    return true;
  end);

  hook.Add("EP2FlashlightHUDPaint", "auxpower_gsrchud_ep2", function(power)
    if (not GSRCHUD:IsEnabled() or not AUXPOW:IsEnabled() or not AUXPOW:IsEP2Mode() or not GSRCHUD:IsAuxPowerEnabled()) then return; end
    flashlight = power;
    return true;
  end);

end
