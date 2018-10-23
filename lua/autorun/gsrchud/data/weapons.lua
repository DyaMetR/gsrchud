--[[
  DEFAULT WEAPON ICONS
]]

if CLIENT then
  -- Half-Life 2 weapon icons
  GSRCHUD:AddWeaponIcon("weapon_crowbar", "gsrchud/common/default_weapons/crowbar");
  GSRCHUD:AddWeaponIcon("weapon_physgun", "gsrchud/common/default_weapons/physgun");
  GSRCHUD:AddWeaponIcon("weapon_physcannon", "gsrchud/common/default_weapons/physcannon");
  GSRCHUD:AddWeaponIcon("weapon_pistol", "gsrchud/common/default_weapons/pistol");
  GSRCHUD:AddWeaponIcon("weapon_357", "gsrchud/common/default_weapons/357");
  GSRCHUD:AddWeaponIcon("weapon_smg1", "gsrchud/common/default_weapons/smg1");
  GSRCHUD:AddWeaponIcon("weapon_ar2", "gsrchud/common/default_weapons/ar2");
  GSRCHUD:AddWeaponIcon("weapon_shotgun", "gsrchud/common/default_weapons/shotgun");
  GSRCHUD:AddWeaponIcon("weapon_crossbow", "gsrchud/common/default_weapons/crossbow");
  GSRCHUD:AddWeaponIcon("weapon_rpg", "gsrchud/common/default_weapons/rpg");
  GSRCHUD:AddWeaponIcon("weapon_frag", "gsrchud/common/default_weapons/frag");
  GSRCHUD:AddWeaponIcon("weapon_bugbait", "gsrchud/common/default_weapons/bugbait");
  GSRCHUD:AddWeaponIcon("weapon_slam", "gsrchud/common/default_weapons/slam");
  GSRCHUD:AddWeaponIcon("weapon_stunstick", "gsrchud/common/default_weapons/stunstick");

  -- HL1 weapons sprite sheets -- so sorry for the delay, upset!
  local hud1 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud1");
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_crowbar", hud1, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_glock", hud1, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_357", hud1, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_mp5", hud1, 256, 256, 0, 135, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_shotgun", hud1, 256, 256, 0, 180, 170, 45);

  local hud2 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud2");
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_crossbow", hud2, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_rpg", hud2, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_gauss", hud2, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_egon", hud2, 256, 256, 0, 135, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_hornetgun", hud2, 256, 256, 0, 180, 170, 45);

  local hud3 = surface.GetTextureID("gsrchud/common/hl1_weapons_upset/640hud3");
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_handgrenade", hud3, 256, 256, 0, 0, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_satchel", hud3, 256, 256, 0, 45, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_tripmine", hud3, 256, 256, 0, 90, 170, 45);
  GSRCHUD:AddWeaponSpritesheet("weapon_hl1_snark", hud3, 256, 256, 0, 135, 170, 45);
end
