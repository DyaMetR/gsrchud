--[[------------------------------------------------------------------
  Displays where is the player being attacked from
]]--------------------------------------------------------------------

-- ENUMS
local UP = 1
local DOWN = 2
local LEFT = 3
local RIGHT = 4

-- NET
local NET = 'gsrchud_damage'

if CLIENT then

  local ALPHA = 1 -- starting alpha
  local DEFAULT_COLOUR = Color(255, 255, 255) -- default colour
  local BASE_ALPHA = 255 -- base alpha value
  local SPRITES = { 'pain0', 'pain2', 'pain1', 'pain3' }

  local damage = {} -- directional indicators
  for i=1, 4 do -- initialize damage indicators
    damage[i] = 0
  end

  --[[ Create configuration ]]--
  GSRCHUD.config.createConVar('damageOffset', 100, GSRCHUD.config.PARAM_NUMERIC)

  --[[ Create element ]]--
  local ELEMENT = GSRCHUD.element.create()

  -- draw
  function ELEMENT:draw()
    local scale = GSRCHUD.sprite.scale()

    -- sort parameters
    local colour = self.parameters.colour or DEFAULT_COLOUR
    local separation = self.parameters.separation or GSRCHUD.config.getDamageOffset() * scale

    -- animate
    for i, dmg in pairs(damage) do
      damage[i] = math.max(dmg - RealFrameTime() / .275, 0)
    end

    -- pain indicators
    local x, y = ScrW() * .5, ScrH() * .5

    -- draw indicators
    GSRCHUD.sprite.draw(SPRITES[UP], x, y - separation, colour, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, nil, BASE_ALPHA * damage[UP])
    GSRCHUD.sprite.draw(SPRITES[DOWN], x, y + separation, colour, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, nil, BASE_ALPHA * damage[DOWN])
    GSRCHUD.sprite.draw(SPRITES[LEFT], x + separation, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, nil, BASE_ALPHA * damage[LEFT])
    GSRCHUD.sprite.draw(SPRITES[RIGHT], x - separation, y, colour, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, nil, BASE_ALPHA * damage[RIGHT])
  end

  -- register
  GSRCHUD.element.register('damage', {'CHudDamageIndicator'}, ELEMENT)

  --[[ Receive damage taken ]]--
  net.Receive(NET, function()
    local up = net.ReadBool()
    local down = net.ReadBool()
    local left = net.ReadBool()
    local right = net.ReadBool()
    if up then damage[UP] = 1 end
    if down then damage[DOWN] = 1 end
    if left then damage[LEFT] = 1 end
    if right then damage[RIGHT] = 1 end
  end)

end

if SERVER then

  util.AddNetworkString(NET)

  -- damage types that will trigger all indicators
  local GENERIC = {
    [DMG_GENERIC] = true,
    [DMG_CRUSH] = true,
    [DMG_SONIC] = true
  }

  -- distance at which all indicators will show up
  local DISTANCE = 100 * 100

  --[[ Implementation ]]--
  hook.Add('EntityTakeDamage', GSRCHUD.hookname .. '_damage', function(_player, dmginfo)
    if not _player:IsPlayer() or not _player:Alive() or not IsValid(dmginfo:GetAttacker()) or not IsValid(dmginfo:GetInflictor()) or math.Round(dmginfo:GetDamage()) <= 0 then return end

    local origin = dmginfo:GetInflictor():GetPos() -- position of the attacker
    local noHeight = Vector(_player:GetPos().x, _player:GetPos().y, 0) -- ignore height, this is only for the direction
    local yaw = Angle(0, _player:EyeAngles().y, 0) -- get only the yaw, which is the only angle we need
    local worldToLocal = WorldToLocal(origin, angle_zero, noHeight, yaw) -- get the relative angle
    local angle = worldToLocal:Angle().y -- take out only the yaw

    -- get brackets to light up
    local tooClose = (dmginfo:GetAttacker() == _player and dmginfo:GetDamagePosition():DistToSqr(_player:GetPos()) < DISTANCE) or GENERIC[dmginfo:GetDamageType()]
    local up = angle >= 295 or angle < 65 or tooClose
    local down = (angle >= 115 and angle < 245) or tooClose
    local left = (angle >= 205 and angle < 335) or tooClose
    local right = (angle >= 25 and angle < 155) or tooClose

    -- send result to player
    net.Start(NET)
    net.WriteBool(up)
    net.WriteBool(down)
    net.WriteBool(left)
    net.WriteBool(right)
    net.Send(_player)
  end)

end
