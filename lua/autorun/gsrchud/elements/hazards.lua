--[[------------------------------------------------------------------
  Hazards
]]--------------------------------------------------------------------

local NET = 'gsrchud_hazards'

if CLIENT then

  local MAX_TIME = 3
  local BASE_ALPHA = 255

  local hazards = {}
  local hazard_types = {}
  local time = 0
  local alpha = 0
  local blinked = false

  --[[ Create element ]]--
  local ELEMENT = GSRCHUD.element.create()

  -- draw
  function ELEMENT:draw()
    local scale = GSRCHUD.sprite.scale()
    local _alpha = GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA

    -- sort parameters
    local x = self.parameters.x or 8 * scale
    local y = self.parameters.y or ScrH() - 63 * scale

    -- do not run if there are no hazards to display
    if #hazards <= 0 then return end

    -- make icons blink
    if blinked then
      alpha = math.max(alpha - RealFrameTime(), 0)
      blinked = alpha > 0
    else
      alpha = math.min(alpha + RealFrameTime(), 1)
      blinked = alpha >= 1
    end

    -- end blinking after some time
    if time < CurTime() and not blinked and alpha <= 0 then
      table.Empty(hazards)
      table.Empty(hazard_types)
    end

    -- draw tray
    for _, hazard in pairs(hazards) do
      local w, h = GSRCHUD.hazard.draw(x, y, hazard, GSRCHUD.sprite.userColour(GSRCHUD.config.getHealthColour()), nil, TEXT_ALIGN_BOTTOM, nil, BASE_ALPHA * alpha * _alpha)
      y = y - (h or 0)
    end
  end

  -- register
  GSRCHUD.element.register('hazards', {'CHudPoisonDamageIndicator'}, ELEMENT)

  --[[ Receive hazards ]]--
  net.Receive(NET, function(len)
      -- receive hazard type
      local hazard = net.ReadFloat()

      -- if there's no valid hazard icon, skip
      if not GSRCHUD.hazard.has(hazard, GSRCHUD.getCurrentTheme()) then return end

      -- reset delay
      time = CurTime() + MAX_TIME

      -- if it's already present, do not add
      if hazard_types[hazard] then return end

      -- add hazard to tray
      table.insert(hazards, hazard)

      -- register hazard type to avoid duplicates
      hazard_types[hazard] = true
    end)
end

if SERVER then

  -- create network string
  util.AddNetworkString(NET)

  -- detect damage type inflicted
  hook.Add('EntityTakeDamage', GSRCHUD.hookname .. '_hazards', function(_player, dmginfo)
    if not _player:IsPlayer() or not _player:Alive() or math.Round(dmginfo:GetDamage()) <= 0 then return end -- players only
    -- send new hazard
    net.Start(NET)
    net.WriteFloat(dmginfo:GetDamageType()) -- would use net.WriteInt but that'd break addons
    net.Send(_player)
  end)

end
