--[[
  CUSTOM SPRITES
]]

if CLIENT then
  local hud1 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud1");
  GSRCHUD:AddCustomSprite("hl1/icons/crowbar", hud1, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/glock", hud1, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/357", hud1, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/mp5", hud1, 256, 256, 0, 135, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/shotgun", hud1, 256, 256, 0, 180, 170, 45);

  local hud2 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud2");
  GSRCHUD:AddCustomSprite("hl1/icons/crossbow", hud2, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/rpg", hud2, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/gauss", hud2, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/egon", hud2, 256, 256, 0, 135, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/hgun", hud2, 256, 256, 0, 180, 170, 45);

  local hud3 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud3");
  GSRCHUD:AddCustomSprite("hl1/icons/grenade", hud3, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/satchel", hud3, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/tripmine", hud3, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddCustomSprite("hl1/icons/snark", hud3, 256, 256, 0, 135, 170, 45);
end
