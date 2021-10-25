--[[------------------------------------------------------------------
  Flashlight icon.
]]--------------------------------------------------------------------

local FLASH_FULL, FLASH_EMPTY, FLASH_BEAM = 'flash_full', 'flash_empty', 'flash_beam'

local gmod_suit = GetConVar('gmod_suit')

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  local localPlayer = GSRCHUD.localPlayer()
  local scale = GSRCHUD.sprite.scale()

  -- sort parameters
  local x = self.parameters.x or ScrW()
  local y = self.parameters.y or 16 * scale
  local amount = self.parameters.amount or localPlayer:GetSuitPower() * .01
  local used = self.parameters.inUse
  local hide = self.parameters.hide
  local hlBg = self.parameters.highlightEmptySprite
  local xoff = (self.parameters.fullSpriteOffsetX or 0) * scale
  local yoff = (self.parameters.fullSpriteOffsetY or 0) * scale
  local low = self.parameters.low

  -- sort nil parameters
  if used == nil then used = localPlayer:KeyDown(IN_SPEED) or localPlayer:WaterLevel() >= 3 or localPlayer:FlashlightIsOn() end
  if hide == nil then hide = not gmod_suit:GetBool() end

  -- call hooks to allow third party addons customize it
  local _amount, _used, _hide = hook.Run('GSRCHUDFlashlight')
  if _hide ~= nil then hide = _hide end
  if _amount then amount = _amount end -- replace amount if one was provided

  -- export whether the flashlight is visible
  self:export('visible', not hide)

  -- do not draw if prompted to do so
  if hide then return end

  local w, h = GSRCHUD.sprite.getSize(FLASH_BEAM, scale)
  local highlight = 0
  if low == nil then
    low = amount <= .25
  else
    if isnumber(low) then low = amount <= low end
  end

  -- select colour
  low = GSRCHUD.sprite.userColour(GSRCHUD.config.getFlashlightColour(), low)

  -- draw beam and highlight sprite
  if _used or (_used == nil and used) then
    GSRCHUD.sprite.draw(FLASH_BEAM, x, y, low, TEXT_ALIGN_RIGHT)
    highlight = 1
  end

  -- displace flashlight icon
  x = x - w

  -- draw background
  if not hlBg then
    GSRCHUD.sprite.draw(FLASH_EMPTY, x, y, low, TEXT_ALIGN_RIGHT)
  else -- if background should be highlighted, draw a twin sprite
    GSRCHUD.sprite.drawTwin(FLASH_EMPTY, x, y, highlight, low, TEXT_ALIGN_RIGHT)
  end

  -- get foreground sprite size
  w, h = GSRCHUD.sprite.getSize(FLASH_FULL)

  -- apply foreground offset
  x = x + xoff
  y = y + yoff

  -- draw foreground
  render.SetScissorRect(x - (w * amount), y, x + w, y + h, true)
  GSRCHUD.sprite.drawTwin(FLASH_FULL, x, y, highlight, low, TEXT_ALIGN_RIGHT)
  render.SetScissorRect(0, 0, 0, 0, false)
end

-- register
GSRCHUD.element.register('flashlight', {'CHudSuitPower'}, ELEMENT)
