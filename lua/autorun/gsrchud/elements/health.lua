--[[------------------------------------------------------------------
  Health indicator
]]--------------------------------------------------------------------

-- sprites
local CROSS, DIVIDER, NUM0 = 'cross', 'divider', 'number_0'
local HOOK, SUIT = 'ShouldDraw', 'suit'
local DIVIDER_MARGIN = 10

--[[ Declare number ]]--
local NUMBER, enum = GSRCHUD.number.create(100)

-- highlight number when below 15
function NUMBER:isForced()
  return GSRCHUD.localPlayer():Health() <= 15
end

-- export number
GSRCHUD.NUMBER_HEALTH = enum

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

-- draw
function ELEMENT:draw()
  local scale = GSRCHUD.sprite.scale() -- get current scale
  local spacing = GSRCHUD.config.getDynamicSpacing()
  local health = math.max(GSRCHUD.localPlayer():Health(), 0)

  -- sort parameters
  local x = self.parameters.x or 16
  local y = self.parameters.y or ScrH() - 12 * scale
  local numOff = (self.parameters.numberOffset or -6) * scale
  local icoOff = (self.parameters.crossOffset or 8) * scale
  local divider = self.parameters.hideDivider
  local low = self.parameters.low
  if low == nil then low = health <= 25 end

  -- colours
  local hpCol = GSRCHUD.sprite.userColour(GSRCHUD.config.getHealthColour(), low)
  local divCol = GSRCHUD.sprite.userColour(GSRCHUD.config.getLseparatorColour())

  -- refresh number
  NUMBER:set(health)

  -- draw cross
  local w, h = GSRCHUD.sprite.drawTwin(CROSS, x, y + icoOff, NUMBER.highlight, hpCol, nil, TEXT_ALIGN_BOTTOM)

  -- get how many digits we need space for
  local digits = 3
  if spacing then digits = math.max(math.floor(math.log10(health)) + 1, digits) end

  -- reserve space for the numbers
  w = w + (GSRCHUD.sprite.getSize(NUM0, scale) * digits) + numOff

  -- move the next calls where the number should begin
  x = x + w

  -- draw number
  NUMBER:draw(x, y, TEXT_ALIGN_BOTTOM, hpCol)

  -- draw divider
  if not divider and GSRCHUD.config.getSuit() and GSRCHUD.hook.run(HOOK, SUIT) ~= false then
    local margin = DIVIDER_MARGIN * scale
    local _w, _h = GSRCHUD.sprite.drawTwin(DIVIDER, x + margin, y, NUMBER.highlight, divCol, nil, TEXT_ALIGN_BOTTOM)
    w = w + _w + margin
  end

  -- export
  self:export('width', w)
end

-- register
GSRCHUD.element.register('health', {'CHudHealth'}, ELEMENT)
