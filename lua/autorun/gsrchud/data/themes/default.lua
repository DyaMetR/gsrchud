--[[
  DEFAULT THEME
  Use this theme as a template for all of your themes

  GSRCHUD:AddTheme(name, color, critColor, spriteData, ammoData, script)

  A sprite entry can look like this
  ["id"] = {x = x, y = y, w = width, h = height, file = {filename = filename, w = width, h = height}, xOffset = xOffset, yOffset = yOffset}

  Additionally, you can add a table for custom ammunition icons for specific ammo types, making an entry look like this
  [ammoType] = sprite

  You can also add a function that will run along side the rest of HUD drawing and add it on the 'script' field
]] -- DO NOT REMOVE THIS THEME! --

if CLIENT then
  local theme = "Half-Life"; -- Theme name

  -- Files required
  local file = {filename = "gsrchud/default/main", w = 256, h = 128};
  local file_hazard = {filename = "gsrchud/default/hazards", w = 256, h = 128};
  local file_misc = {filename = "gsrchud/default/misc", w = 256, h = 128};
  local pain_0 = {filename = "gsrchud/default/pain_0", w = 128, h = 64};
  local pain_1 = {filename = "gsrchud/default/pain_1", w = 64, h = 128};
  local pain_2 = {filename = "gsrchud/default/pain_2", w = 128, h = 64};
  local pain_3 = {filename = "gsrchud/default/pain_3", w = 64, h = 128};
  local small_numbers = {filename = "gsrchud/default/small_numbers", w = 128, h = 16};

  local spriteData = { -- Sprite data
    ["0"] = {x = 0, y = 0, w = 20, h = 24, file = file},
    ["1"] = {x = 24, y = 0, w = 20, h = 24, file = file},
    ["2"] = {x = 48, y = 0, w = 20, h = 24, file = file},
    ["3"] = {x = 72, y = 0, w = 20, h = 24, file = file},
    ["4"] = {x = 96, y = 0, w = 20, h = 24, file = file},
    ["5"] = {x = 120, y = 0, w = 20, h = 24, file = file},
    ["6"] = {x = 144, y = 0, w = 20, h = 24, file = file},
    ["7"] = {x = 168, y = 0, w = 20, h = 24, file = file},
    ["8"] = {x = 192, y = 0, w = 20, h = 23, file = file},
    ["9"] = {x = 216, y = 0, w = 20, h = 23, file = file},

    ["cross"] = {x = 80, y = 24, w = 32, h = 31, file = file},
    ["separator"] = {x = 240, y = 0, w = 2, h = 24, file = file},
    ["suit_empty"] = {x = 40, y = 24, w = 39, h = 39, file = file},
    ["suit_full"] = {x = 0, y = 24, w = 40, h = 39, file = file},

    ["bucket0"] = {x = 208, y = 92, w = 20, h = 20, file = file},
    ["bucket1"] = {x = 168, y = 72, w = 20, h = 20, file = file},
    ["bucket2"] = {x = 188, y = 72, w = 20, h = 20, file = file},
    ["bucket3"] = {x = 208, y = 72, w = 20, h = 20, file = file},
    ["bucket4"] = {x = 168, y = 92, w = 20, h = 20, file = file},
    ["bucket5"] = {x = 188, y = 92, w = 20, h = 20, file = file},
    ["bucket6"] = {x = 208, y = 92, w = 20, h = 20, file = file},

    ["pistol_ammo"] = {x = 0, y = 73, w = 24, h = 23, file = file},
    ["smg_gren_ammo"] = {x = 48, y = 73, w = 24, h = 23, file = file},
    ["357_ammo"] = {x = 24, y = 73, w = 24, h = 23, file = file},
    ["crossbow_ammo"] = {x = 96, y = 73, w = 24, h = 23, file = file},
    ["energy_ammo"] = {x = 0, y = 96, w = 24, h = 24, file = file},
    ["grenade_ammo"] = {x = 48, y = 96, w = 24, h = 24, file = file},
    ["hornet_ammo"] = {x = 24, y = 96, w = 24, h = 24, file = file},
    ["rpg_ammo"] = {x = 120, y = 73, w = 23, h = 23, file = file},
    ["satchel_ammo"] = {x = 72, y = 96, w = 24, h = 24, file = file},
    ["shotgun_ammo"] = {x = 72, y = 73, w = 24, h = 23, file = file},
    ["snark_ammo"] = {x = 96, y = 96, w = 24, h = 24, file = file},
    ["tripmine_ammo"] = {x = 120, y = 97, w = 24, h = 23, file = file},

    ["dmg_bio"] = {x = 128, y = 0, w = 64, h = 64, file = file_hazard},
    ["dmg_poison"] = {x = 128, y = 0, w = 64, h = 64, file = file_hazard},
    ["dmg_chem"] = {x = 0, y = 0, w = 64, h = 64, file = file_hazard},
    ["dmg_cold"] = {x = 64, y = 128, w = 64, h = 64, file = file_hazard},
    ["dmg_drown"] = {x = 64, y = 0, w = 64, h = 64, file = file_hazard},
    ["dmg_heat"] = {x = 128, y = 64, w = 64, h = 64, file = file_hazard},
    ["dmg_gas"] = {x = 0, y = 64, w = 64, h = 64, file = file_hazard},
    ["dmg_rad"] = {x = 192, y = 64, w = 64, h = 64, file = file_hazard},
    ["dmg_shock"] = {x = 192, y = 0, w = 64, h = 64, file = file_hazard},

    ["item_battery"] = {x = 177, y = 0, w = 43, h = 44, file = file_misc},
    ["item_healthkit"] = {x = 177, y = 46, w = 43, h = 44, file = file_misc},

    ["weapon_selected"] = {x = 0, y = 0, w = 170, h = 45, file = file_misc},
    ["weapon_slot"] = {x = 0, y = 46, w = 170, h = 45, file = file_misc},

    ["pain_up"] = {x = 0, y = 0, w = 120, h = 40, file = pain_0},
    ["pain_down"] = {x = 0, y = 0, w = 120, h = 40, file = pain_2},
    ["pain_right"] = {x = 0, y = 0, w = 40, h = 120, file = pain_1},
    ["pain_left"] = {x = 0, y = 0, w = 40, h = 120, file = pain_3},

    ["s0"] = {x = 1, y = 0, w = 9, h = 12, file = small_numbers},
    ["s1"] = {x = 11, y = 0, w = 9, h = 12, file = small_numbers},
    ["s2"] = {x = 21, y = 0, w = 9, h = 12, file = small_numbers},
    ["s3"] = {x = 31, y = 0, w = 9, h = 12, file = small_numbers},
    ["s4"] = {x = 41, y = 0, w = 9, h = 12, file = small_numbers},
    ["s5"] = {x = 51, y = 0, w = 9, h = 12, file = small_numbers},
    ["s6"] = {x = 61, y = 0, w = 9, h = 12, file = small_numbers},
    ["s7"] = {x = 71, y = 0, w = 9, h = 12, file = small_numbers},
    ["s8"] = {x = 81, y = 0, w = 9, h = 12, file = small_numbers},
    ["s9"] = {x = 91, y = 0, w = 9, h = 12, file = small_numbers}

  };

  GSRCHUD:AddTheme(theme, Color(255, 180, 0), Color(255, 0, 0), spriteData); -- Add theme
end
