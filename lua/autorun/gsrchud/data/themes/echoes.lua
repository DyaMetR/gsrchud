--[[
  Half-Life: Echoes Theme
]]

if CLIENT then
  local theme = "Echoes"; -- Theme name

  -- Files required
  local armour = {filename = surface.GetTextureID("gsrchud/blueshift/bs_hud"), w = 128, h = 64};
  local main = {filename = surface.GetTextureID("gsrchud/echoes/main"), w = 256, h = 128};

  local spriteData = { -- Sprite data
    ["item_battery"] = {x = 45, y = 0, w = 44, h = 44, file = armour},
    ["suit_empty"] = {x = 40, y = 24, w = 39, h = 39, file = main},
    ["suit_full"] = {x = 0, y = 24, w = 40, h = 39, file = main}
  };

  GSRCHUD:AddTheme(theme, Color(255, 255, 255), Color(255, 0, 0), spriteData); -- Add theme
end
