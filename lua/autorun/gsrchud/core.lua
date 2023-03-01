--[[------------------------------------------------------------------
  Core implementation
]]--------------------------------------------------------------------

-- include qmenu
GSRCHUD.include('qmenu/toolmenu.lua')

-- include core
GSRCHUD.include('core/hooks.lua')
GSRCHUD.include('core/config.lua')
GSRCHUD.include('core/themes.lua')
GSRCHUD.include('core/sprites.lua')
GSRCHUD.include('core/weapons.lua')
GSRCHUD.include('core/ammunition.lua')
GSRCHUD.include('core/items.lua')
GSRCHUD.include('core/hazards.lua')
GSRCHUD.include('core/elements.lua')
GSRCHUD.include('core/backwards.lua')

-- include utils
GSRCHUD.include('util/numbers.lua')
GSRCHUD.include('util/bind_press.lua')
GSRCHUD.include('util/weapon_switcher.lua')
GSRCHUD.shared('util/spectate.lua')
GSRCHUD.include('util/dloadingscreen.lua')

-- include themes
GSRCHUD.include('data/themes/default.lua')
GSRCHUD.include('data/themes/default320.lua')
GSRCHUD.include('data/themes/gearbox.lua')
GSRCHUD.include('data/themes/gearbox320.lua')
GSRCHUD.include('data/themes/ofdemo.lua')
GSRCHUD.include('data/themes/bshift.lua')
GSRCHUD.include('data/themes/decay.lua')
GSRCHUD.include('data/themes/cstrike.lua')
GSRCHUD.include('data/themes/czeror.lua')
GSRCHUD.include('data/themes/svencoop.lua')
GSRCHUD.include('data/themes/theyhunger.lua')
GSRCHUD.include('data/themes/aomdc.lua')
GSRCHUD.include('data/themes/hlwe.lua')
GSRCHUD.include('data/themes/echoes.lua')
GSRCHUD.include('data/themes/bhl.lua')
GSRCHUD.include('data/themes/halfnuked.lua')

-- include elements
GSRCHUD.include('elements/health.lua')
GSRCHUD.include('elements/suit.lua')
GSRCHUD.include('elements/ammunition.lua')
GSRCHUD.include('elements/weapon_selector.lua')
GSRCHUD.include('elements/pickup.lua')
GSRCHUD.shared('elements/death.lua')
GSRCHUD.shared('elements/damage.lua')
GSRCHUD.shared('elements/hazards.lua')
GSRCHUD.include('elements/flashlight.lua')
GSRCHUD.shared('elements/loading.lua')

-- load third-party add-ons
local files, directories = file.Find('autorun/gsrchud/add-ons/*.lua', 'LUA')
for _, file in pairs(files) do
  GSRCHUD.include('add-ons/' .. file)
end

if SERVER then return end

local ENABLED_HOOK = 'IsEnabled'
local SUIT_HOOK = 'RequireSuit'

local hadSuit = false -- whether the player had the suit equipped

-- [[ Common API ]] --

--[[------------------------------------------------------------------
  Returns whether the HUD is currently enabled.
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function GSRCHUD.isEnabled()
  local override = GSRCHUD.hook.run(ENABLED_HOOK)
  if override ~= nil then
    return override
  else
    return GSRCHUD.config.isEnabled()
  end
end

--[[------------------------------------------------------------------
  Returns the currently selected theme
  @return {THEME_} theme id
]]--------------------------------------------------------------------
function GSRCHUD.getCurrentTheme()
  return GSRCHUD.config.getTheme()
end

--[[------------------------------------------------------------------
  Whether the HUD acknowledges the player's suit.
  @return {boolean} has suit
]]--------------------------------------------------------------------
function GSRCHUD.hasSuit()
  return (not GSRCHUD.hook.run(SUIT_HOOK) and not GSRCHUD.config.drawWithNoSuit()) or hadSuit
end

--[[------------------------------------------------------------------
  Returns the currently selected theme colour.
  @return {Color} colour
]]--------------------------------------------------------------------
function GSRCHUD.getCurrentColour()
  if GSRCHUD.config.isColouringEnabled() then return GSRCHUD.config.getThemeColour() end
  return GSRCHUD.theme.get(GSRCHUD.getCurrentTheme()).colour
end

-- [[ Hide default HUD elements ]] --
GSRCHUD.element.fetchHiddenElements()
hook.Add('HUDShouldDraw', GSRCHUD.hookname, function(hide)
  if not GSRCHUD.isEnabled() or not GSRCHUD.element.hiddenElements()[hide] then return end
  return false
end)

-- [[ Draw all elements ]] --
hook.Add('HUDPaint', GSRCHUD.hookname, function()
  if not GSRCHUD.isEnabled() then return end

  -- refresh suit status while alive
  local localPlayer = GSRCHUD.localPlayer()
  if localPlayer:Health() > 0 then hadSuit = localPlayer:IsSuitEquipped() end

  GSRCHUD.number.run() -- run number logic

  -- draw elements
  local filter = TEXFILTER.NONE
  if GSRCHUD.config.hasTextureFiltering() then filter = TEXFILTER.LINEAR end
  render.PushFilterMag(filter)
  render.PushFilterMin(filter)
  GSRCHUD.element.draw()
  render.PopFilterMag()
  render.PopFilterMin()
end)
