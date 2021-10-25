--[[------------------------------------------------------------------
  HEV Mark V Auxiliary Power support
  https://steamcommunity.com/sharedfiles/filedetails/?id=1758584347
]]--------------------------------------------------------------------

if not AUXPOW then return end -- do not initialize without the addon installed

local PARENT = 'flashlight'
local SPRITE = 'item_battery'
local FLASH_BEAM, FLASH_FULL = 'flash_beam', 'flash_full'

local enabled = GetConVar('sv_auxpow_enabled')
local mode = GetConVar('sv_auxpow_flashlight_ep2')
local used = false

--[[ Add options ]]--
GSRCHUD.config.createConVar('auxpow_always', 0, GSRCHUD.config.PARAM_CHECK)
GSRCHUD.toolmenu.addOption('HEV Mark V Auxiliary Power', function(panel)
  panel:CheckBox('Enabled (replaces flashlight)', 'gsrchud_auxpow')
  panel:CheckBox('Always show additional indicator', 'gsrchud_auxpow_always')
end)

--[[ Replace addon's original HUD ]]--
hook.Add('AuxPowerHUDPaint', GSRCHUD.hookname, function(power, labels)
  if not GSRCHUD.isEnabled() or not GSRCHUD.config.getAuxpow() or not GSRCHUD.config.getFlashlight() then return end
  used = not table.IsEmpty(labels)
  return true
end)

--[[ Replace addon's original flashlight HUD ]]--
hook.Add('EP2FlashlightHUDPaint', GSRCHUD.hookname, function(power, labels)
  if not GSRCHUD.isEnabled() or not GSRCHUD.config.getAuxpow() or not GSRCHUD.config.getFlashlight() then return end
  return true
end)

--[[ Replace flashlight values ]]--
hook.Add('GSRCHUDFlashlight', 'auxpow', function()
  if not enabled:GetBool() or not GSRCHUD.config.getAuxpow() then return end
  local amount, used = AUXPOW:GetPower()

  -- if EP2 mode is enabled, only display the flashlight
  if mode:GetBool() then
    amount = AUXPOW:GetFlashlight()
    used = LocalPlayer():FlashlightIsOn()
  end

  return amount, used, false -- do not hide default flashlight
end)

--[[ Add element ]]--
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  if not enabled:GetBool() or not mode:GetBool() or not GSRCHUD.config.getFlashlight() or (not GSRCHUD.config.getAuxpow_always() and AUXPOW:GetPower() >= 1) then return end
  local scale = GSRCHUD.sprite.scale()

  -- get flashlight's origin
  local origin = GSRCHUD.element.get(PARENT).parameters.y

  -- sort parameters
  local sprite = self.parameters.sprite or SPRITE
  local x = self.parameters.x or ScrW() - 6 * scale
  local _, _h = GSRCHUD.sprite.getSize(FLASH_FULL) -- get sprite height to apply to the default offset
  local y = self.parameters.y or (origin or 16 * scale) + _h
  local low = self.parameters.low
  local power = self.parameters.power or AUXPOW:GetPower()

  -- highlight foreground when being used
  local highlight = 0
  if used then highlight = 1 end

  -- get low colour selection
  if low == nil then
    low = power <= .25
  else
    if isnumber(low) then low = power <= low end
  end

  -- select colour
  low = GSRCHUD.sprite.userColour(GSRCHUD.config.getFlashlightColour(), low)

  -- draw background
  local w, h = GSRCHUD.sprite.draw(sprite, x, y, low, TEXT_ALIGN_RIGHT)

  -- draw foreground
  render.SetScissorRect(x - w, y + h * (1 - power), x, y + h, true)
  GSRCHUD.sprite.drawTwin(sprite, x, y, highlight, low, TEXT_ALIGN_RIGHT)
  render.SetScissorRect(0, 0, 0, 0, false)
end

--[[ Register ]]--
GSRCHUD.element.register('auxpow', {}, ELEMENT)

--[[------------------------------------------------------------------
  Theme implementations
]]--------------------------------------------------------------------

--[[ Afraid of Monsters ]]--
GSRCHUD.theme.get(GSRCHUD.THEME_AFRAIDOFMONSTERS):addPreDraw('auxpow', function(element)
  element:set('y', 90 * GSRCHUD.sprite.scale())
end)

--[[ Half-Life 1.5: Weapon Edition ]]--
local THEME = GSRCHUD.theme.get(GSRCHUD.THEME_HLWE)

-- sprites
THEME:addTexture('hud_auxpow', surface.GetTextureID('gsrchud/_auxpow/hlwe'), 256, 128)
THEME:addSprite('auxpow_empty', 'hud_auxpow', 1, 1, 136, 44)
THEME:addSprite('auxpow_full', 'hud_auxpow', 6, 45, 98, 44)

-- draw
THEME:addPreDraw('auxpow', function(element)
  if not AUXPOW or not mode:GetBool() or (not GSRCHUD.config.getAuxpow_always() and AUXPOW:GetPower() >= 1) then return end

  local scale = GSRCHUD.sprite.scale()
  local _w1 = GSRCHUD.sprite.getSize(FLASH_BEAM)
  local _w, _h = GSRCHUD.sprite.getSize(FLASH_FULL)
  local x, y = ScrW() - _w1, _h

  -- highlight
  local highlight = 0
  if used then highlight = 1 end

  -- power
  local power = AUXPOW:GetPower()
  local low = power <= .2

  -- select colours
  low = GSRCHUD.sprite.userColour(GSRCHUD.config.getFlashlightColour(), low)

  -- draw background
  GSRCHUD.sprite.drawTwin('auxpow_empty', x, y, highlight, low, TEXT_ALIGN_RIGHT)

  -- draw foreground
  x = x - 33 * scale
  render.SetScissorRect(x - _w * power, y, x, y + _h, true)
  GSRCHUD.sprite.drawTwin('auxpow_full', x, y, highlight, low, TEXT_ALIGN_RIGHT)
  render.SetScissorRect(0, 0, 0, 0, false)

  return true
end)
