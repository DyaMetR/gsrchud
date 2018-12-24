--[[------------
   GoldSrc Era
 Heads Up Display
  Version 1.7.1
   24/12/2018

By DyaMetR
]]--------------

-- Main framework table
GSRCHUD = {};

--[[
  METHODS
]]

--[[
  Correctly includes a file
  @param {string} file
  @void
]]--
function GSRCHUD:IncludeFile(file)
  if SERVER then
    include(file);
    AddCSLuaFile(file);
  end
  if CLIENT then
    include(file);
  end
end

--[[
  INCLUDES
]]
GSRCHUD:IncludeFile("gsrchud/core.lua");
