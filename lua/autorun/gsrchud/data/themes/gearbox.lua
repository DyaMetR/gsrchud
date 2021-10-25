--[[------------------------------------------------------------------
  Half-Life: Opposing Force theme
]]--------------------------------------------------------------------

local BUCKET, HUD1, HUD2, HUD3, HUD4, HUD5, HUD6, HUD7, HUD8, HUD9 = '640bucket', '640hud1', '640hud2', '640hud3', '640hud4', '640hud5', '640hud6', '640hud7', '640hud8', '640hud9'
local GMOD1, GMOD2, GMOD3, GMOD4, GMOD5, GMOD6 = '640gmod1', '640gmod2', '640gmod3', '640gmod4', '640gmod5', '640gmod6'
local TFCHUD5, TFCHUD6 = 'tfchud5', 'tfchud6'
local PAIN0, PAIN1, PAIN2, PAIN3 = '640pain0', '640pain1', '640pain2', '640pain3'

-- create theme
local THEME = GSRCHUD.theme.create(GSRCHUD.THEME_HALFLIFE)

--[[ Colour ]]--
THEME:setColour(Color(0, 255, 0))

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/gearbox/640bucket'), 256, 64)
THEME:addTexture(HUD1, surface.GetTextureID('gsrchud/gearbox/640hud1'), 256, 256)
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/gearbox/640hud2'), 256, 256)
THEME:addTexture(HUD3, surface.GetTextureID('gsrchud/gearbox/640hud3'), 256, 256)
THEME:addTexture(HUD4, surface.GetTextureID('gsrchud/gearbox/640hud4'), 256, 256)
THEME:addTexture(HUD5, surface.GetTextureID('gsrchud/gearbox/640hud5'), 256, 256)
THEME:addTexture(HUD6, surface.GetTextureID('gsrchud/gearbox/640hud6'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/gearbox/640hud7'), 256, 128)
THEME:addTexture(HUD8, surface.GetTextureID('gsrchud/gearbox/640hud8'), 256, 64)
THEME:addTexture(HUD9, surface.GetTextureID('gsrchud/gearbox/640hud9'), 256, 64)
THEME:addTexture(GMOD1, surface.GetTextureID('gsrchud/gearbox/640gmod1'), 256, 256)
THEME:addTexture(GMOD2, surface.GetTextureID('gsrchud/gearbox/640gmod2'), 256, 256)
THEME:addTexture(GMOD3, surface.GetTextureID('gsrchud/gearbox/640gmod3'), 256, 256)
THEME:addTexture(GMOD4, surface.GetTextureID('gsrchud/gearbox/640gmod4'), 256, 256)
THEME:addTexture(GMOD5, surface.GetTextureID('gsrchud/gearbox/640gmod5'), 256, 256)
THEME:addTexture(GMOD6, surface.GetTextureID('gsrchud/gearbox/640gmod6'), 256, 256)
THEME:addTexture(TFCHUD5, surface.GetTextureID('gsrchud/gearbox/tfchud5'), 256, 256)
THEME:addTexture(TFCHUD6, surface.GetTextureID('gsrchud/gearbox/tfchud6'), 256, 256)
THEME:addTexture(PAIN0, surface.GetTextureID('gsrchud/gearbox/640pain0'), 128, 64)
THEME:addTexture(PAIN1, surface.GetTextureID('gsrchud/gearbox/640pain1'), 64, 128)
THEME:addTexture(PAIN2, surface.GetTextureID('gsrchud/gearbox/640pain2'), 128, 64)
THEME:addTexture(PAIN3, surface.GetTextureID('gsrchud/gearbox/640pain3'), 64, 128)

--[[ Sprites ]]--
THEME:addSprite('flash_full', HUD7, 160, 24, 31, 32)
THEME:addSprite('flash_empty', HUD7, 112, 24, 33, 32)
THEME:addSprite('flash_beam', HUD7, 145, 24, 15, 32)

--[[ Custom element parameters ]]--
THEME:addPreDraw('damage', function(element)
  if GSRCHUD.localPlayer():Health() > 25 then
    local colour = THEME.colour
    if GSRCHUD.config.isColouringEnabled() then colour = GSRCHUD.config.getHealthColour() end
    element:set('colour', colour)
  end
end)

--[[ Register ]]--
GSRCHUD.THEME_OPPOSINGFORCE = GSRCHUD.theme.register('Half-Life: Opposing Force', THEME)
