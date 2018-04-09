--[[
  DAMAGE DIRECTIONAL INDICATORS
]]

-- ENUMS
local UP = 0;
local DOWN = 1;
local LEFT = 2;
local RIGHT = 3;

if CLIENT then

  -- Parameters
  local FREQ = 0.05;
  local ALPHA = 255;

  -- Variables
  local damage = {
    [UP] = {alpha = 0, think = 0},
    [DOWN] = {alpha = 0, think = 0},
    [LEFT] = {alpha = 0, think = 0},
    [RIGHT] = {alpha = 0, think = 0}
  };

  -- Methods
  --[[
    Animates each damage indicator
    @void
  ]]
  local function Animation()
    for _, sprite in pairs(damage) do
      if (sprite.alpha - FREQ > 0) then
        if (sprite.think < CurTime()) then
          sprite.alpha = sprite.alpha - FREQ;
          sprite.think = CurTime() + 0.01;
        end
      else
        if (sprite.alpha ~= 0) then
          sprite.alpha = 0;
        end
      end
    end
  end

  --[[
    Returns the alpha amount of a damage indicator
    @param {number} enum
    @return {number} alpha
  ]]
  local function GetIndicatorAlpha(enum)
    if (damage[enum] == nil) then return 0 end;
    return damage[enum].alpha;
  end

  --[[
    Draws the damage indicators
    @void
  ]]
  local function Damage()
    if (not GSRCHUD:IsDamageEnabled()) then return true end;
    local scale = GSRCHUD:GetHUDScale();
    local separation = GSRCHUD:GetDirDamageSeparation() * scale;

    -- UP
    local sprite = "pain_up";
    local w, h = GSRCHUD:GetSpriteDimensions(sprite);
    local xOffset, yOffset = GSRCHUD:GetSpriteOffsets(sprite);
    w = w * scale;
    GSRCHUD:DrawSprite((ScrW()/2) - (w/2), (ScrH()/2) - (h * scale) - separation + (h * (scale - 1)), sprite, scale, math.Clamp(ALPHA * GetIndicatorAlpha(UP), 0, 255), true, nil, nil, false);

    -- DOWN
    local sprite = "pain_down";
    local w, h = GSRCHUD:GetSpriteDimensions(sprite);
    w = w * scale;
    GSRCHUD:DrawSprite((ScrW()/2) - (w/2), (ScrH()/2) + separation + (h * (scale - 1)), sprite, scale, math.Clamp(ALPHA * GetIndicatorAlpha(DOWN), 0, 255), true);

    -- RIGHT
    local sprite = "pain_right";
    local w, h = GSRCHUD:GetSpriteDimensions(sprite);
    w = w * scale;
    h = h * scale - h * (scale - 1) * 2;
    GSRCHUD:DrawSprite((ScrW()/2) + separation, (ScrH()/2) - (h/2), sprite, scale, math.Clamp(ALPHA * GetIndicatorAlpha(RIGHT), 0, 255), true);

    -- LEFT
    local sprite = "pain_left";
    local w, h = GSRCHUD:GetSpriteDimensions(sprite);
    w = w * scale;
    h = h * scale - h * (scale - 1) * 2;
    GSRCHUD:DrawSprite((ScrW()/2) - w - separation, (ScrH()/2) - (h/2), sprite, scale, math.Clamp(ALPHA * GetIndicatorAlpha(LEFT), 0, 255), true);

    Animation();
  end
  GSRCHUD:AddElement(Damage);

  --[[
    Triggers a damage indicator
    @param {number} enum
    @void
  ]]
  local function IndicateDamage(enum)
    if (damage[enum] == nil) then return false end;
    damage[enum].alpha = 1;
  end

  net.Receive("gsrchud_damage", function(len)
    local enums = net.ReadTable();
    for _, enum in pairs(enums) do
      IndicateDamage(enum);
    end
  end);

end

if SERVER then

  util.AddNetworkString("gsrchud_damage");

  local generic = {DMG_GENERIC, DMG_CRUSH, DMG_SONIC};
  local override = {DMG_DROWN};
  local DISTANCE = 100;

  hook.Add("EntityTakeDamage", "gsrchud_damage", function(target, dmginfo)
    if (table.HasValue(override, dmginfo:GetDamageType())) then return end;
    if (target:IsPlayer() and IsValid(dmginfo:GetAttacker())) then
      local origin = dmginfo:GetAttacker():GetPos(); -- Position of the attacker
  		local noHeight = Vector(target:GetPos().x, target:GetPos().y, 0); -- Ignore height, this is only for the direction
  		local yaw = Angle(0, target:EyeAngles().y, 0); -- Get only the yaw, which is the only angle we need
      local worldToLocal = WorldToLocal(origin, angle_zero, noHeight, yaw); -- Get the relative angle
			local angle = worldToLocal:Angle().y; -- Take out only the yaw

      -- Show each indicator based on the direction the player is facing
      local enums = {};
      if (angle >= 295 or angle < 65) then
        table.insert(enums, UP);
      end

      if (angle >= 115 and angle < 245) then
        table.insert(enums, DOWN);
      end

      if (angle >= 205 and angle < 335) then
        table.insert(enums, RIGHT);
      end

      if (angle >= 25 and angle < 155) then
        table.insert(enums, LEFT);
      end

      -- If player self inflicts near damage or receives generic damage, show all indicators
      local selfDamage = (dmginfo:GetAttacker() == target and target:GetPos():Distance(dmginfo:GetDamagePosition()) < DISTANCE);
      if (selfDamage or table.HasValue(generic, dmginfo:GetDamageType())) then
        enums = {0,1,2,3};
      end

      net.Start("gsrchud_damage");
      net.WriteTable(enums);
      net.Send(target);
    end
  end);

end
