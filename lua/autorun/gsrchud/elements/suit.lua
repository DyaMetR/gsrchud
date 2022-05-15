--[[------------------------------------------------------------------
  Suit battery indicator
]]--------------------------------------------------------------------

-- sprites
local NUM0, SUIT_FULL, SUIT_EMPTY = 'number_0', 'suit_full', 'suit_empty'

--[[ Declare number ]]--
local NUMBER, enum = GSRCHUD.number.create(0)

-- export number
GSRCHUD.NUMBER_SUIT = enum

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  local localPlayer = GSRCHUD.localPlayer()
  local scale = GSRCHUD.sprite.scale() -- get current scale
  local spacing = GSRCHUD.config.getDynamicSpacing()
  local health = GSRCHUD.element.import('health')

  -- sort parameters
  local x = self.parameters.x or 16 + math.max(health.width or 0, (ScrW() - 320) * .231)
  local y = self.parameters.y or ScrH() - 12 * scale
  local numOff = (self.parameters.numberOffset or 0) * scale
  local icoOff = (self.parameters.suitOffset or 10) * scale
  local colour = self.parameters.colour
  local emptySprite = self.parameters.emptySprite or SUIT_EMPTY
  local fullSprite = self.parameters.fullSprite or SUIT_FULL
  local hide = self.parameters.hide or not localPlayer.Armor

  -- hide armour if prompted to do so
  if hide then return end

  -- if colour is a boolean, use it with user configuration
  colour = GSRCHUD.sprite.userColour(GSRCHUD.config.getSuitColour(), colour)

  -- refresh number
  local suit = math.max(localPlayer:Armor(), 0)
  NUMBER:set(suit)

  -- get suit icon vertical origin
  local _y = y + icoOff

  -- draw suit background
  GSRCHUD.sprite.drawTwin(emptySprite, x, y + icoOff, NUMBER.highlight, colour, nil, TEXT_ALIGN_BOTTOM)

  -- draw suit foreground
  local _w, _h = GSRCHUD.sprite.getSize(fullSprite, scale)
  render.SetScissorRect(x, _y - _h * suit / localPlayer:GetMaxArmor(), x + _w, _y + _h, true)
  GSRCHUD.sprite.drawTwin(fullSprite, x, _y, NUMBER.highlight, colour, nil, TEXT_ALIGN_BOTTOM)
  render.SetScissorRect(0, 0, 0, 0, false)

  -- move next calls to icon's side and reserve space for numbers
  local digits = 3
  if spacing then digits = math.max(math.floor(math.log10(suit)) + 1, digits) end
  x = x + _w + (GSRCHUD.sprite.getSize(NUM0, scale) * digits)

  -- draw number
  NUMBER:draw(x + numOff, y, TEXT_ALIGN_BOTTOM, colour)
end

-- register
GSRCHUD.element.register('suit', {'CHudBattery'}, ELEMENT)
