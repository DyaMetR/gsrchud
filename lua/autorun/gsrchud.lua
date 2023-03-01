--[[------------------------------------------------------------------
  GoldSrc HUD
  Version 2.4
  March 1st, 2023
  Made by DyaMetR
  * full credits found in the details below
]]--------------------------------------------------------------------

GSRCHUD = {}

-- hook name
GSRCHUD.hookname      = 'gsrchud'

if CLIENT then
  -- addon information
  GSRCHUD.name      = 'GoldSrc HUD'
  GSRCHUD.category  = 'DyaMetR'
  GSRCHUD.version   = '2.4'
  GSRCHUD.date      = 'Match 1st, 2023'
  GSRCHUD.credits   = { -- {name, contribution}
    {'DyaMetR', 'Developer'},
    {'Valve Software', 'Original layout design\nHalf-Life sprites\nCounter-Strike sprites'},
    {'Gearbox Interactive', 'Half-Life: Opposing Force sprites\nHalf-Life: Blue Shift sprites'},
    {'Turtle Rock Studios', 'Counter-Strike: Condition Zero Deleted Scenes sprites'},
    {'Sven-Coop team', 'Sven Co-op layout design\nSven-Coop sprites'},
    {'ruMpel', 'Afraid of Monsters layout design\nAfraid of Monsters sprites'},
    {'Ghoul-bb', 'Half-Life: Weapon Edition sprites'},
    {'Black Widow Games', 'They Hunger layout design\nThey Hunger sprites'},
    {'MrGnang', 'Half-Life: Echoes sprites'},
    {'zoonyarts', 'Brutal Half-Life sprites'},
    {'Z00L', 'Half-Nuked sprites'}
  }
end

--[[------------------------------------------------------------------
  Includes a clientside file
  @param {string} file
]]--------------------------------------------------------------------
function GSRCHUD.include(path)
  if CLIENT then include(path) end
  if SERVER then AddCSLuaFile(path) end
end

--[[------------------------------------------------------------------
  Includes a file sharedwise
  @param {string} file
]]--------------------------------------------------------------------
function GSRCHUD.shared(path)
  include(path)
  if SERVER then AddCSLuaFile(path) end
end

-- include core
GSRCHUD.include('gsrchud/logging.lua')
GSRCHUD.shared('gsrchud/core.lua')
