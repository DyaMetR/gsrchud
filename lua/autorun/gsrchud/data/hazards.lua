--[[
  DEFAULT HAZARD TYPES
]]

if CLIENT then
  GSRCHUD:AddHazard(DMG_POISON, "dmg_poison");
  GSRCHUD:AddHazard(DMG_PARALYZE, "dmg_poison");

  GSRCHUD:AddHazard(DMG_ACID, "dmg_chem");
  GSRCHUD:AddHazard(DMG_DROWN, "dmg_drown");

  GSRCHUD:AddHazard(DMG_BURN, "dmg_heat");
  GSRCHUD:AddHazard(DMG_SLOWBURN, "dmg_heat");
  GSRCHUD:AddHazard(DMG_PLASMA, "dmg_heat");

  GSRCHUD:AddHazard(DMG_NERVEGAS, "dmg_gas");
  GSRCHUD:AddHazard(DMG_RADIATION, "dmg_rad");

  GSRCHUD:AddHazard(DMG_SHOCK, "dmg_shock");
  GSRCHUD:AddHazard(DMG_ENERGYBEAM, "dmg_shock");
end
