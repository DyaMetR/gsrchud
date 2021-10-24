--[[------------------------------------------------------------------
  Counter-Strike: Condition Zero Deleted Scenes theme
]]--------------------------------------------------------------------

local BUCKET, HUD2, HUD6, HUD7 = '640bucket', '640hud2', '640hud6', '640hud7'

-- create theme
local THEME = GSRCHUD.theme.create(GSRCHUD.THEME_COUNTERSTRIKE)

--[[ Colour ]]--
THEME:setColour(Color(0, 255, 0))

--[[ Files ]]--
THEME:addTexture(BUCKET, surface.GetTextureID('gsrchud/czeror/640bucket'), 256, 64)
THEME:addTexture(HUD2, surface.GetTextureID('gsrchud/czeror/640hud2'), 256, 256)
THEME:addTexture(HUD6, surface.GetTextureID('gsrchud/czeror/640hud6'), 256, 256)
THEME:addTexture(HUD7, surface.GetTextureID('gsrchud/czeror/640hud7'), 256, 256)

--[[ Sprites ]]--
THEME:addSprite('item_kevlar', HUD2, 176, 0, 44, 44)

--[[ Items ]]--
THEME:setItemSprite('item_battery', 'item_kevlar')

--[[ Ammunition ]]--
THEME:addAmmoSprite('SMG1', HUD7, 72, 124, 24, 24)

--[[ Custom element parameters ]]--
THEME:addPreDraw('suit', function(element)
  local localPlayer = GSRCHUD.localPlayer()
  element:set('colour', localPlayer.Armor and localPlayer:Armor() <= 25)
end)
THEME:addPreDraw('ammo', function(element)
  local weapon = LocalPlayer():GetActiveWeapon()
  if not IsValid(weapon) then return end
  local isValid, primary, secondary, clip1, reserve, alt = GSRCHUD.weapon.ammo(weapon)
  if not isValid then return end
  element:set('clipColour', clip1 <= weapon:GetMaxClip1() * .15)
  element:set('reserveColour', reserve <= game.GetAmmoMax(primary) * .15)
end)

--[[ Register ]]--
GSRCHUD.THEME_CSDELETEDSCENES = GSRCHUD.theme.register('Counter-Strike: Condition Zero Deleted Scenes', THEME)
