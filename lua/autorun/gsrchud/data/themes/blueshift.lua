--[[
  Half-Life: Blue Shift Theme
]]

if CLIENT then
  local theme = "Blue Shift"; -- Theme name

  -- Files required
  local file = {filename = surface.GetTextureID("gsrchud/blueshift/bs_hud"), w = 128, h = 64};

  local spriteData = { -- Sprite data
    ["item_battery"] = {x = 45, y = 0, w = 44, h = 44, file = file}
  };

  GSRCHUD:AddTheme(theme, Color(95, 95, 255), Color(255, 0, 0), spriteData); -- Add theme
end
