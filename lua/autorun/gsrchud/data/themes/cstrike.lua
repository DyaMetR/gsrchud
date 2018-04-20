--[[
  Counter-Strike Theme
]]

if CLIENT then
  local theme = "Counter-Strike"; -- Theme name

  -- Files required
  local file = {filename = surface.GetTextureID("gsrchud/cstrike/main"), w = 256, h = 256};
  local file_misc = {filename = surface.GetTextureID("gsrchud/cstrike/misc"), w = 256, h = 128};

  local spriteData = { -- Sprite data
    ["0"] = {x = 0, y = 0, w = 20, h = 24, file = file},
    ["1"] = {x = 24, y = 0, w = 20, h = 24, file = file},
    ["2"] = {x = 48, y = 0, w = 20, h = 24, file = file},
    ["3"] = {x = 72, y = 0, w = 20, h = 24, file = file},
    ["4"] = {x = 96, y = 0, w = 20, h = 24, file = file},
    ["5"] = {x = 120, y = 0, w = 20, h = 24, file = file},
    ["6"] = {x = 144, y = 0, w = 20, h = 24, file = file},
    ["7"] = {x = 168, y = 0, w = 20, h = 24, file = file},
    ["8"] = {x = 192, y = 0, w = 20, h = 24, file = file},
    ["9"] = {x = 216, y = 0, w = 20, h = 24, file = file},

    ["cross"] = {x = 48, y = 25, w = 23, h = 23, file = file, yOffset = 1, wOffset = 10},
    ["separator"] = {x = 240, y = 0, w = 2, h = 24, file = file},
    ["suit_empty"] = {x = 24, y = 25, w = 24, h = 23, file = file, yOffset = 5},
    ["suit_full"] = {x = 0, y = 25, w = 24, h = 23, file = file, yOffset = 5},

    ["bucket0"] = {x = 208, y = 92, w = 20, h = 20, file = file},
    ["bucket1"] = {x = 168, y = 72, w = 20, h = 20, file = file},
    ["bucket2"] = {x = 188, y = 72, w = 20, h = 20, file = file},
    ["bucket3"] = {x = 208, y = 72, w = 20, h = 20, file = file},
    ["bucket4"] = {x = 168, y = 92, w = 20, h = 20, file = file},
    ["bucket5"] = {x = 188, y = 92, w = 20, h = 20, file = file},
    ["bucket6"] = {x = 208, y = 92, w = 20, h = 20, file = file},

    ["item_battery"] = {x = 177, y = 0, w = 43, h = 44, file = file_misc},
    ["item_healthkit"] = {x = 177, y = 46, w = 43, h = 44, file = file_misc},

    ["weapon_selected"] = {x = 0, y = 0, w = 170, h = 45, file = file_misc},
    ["weapon_slot"] = {x = 0, y = 46, w = 170, h = 45, file = file_misc}
  };

  GSRCHUD:AddTheme(theme, Color(255, 180, 0), Color(255, 0, 0), spriteData); -- Add theme
end
