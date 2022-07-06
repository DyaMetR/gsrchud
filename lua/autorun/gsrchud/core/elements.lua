--[[------------------------------------------------------------------
  Register elements to display
]]--------------------------------------------------------------------

GSRCHUD.element = {} -- namespace

local SHOULDDRAW_HOOK = 'ShouldDraw'

local elements = {} -- registered elements
local hide = {} -- hidden default HUD elements
local drawn = 0 -- elements last drawn

local ELEMENT = { -- prototype table
  hide = {}, -- default HUD elements to hide
  parameters = {}, -- parameters used by themes to customize elements behaviour
  exports = {} -- data required by other elements
}

--[[------------------------------------------------------------------
  Called in the render loop to draw the element.
]]--------------------------------------------------------------------
function ELEMENT:draw() end

--[[------------------------------------------------------------------
  Changes an element parameter's value.
  @param {string} parameter
  @param {any} value
]]--------------------------------------------------------------------
function ELEMENT:set(parameter, value)
  self.parameters[parameter] = value
end

--[[------------------------------------------------------------------
  Exports a named value.
  @param {string} name
  @param {any} value
]]--------------------------------------------------------------------
function ELEMENT:export(name, value)
  self.exports[name] = value
end

--[[------------------------------------------------------------------
  Clears all current parameters.
]]--------------------------------------------------------------------
function ELEMENT:clear()
  table.Empty(self.parameters)
end

--[[------------------------------------------------------------------
  Creates a new element table and returns it.
  @return {table} element table
]]--------------------------------------------------------------------
function GSRCHUD.element.create()
  return table.Copy(ELEMENT)
end

--[[------------------------------------------------------------------
  Registers a new HUD element.
  @param {string} identifier
  @param {table} CHud elements to hide
  @param {table} element data table
  @param {boolean|nil} whether the console variable should NOT be created
]]--------------------------------------------------------------------
function GSRCHUD.element.register(id, hide, data, noConVar)
  -- create convar
  if not noConVar then
    data.convar = GSRCHUD.config.createConVar(id)
  end

  -- add hidden elements
  data.hide = hide

  -- register element
  elements[id] = data
end

--[[------------------------------------------------------------------
  Returns an element's information.
  @param {string} element identifier
  @return {table} element
]]--------------------------------------------------------------------
function GSRCHUD.element.get(id)
  return elements[id]
end

--[[------------------------------------------------------------------
  Returns all registered elements.
  @return {table} all elements
]]--------------------------------------------------------------------
function GSRCHUD.element.all()
  return elements
end

--[[------------------------------------------------------------------
  Draws all registered elements.
]]--------------------------------------------------------------------
function GSRCHUD.element.draw()
  -- do not draw without the suit
  if not GSRCHUD.hasSuit() then return end

  local _drawn = 0 -- elements drawn

  -- draw elements
  for id, element in pairs(elements) do
    -- check for override
    local shouldDraw = GSRCHUD.hook.run(SHOULDDRAW_HOOK, id)

		-- export hidden status
		element.drawn = shouldDraw ~= false

    -- if the element is disabled, do not draw
    if (element.convar and not element.convar:GetBool()) or not element.drawn then continue end

    -- clear previously set parameters before the next draw call
    element:clear()

    -- get current theme
    local theme = GSRCHUD.theme.get(GSRCHUD.theme.used())

    -- call preDraw functions from base classes
    local baseClass = theme.baseClass
    while baseClass do
      local base = GSRCHUD.theme.get(baseClass)
      local preDraw = base.elements[id]
      if preDraw then
        local _result = preDraw(element)
        if _result then continue end
      end
      baseClass = base.baseClass
    end

    -- call the current theme's predraw function
    local preDraw = theme.elements[id]
    if preDraw then
      local _result = preDraw(element)
      if _result then continue end
    end

    -- draw element
    element:draw()

    -- add as drawn
    _drawn = _drawn + 1
  end

  -- if the amount of elements drawn was different, fetch hidden CHud elements
  if _drawn ~= drawn then
    GSRCHUD.element.fetchHiddenElements()
    drawn = _drawn
  end
end

--[[------------------------------------------------------------------
  Imports the given element's exported values.
  @param {string} element identifier
  @return {table} exported values
]]--------------------------------------------------------------------
function GSRCHUD.element.import(id)
  return elements[id].exports
end

--[[------------------------------------------------------------------
  Fetches all currently hidden default HUD elements and registers them.
]]--------------------------------------------------------------------
function GSRCHUD.element.fetchHiddenElements()
  table.Empty(hide) -- flush previous elements
  for _, element in pairs(elements) do
    -- if the element is disabled, show the CHud elements
    if not element.hide or (element.convar and not element.convar:GetBool()) then continue end

    -- otherwise, hide them
    for _, hidden in pairs(element.hide) do
      hide[hidden] = true
    end
  end
end

--[[------------------------------------------------------------------
  Returns all currently hidden default HUD elements.
  @return {table} hidden elements
]]--------------------------------------------------------------------
function GSRCHUD.element.hiddenElements()
  return hide
end
