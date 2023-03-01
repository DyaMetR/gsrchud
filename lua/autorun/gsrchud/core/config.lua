--[[------------------------------------------------------------------
  Settings
]]--------------------------------------------------------------------

GSRCHUD.config = {} -- namespace

GSRCHUD.config.PARAM_CHECK = 0
GSRCHUD.config.PARAM_NUMERIC = 1
GSRCHUD.config.PARAM_TEXT = 2

local PREFIX = 'gsrchud_%s'
local GETTER_PREFIX = 'get%s'
local COLOUR_PREFIX = 'get%sColour'

local convars = {} -- convars to reset
local colours = {} -- cached colours
local themeColours = {} -- colours that are affected by theme recolouring

--[[------------------------------------------------------------------
  Creates a console variable for the HUD.
  @param {string} name
  @param {any} default value
  @param {PARAM_|nil} parameter type
  @return {ConVar} resulting console variable
]]--------------------------------------------------------------------
function GSRCHUD.config.createConVar(name, default, _type, prefix)
  default = default or 1 -- default to 1
  _type = _type or GSRCHUD.config.PARAM_CHECK -- default to checkbox
  prefix = prefix or GETTER_PREFIX -- default to 'get'

  -- create console variable
  local convar = CreateClientConVar(string.format(PREFIX, string.lower(name)), default, true)

  -- change first letter to be capital
  name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)

  -- select which function to use to retrieve value
  local func
  if _type <= GSRCHUD.config.PARAM_CHECK then
    func = function() return convar:GetBool() end
  elseif _type == GSRCHUD.config.PARAM_NUMERIC then
    func = function() return convar:GetFloat() end
  else
    func = function() return convar:GetString() end
  end

  -- create a getter
  GSRCHUD.config[string.format(prefix, name)] = func

  -- add to list
  table.insert(convars, convar)

  return convar
end

--[[------------------------------------------------------------------
  Creates a colour based console variable.
  @param {string} name
  @param {Color} default value
  @param {boolean} is it affected by theme recolouring
]]--------------------------------------------------------------------
function GSRCHUD.config.createColourConVar(name, default, isTheme)
  default = default or Color(255, 255, 255)

  -- console variable name should always be lowercase
  local _name = string.lower(name)

  -- create component variables
  local r = CreateClientConVar(string.format(PREFIX, _name) .. '_r', default.r, true)
  local g = CreateClientConVar(string.format(PREFIX, _name) .. '_g', default.g, true)
  local b = CreateClientConVar(string.format(PREFIX, _name) .. '_b', default.b, true)

  -- cache it
  colours[_name] = Color(r:GetInt(), g:GetInt(), b:GetInt())

  -- add a callbacks to modify cache
  cvars.AddChangeCallback(r:GetName(), function(_, _, value) colours[_name].r = tonumber(value) end)
  cvars.AddChangeCallback(g:GetName(), function(_, _, value) colours[_name].g = tonumber(value) end)
  cvars.AddChangeCallback(b:GetName(), function(_, _, value) colours[_name].b = tonumber(value) end)

  -- change first letter to be capital for the function name
  local funcName = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)

  -- add getter
  GSRCHUD.config[string.format(COLOUR_PREFIX, funcName)] = function() return colours[_name] end

  -- add it to theme list (if true)
  if isTheme then themeColours[_name] = true end
end

--[[------------------------------------------------------------------
  Default console variables
]]--------------------------------------------------------------------
GSRCHUD.config.createConVar('enabled', 1, GSRCHUD.config.PARAM_CHECK, 'is%s')
GSRCHUD.config.createConVar('scale', 1, GSRCHUD.config.PARAM_NUMERIC)
GSRCHUD.config.createConVar('theme', GSRCHUD.THEME_HALFLIFE, GSRCHUD.config.PARAM_NUMERIC)
GSRCHUD.config.createConVar('noSuit', 0, GSRCHUD.config.PARAM_CHECK, 'drawWith%s')
GSRCHUD.config.createConVar('skipEmpty', 1, GSRCHUD.config.PARAM_CHECK, 'should%s')
GSRCHUD.config.createConVar('alpha', 100, GSRCHUD.config.PARAM_NUMERIC)
GSRCHUD.config.createConVar('highlight', 128, GSRCHUD.config.PARAM_NUMERIC)
GSRCHUD.config.createConVar('switcherScrollSound', 1, GSRCHUD.config.PARAM_CHECK)
GSRCHUD.config.createConVar('dynamicSpacing', 1, GSRCHUD.config.PARAM_CHECK)
GSRCHUD.config.createConVar('consoleWarn', 0, GSRCHUD.config.PARAM_CHECK)
GSRCHUD.config.createConVar('loadingOnRespawn', 0, GSRCHUD.config.PARAM_CHECK, 'show%s')
GSRCHUD.config.createConVar('filter', 0, GSRCHUD.config.PARAM_CHECK, 'hasTextureFiltering')

--[[------------------------------------------------------------------
  Colouring
]]--------------------------------------------------------------------
local DEFAULT_COLOUR = Color(255, 160, 0) -- Half-Life colours as default
local DEFAULT_CRIT_COLOUR = Color(255, 0, 0) -- Red as default critical colour
GSRCHUD.config.createConVar('colouring', 0, GSRCHUD.config.PARAM_CHECK, 'is%sEnabled')
GSRCHUD.config.createColourConVar('theme', DEFAULT_COLOUR)
GSRCHUD.config.createColourConVar('crit', DEFAULT_CRIT_COLOUR)
GSRCHUD.config.createColourConVar('health', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('lseparator', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('suit', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('clip', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('rseparator', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('ammo', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('weapon_selector', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('pickup', DEFAULT_COLOUR, true)
GSRCHUD.config.createColourConVar('flashlight', DEFAULT_COLOUR, true)

--[[------------------------------------------------------------------
  Create console command to set all components to the same colour.
]]--------------------------------------------------------------------
local components = {'_r', '_g', '_b'}
for _, component in pairs(components) do
  cvars.AddChangeCallback(string.format(PREFIX, 'theme' .. component), function(cvar, old, new)
    for name, _ in pairs(themeColours) do
      RunConsoleCommand(string.format(PREFIX, name .. component), new)
    end
  end)
end

--[[------------------------------------------------------------------
  Create console command to reset all colours
]]--------------------------------------------------------------------
concommand.Add(string.format(PREFIX, 'reset_colours'), function(_, _, _)
  for name, _ in pairs(colours) do
    for _, component in pairs(components) do
      local convar = string.format(PREFIX, name .. component)
      RunConsoleCommand(convar, GetConVar(convar):GetDefault())
    end
  end
end)

--[[------------------------------------------------------------------
  Create console command to reset parameters to default.
]]--------------------------------------------------------------------
concommand.Add(string.format(PREFIX, 'reset'), function(_, _, _)
  for _, convar in pairs(convars) do
    RunConsoleCommand(convar:GetName(), convar:GetDefault())
  end
end)
