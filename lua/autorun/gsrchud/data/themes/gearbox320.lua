--[[------------------------------------------------------------------
  320x200 version of the Half-Life: Opposing Force theme
]]--------------------------------------------------------------------

local BUCKET, HUD1, HUD2, HUD4, GMOD1 = '320bucket', '320hud1', '320hud2', '320hud4', '320gmod1'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'

-- create theme
local THEME = GSRCHUD.theme.create(GSRCHUD.THEME_HALFLIFE320)

--[[ Colour ]]--
THEME:setColour(Color(0, 255, 0))

--[[ Files ]]--
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/gearbox/320hud2'), 128, 128)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/gearbox/320pain0'), 64, 32)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/gearbox/320pain1'), 32, 64)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/gearbox/320pain2'), 64, 32)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/gearbox/320pain3'), 32, 64)

THEME:addSprite('bucket0', HUD2, 108, 99, 12, 12)
THEME:addSprite('bucket6', HUD2, 108, 75, 12, 12)

THEME:addSprite('pain0', PAIN0, 0, 0, 60, 20)
THEME:addSprite('pain1', PAIN1, 0, 0, 20, 60)
THEME:addSprite('pain2', PAIN2, 0, 0, 60, 20)
THEME:addSprite('pain3', PAIN3, 0, 0, 20, 60)

-- numbers
for i=0, 9 do
  THEME:addSprite(string.format('number_%i', i), HUD2, 12 * i, 0, 12, 16)
end

THEME:addSprite('divider', HUD2, 120, 0, 1, 16)

THEME:addSprite('cross', HUD2, 0, 72, 16, 16)

THEME:addSprite('suit_full', HUD2, 0, 52, 20, 20)
THEME:addSprite('suit_empty', HUD2, 20, 52, 20, 20)

THEME:addSprite('flash_full', HUD2, 16, 72, 18, 16)
THEME:addSprite('flash_empty', HUD2, 34, 72, 18, 16)
THEME:addSprite('flash_beam', HUD2, 52, 72, 6, 16)

THEME:addSprite('item_battery', HUD2, 48, 52, 20, 20)
THEME:addSprite('item_healthkit', HUD2, 68, 52, 20, 20)
THEME:addSprite('item_longjump', HUD2, 88, 52, 20, 20)

--[[ Custom element parameters ]]--
THEME:addPreDraw('damage', function(element)
  if GSRCHUD.localPlayer():Health() > 25 then
    local colour = THEME.colour
    if GSRCHUD.config.isColouringEnabled() then colour = GSRCHUD.config.getHealthColour() end
    element:set('colour', colour)
  end
end)

--[[ Register ]]--
GSRCHUD.THEME_OPPOSINGFORCE320 = GSRCHUD.theme.register('Half-Life: Opposing Force (320x200)', THEME)
