--[[
  Sven Co-op Theme
]]

if CLIENT then
  local theme = "Sven Co-op"; -- Theme name

  local file = {filename = "gsrchud/svencoop/main", w = 256, h = 128};

  local spriteData = { -- Sprite data
    ["0"] = {x = 0, y = 0, w = 20, h = 20, file = file},
    ["1"] = {x = 20, y = 0, w = 20, h = 20, file = file},
    ["2"] = {x = 40, y = 0, w = 20, h = 20, file = file},
    ["3"] = {x = 60, y = 0, w = 20, h = 20, file = file},
    ["4"] = {x = 80, y = 0, w = 20, h = 20, file = file},
    ["5"] = {x = 100, y = 0, w = 20, h = 20, file = file},
    ["6"] = {x = 120, y = 0, w = 20, h = 20, file = file},
    ["7"] = {x = 140, y = 0, w = 20, h = 20, file = file},
    ["8"] = {x = 160, y = 0, w = 20, h = 20, file = file},
    ["9"] = {x = 180, y = 0, w = 20, h = 20, file = file},

    ["cross"] = {x = 74, y = 24, w = 34, h = 35, file = file, yOffset = -8, wOffset = 6},
    ["suit_empty"] = {x = 36, y = 20, w = 32, h = 38, file = file, yOffset = -8},
    ["suit_full"] = {x = 0, y = 20, w = 32, h = 38, file = file, yOffset = -8},

    ["bucket0"] = {x = 200, y = 108, w = 20, h = 20, file = file},
    ["bucket1"] = {x = 0, y = 108, w = 20, h = 20, file = file},
    ["bucket2"] = {x = 20, y = 108, w = 20, h = 20, file = file},
    ["bucket3"] = {x = 40, y = 108, w = 20, h = 20, file = file},
    ["bucket4"] = {x = 60, y = 108, w = 20, h = 20, file = file},
    ["bucket5"] = {x = 80, y = 108, w = 20, h = 20, file = file},
    ["bucket6"] = {x = 100, y = 108, w = 20, h = 20, file = file}
  };

  GSRCHUD:AddTheme(theme, Color(186, 205, 255), Color(255, 0, 0), spriteData); -- Add theme
end
