--[[
  Half-Life: Weapon Edition Theme
]]

if CLIENT then
  local theme = "Weapon Edition"; -- Theme name

  local file = {filename = surface.GetTextureID("gsrchud/hlwe/main"), w = 256, h = 128};
  local file_slots = {filename = surface.GetTextureID("gsrchud/hlwe/slots"), w = 128, h = 512};
  local file_misc = {filename = surface.GetTextureID("gsrchud/hlwe/misc"), w = 256, h = 128};
  local pain_0 = {filename = surface.GetTextureID("gsrchud/hlwe/pain_0"), w = 128, h = 64};
  local pain_1 = {filename = surface.GetTextureID("gsrchud/hlwe/pain_1"), w = 128, h = 128};
  local pain_2 = {filename = surface.GetTextureID("gsrchud/hlwe/pain_2"), w = 256, h = 64};
  local pain_3 = {filename = surface.GetTextureID("gsrchud/hlwe/pain_3"), w = 128, h = 128};

  local spriteData = { -- Sprite data
    ["0"] = {x = 0, y = 0, w = 20, h = 21, file = file},
    ["1"] = {x = 24, y = 0, w = 20, h = 21, file = file},
    ["2"] = {x = 48, y = 0, w = 20, h = 21, file = file},
    ["3"] = {x = 72, y = 0, w = 20, h = 21, file = file},
    ["4"] = {x = 96, y = 0, w = 20, h = 21, file = file},
    ["5"] = {x = 120, y = 0, w = 20, h = 21, file = file},
    ["6"] = {x = 144, y = 0, w = 20, h = 21, file = file},
    ["7"] = {x = 168, y = 0, w = 20, h = 21, file = file},
    ["8"] = {x = 192, y = 0, w = 20, h = 21, file = file},
    ["9"] = {x = 216, y = 0, w = 20, h = 21, file = file},

    ["cross"] = {x = 80, y = 24, w = 32, h = 31, file = file},
    ["separator"] = {x = 240, y = 0, w = 2, h = 24, file = file},
    ["suit_empty"] = {x = 40, y = 24, w = 39, h = 39, file = file},
    ["suit_full"] = {x = 0, y = 24, w = 40, h = 39, file = file},

    ["bucket0"] = {x = 0, y = 432, w = 65, h = 52, file = file_slots},
    ["bucket1"] = {x = 0, y = 0, w = 65, h = 48, file = file_slots},
    ["bucket2"] = {x = 0, y = 48, w = 65, h = 48, file = file_slots},
    ["bucket3"] = {x = 0, y = 96, w = 65, h = 48, file = file_slots},
    ["bucket4"] = {x = 0, y = 144, w = 65, h = 48, file = file_slots},
    ["bucket5"] = {x = 0, y = 192, w = 65, h = 48, file = file_slots},
    ["bucket6"] = {x = 0, y = 240, w = 65, h = 48, file = file_slots},

    ["pistol_ammo"] = {x = 17, y = 73, w = 19, h = 23, file = file},
    ["smg_gren_ammo"] = {x = 48, y = 73, w = 24, h = 23, file = file},
    ["357_ammo"] = {x = 35, y = 73, w = 15, h = 23, file = file},
    ["crossbow_ammo"] = {x = 96, y = 73, w = 24, h = 23, file = file},
    ["energy_ammo"] = {x = 0, y = 96, w = 24, h = 24, file = file},
    ["grenade_ammo"] = {x = 48, y = 96, w = 24, h = 24, file = file},
    ["hornet_ammo"] = {x = 24, y = 96, w = 24, h = 24, file = file},
    ["rpg_ammo"] = {x = 120, y = 73, w = 23, h = 23, file = file},
    ["satchel_ammo"] = {x = 72, y = 96, w = 24, h = 24, file = file},
    ["shotgun_ammo"] = {x = 72, y = 73, w = 24, h = 23, file = file},
    ["snark_ammo"] = {x = 96, y = 96, w = 24, h = 24, file = file},
    ["tripmine_ammo"] = {x = 120, y = 97, w = 24, h = 23, file = file},

    ["weapon_selected"] = {x = 0, y = 0, w = 170, h = 52, file = file_misc},
    ["weapon_slot"] = {x = 0, y = 52, w = 170, h = 52, file = file_misc},

    ["pain_up"] = {x = 13, y = 0, w = 93, h = 16, file = pain_0, xOffset = 1, yOffset = 40},
    ["pain_down"] = {x = 0, y = 0, w = 223, h = 48, file = pain_2},
    ["pain_right"] = {x = 0, y = 0, w = 87, h = 100, file = pain_1},
    ["pain_left"] = {x = 0, y = 0, w = 87, h = 100, file = pain_3}
  };

  GSRCHUD:AddTheme(theme, Color(255, 180, 0), Color(255, 0, 0), spriteData); -- Add theme
end
