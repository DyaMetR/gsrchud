--[[------------
   GoldSrc Era
 Heads Up Display
  Version 1.10.0
   01/06/2019

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
