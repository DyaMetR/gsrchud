--[[------------------------------------------------------------------
  Ammunition indicator
]]--------------------------------------------------------------------

-- sprites
local CROSS, DIVIDER, NUM0 = 'cross', 'divider', 'number_0'

--[[ Declare number ]]--
local NUMBER, enum = GSRCHUD.number.create(0)

-- export number
GSRCHUD.NUMBER_AMMO = enum

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  local localPlayer = GSRCHUD.localPlayer()
  local scale = GSRCHUD.sprite.scale()
  local spacing = GSRCHUD.config.getDynamicSpacing()
  local weapon = localPlayer:GetActiveWeapon()

  local isValid, primary, secondary, clip1, reserve, alt = false, 0, 0, -1, 0, 0

  -- select between vehicle and weapon ammunition
  if localPlayer:InVehicle() then
    local _primary, _, _ammo = localPlayer:GetVehicle():GetAmmo()
    if _primary <= -1 then return end
    isValid = true
    primary = _primary
    reserve = _ammo
  else
    -- do not draw if weapon isn't valid
    if IsValid(weapon) then
      isValid, primary, secondary, clip1, reserve, alt = GSRCHUD.weapon.ammo(weapon)
    end
  end

  -- do not draw if the ammunition isn't valid
  if not isValid then return end

  -- get ammo names
  local class, primaryName, secondaryName = weapon:GetClass(), game.GetAmmoName(primary), game.GetAmmoName(secondary)

  -- if this weapon has a custom ammunition icon, replace the primary icon with it
  if GSRCHUD.ammunition.has(class) then primaryName = class end

  -- sort parameters
  local x = self.parameters.x or ScrW() - 17
  local y = self.parameters.y or ScrH() - 12 * scale
  local icox = (self.parameters.iconOffsetX or -1) * scale
  local icoy = (self.parameters.iconOffsetY or -3) * scale
  local cOff = (self.parameters.clipOffset or -9) * scale
  local dOff = (self.parameters.dividerOffset or 0) * scale
  local altx = (self.parameters.altOffsetX or -2) * scale
  local alty = (self.parameters.altOffsetY or -6) * scale
  local colour1 = self.parameters.clipColour
  local colour2 = self.parameters.reserveColour
  local colour3 = self.parameters.altColour

  -- get colours
  local iconCol = GSRCHUD.sprite.userColour(GSRCHUD.config.getAmmoColour())
  local divCol = GSRCHUD.sprite.userColour(GSRCHUD.config.getRseparatorColour())

  -- select colours
  colour1 = GSRCHUD.sprite.userColour(GSRCHUD.config.getClipColour(), colour1)
  colour2 = GSRCHUD.sprite.userColour(GSRCHUD.config.getAmmoColour(), colour2)
  colour3 = GSRCHUD.sprite.userColour(GSRCHUD.config.getAmmoColour(), colour3)

  -- refresh number
  if clip1 >= 0 then
    NUMBER:set(clip1)
  else
    NUMBER:set(reserve)
  end

  -- get digit size
  local _w, _h = GSRCHUD.sprite.getSize(NUM0, scale)

  -- draw secondary ammunition
  if alt > 0 then
    local _x, _y = x + altx, y - _h + alty
    local w, h = GSRCHUD.ammunition.draw(_x + icox, _y + icoy - _h, secondaryName, NUMBER.highlight, iconCol, TEXT_ALIGN_RIGHT)
    GSRCHUD.number.render(alt, _x - w, _y, TEXT_ALIGN_BOTTOM, NUMBER.highlight, colour3)
  end

  -- draw primary ammunition icon
  local w, h = GSRCHUD.ammunition.draw(x + icox, y + icoy - _h, primaryName, NUMBER.highlight, iconCol, TEXT_ALIGN_RIGHT)
  x = x - w

  -- get how many digits we need space for
  local digits = 3
  if spacing then digits = math.max(math.floor(math.log10(reserve)) + 1, digits) end

  -- draw reserve ammunition
  GSRCHUD.number.render(reserve, x, y, TEXT_ALIGN_BOTTOM, NUMBER.highlight, colour2)
  x = x - _w * (digits + .5)

  -- do not draw clip if invalid
  if clip1 <= -1 then return end

  -- draw weapon's primary clip ammunition
  local w, h = GSRCHUD.sprite.drawTwin(DIVIDER, x + dOff, y, NUMBER.highlight, divCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
  NUMBER:draw(x - w + cOff, y, TEXT_ALIGN_BOTTOM, colour1)
end

-- register
GSRCHUD.element.register('ammo', {'CHudAmmo', 'CHudSecondaryAmmo'}, ELEMENT)
