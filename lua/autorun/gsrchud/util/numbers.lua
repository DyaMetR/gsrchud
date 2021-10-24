--[[------------------------------------------------------------------
  Display numbers with their highlighting.
]]--------------------------------------------------------------------

GSRCHUD.number = {}

local SPRITES = { -- number sprites
  'number_0',
  'number_1',
  'number_2',
  'number_3',
  'number_4',
  'number_5',
  'number_6',
  'number_7',
  'number_8',
  'number_9',
}

local numbers = {}

local NUMBER = { -- prototype
  value = 0,
  highlight = 0
}

--[[------------------------------------------------------------------
  Sets the number's value, triggering the highlight if it changed from before.
  @param {number} new value
]]--------------------------------------------------------------------
function NUMBER:set(value)
  -- highlight if it was different
  if value ~= self.value then
    self.highlight = 1
  end

  -- set new value
  self.value = math.max(math.Round(value), 0)
end

--[[------------------------------------------------------------------
  Returns whether the number should be highlighted.
  @return {boolean} should highlight
]]--------------------------------------------------------------------
function NUMBER:isForced()
  return false
end

--[[------------------------------------------------------------------
  Draws the given number.
  @param {number} x
  @param {number} y
  @param {TEXT_ALIGN_TOP|TEXT_ALIGN_CENTER|TEXT_ALIGN_BOTTOM} vertical alignment
  @param {Color|boolean|nil} colour
  @param {number|nil} scale
  @param {number|nil} alpha
  @param {THEME_|nil} theme
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
function NUMBER:draw(x, y, align, colour, scale, alpha, theme)
  local _alpha = self.highlight
  if self:isForced() then _alpha = 1 end
  return GSRCHUD.number.render(self.value, x, y, align, _alpha, colour, scale, alpha, theme)
end

--[[------------------------------------------------------------------
  Creates and registers a highlightable number.
  @param {number} default value
  @return {table} number data
  @return {number} position in table
]]--------------------------------------------------------------------
function GSRCHUD.number.create(default)
  local number = table.Copy(NUMBER)
  number.value = math.max(math.Round(default or 0), 0)
  return number, table.insert(numbers, number)
end

--[[------------------------------------------------------------------
  Returns a number's data
  @param {NUMBER_} position in table
  @return {table} number's data
]]--------------------------------------------------------------------
function GSRCHUD.number.get(number)
  return numbers[number]
end

--[[------------------------------------------------------------------
  Renders a number.
  @param {number} value to display
  @param {number} x
  @param {number} y
  @param {boolean} is aligned to the bottom
  @param {number|nil} highlight amount
  @param {Color|boolean|nil} colour
  @param {number|nil} scale
  @param {number|nil} alpha
  @param {THEME_|nil} theme
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
function GSRCHUD.number.render(value, x, y, align, highlight, colour, scale, alpha, theme)
  local digits = math.floor(math.log10(value)) + 1
  local w, h = 0, 0
  for i=1, math.max(digits, 1) do
    -- get digit to display
    local digit = math.floor((value % math.pow(10, i)) / math.pow(10, i - 1))

    -- draw digit
    local sprite = SPRITES[digit + 1]
    local _w, _h = GSRCHUD.sprite.drawTwin(sprite, x, y, highlight, colour, TEXT_ALIGN_RIGHT, align, scale, alpha, theme)

    -- accumulate size
    w = w + _w
    if _h > h then h = _h end

    -- apply offset
    x = x - _w
  end

  return w, h
end

--[[------------------------------------------------------------------
  Runs the logic behind the highlighting.
]]--------------------------------------------------------------------
function GSRCHUD.number.run()
  for _, number in pairs(numbers) do
    number.highlight = math.max(number.highlight - RealFrameTime() / 5, 0)
  end
end
