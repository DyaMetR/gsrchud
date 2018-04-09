--[[
  BLINKING ICONS FOR HAZARDS
]]

if CLIENT then

  -- Parameters
  local MAX_TIME = 3;
  local FREQ = 0.016;

  -- Variables
  local hazards = {};
  local time = 0;
  local blink = 0;
  local blinked = false;
  local think = 0;

  -- Methods
  --[[
    Returns whether the animation already ended
    @return {boolean} animationEnded
  ]]
  local function AnimationTimeEnded()
    return time < CurTime();
  end

  --[[
    Plays the animation for the icons
    @void
  ]]
  local function Animation()
    if (#hazards > 0) then

      if (blinked) then

        if (blink - FREQ <= 0) then

          if (AnimationTimeEnded()) then
            hazards = {};
          else
            blinked = false;
          end

        else

          if (think < CurTime()) then
            blink = blink - FREQ;
            think = CurTime() + 0.01;
          end
        end

      else

        if (blink + FREQ > 1) then
          blink = 1;
          blinked = true;
        else
          if (think < CurTime()) then
            blink = blink + FREQ;
            think = CurTime() + 0.01;
          end
        end

      end

    end
  end

  --[[
    Draws the icons
    @void
  ]]
  local function Hazards()
    if (not GSRCHUD:IsHazardEnabled()) then return true end;
    local scale = GSRCHUD:GetHUDScale();
    local x, y = 10, ScrH() - 54;
    local h = 64 * scale;

    local color = nil;
    if (GSRCHUD:IsCustomColouringEnabled()) then
      color = GSRCHUD:GetCustomHealthColor();
    end

    for k, hazard in pairs(hazards) do
      GSRCHUD:DrawSprite(x, y - h * k, GSRCHUD:GetHazard(hazard), scale, blink * 255, nil, nil, color);
    end
    Animation();
  end
  GSRCHUD:AddElement(Hazards);

  --[[
    Returns whether a specific sprite is already in use by another hazard or not
    @param {string} sprite
    @return {boolean} inUse
  ]]
  local function TextureBeingUsed(sprite)
    for k, hazard in pairs(hazards) do
      if (GSRCHUD:GetHazard(hazard) == sprite) then
        return true;
      end
    end
    return false;
  end

  --[[
    Adds a hazard icon to the HUD
    @param {number} dmgType
    @void
  ]]
  local function AddHazard(dmgType)
    if (not GSRCHUD:IsValidHazard(dmgType)) then return false end;
    if (not table.HasValue(hazards, dmgType) and not TextureBeingUsed(GSRCHUD:GetHazard(dmgType))) then
      table.insert(hazards, dmgType);
    end
    time = CurTime() + MAX_TIME;
  end

  net.Receive("gsrchud_hazards", function(len)
    local damage = net.ReadFloat();
    AddHazard(damage);
  end);
end

if SERVER then
  util.AddNetworkString("gsrchud_hazards");
  hook.Add("EntityTakeDamage", "gsrchud_hazards", function(target, dmginfo)
    if target:IsPlayer() then
      net.Start("gsrchud_hazards");
      net.WriteFloat(dmginfo:GetDamageType());
      net.Send(target);
    end
  end);
end
