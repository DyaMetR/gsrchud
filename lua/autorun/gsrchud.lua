--[[------------
   GoldSrc Era
 Heads Up Display
  Version 1.12.2
   09/05/2020

By DyaMetR
]]--------------

-- Main framework table
GSRCHUD = {};
GSRCHUD.Version = "1.12.2";

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
