--[[------------------------------------------------------------------
  Weapon selector drawing functions
]]--------------------------------------------------------------------

local SELECTION, BUCKET, SLOT, BUCKET0 = 'selection', 'bucket', 'bucket%i', 'bucket0'
local CAMERA = 'gmod_camera'

GSRCHUD.switcher.MODE_CLASSIC = 0
GSRCHUD.switcher.MODE_NOSPRITE = 1 -- do not use 'selected' sprite, only reduce alpha in unselected

local BUCKET_WIDTH = 170 -- default bucket width
local BAR_BACKGROUND_ALPHA = 100
local BAR_FOREGROUND_COLOUR = Color(0, 255, 0, 255)
local BAR_ORIGIN, BAR_MARGIN, BAR_WIDTH = 10, 5, 20
local BAR_TEXTURE = surface.GetTextureID('gsrchud/_shared/white_additive')
local NOSPRITE_ALPHA = 100 -- alpha of unselected weapons in NOSPRITE mode
local DEFAULT_ALPHA = 255

local barColour = Color(255, 255, 255, BAR_BACKGROUND_ALPHA)

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

--[[------------------------------------------------------------------
  Draws a reserve ammunition bar.
  @param {number} x
  @param {number} y
  @param {number} value
  @param {Color} background colour
  @param {number} scale
  @param {number} opacity scale
]]--------------------------------------------------------------------
local function drawBar(x, y, value, colour, scale, alpha)
  value = math.min(value, 1)
  surface.SetTexture(BAR_TEXTURE)

  local w = BAR_WIDTH * scale
  local fill = math.Round(w * value)

  -- change colour cache
  barColour.r = colour.r
  barColour.g = colour.g
  barColour.b = colour.b
  barColour.a = BAR_BACKGROUND_ALPHA * alpha

  -- background
  surface.SetDrawColor(barColour)
  surface.DrawTexturedRect(x + fill, y, w - fill, 4 * scale)

  -- foreground
  BAR_FOREGROUND_COLOUR.a = DEFAULT_ALPHA * alpha
  surface.SetDrawColor(BAR_FOREGROUND_COLOUR)
  surface.DrawTexturedRect(x, y, fill, 4 * scale)
end

--[[------------------------------------------------------------------
  Draws a weapons slot.
  @param {number} x
  @param {number} y
  @param {number} slot
  @param {table} weapons in slot
  @param {boolean} whether the weapon icons should be shown
  @param {number} currently selected weapon's position
  @param {number} margin between slots
  @param {boolean|Color} header colour
  @param {boolean|Color} slot colour
  @param {MODE_|nil} weapon icon highlighting mode
  @param {number} scale
  @return {number} width
  @return {number} height
]]--------------------------------------------------------------------
local function drawSlot(x, y, slot, weapons, slotSelected, curPos, margin, headerCol, slotCol, mode, scale)
  scale = scale or GSRCHUD.sprite.scale()
  slot = math.Clamp(slot, 1, 6)
  local _alpha = math.min(GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA, 1)

  -- draw slot
  local _, h = GSRCHUD.sprite.draw(string.format(SLOT, slot), x, y, GSRCHUD.sprite.userColour(GSRCHUD.config.getWeapon_selectorColour(), headerCol), nil, nil, scale, DEFAULT_ALPHA * _alpha)
  y = y + h

  -- get icons' height
  local sprite = BUCKET0
  if slotSelected then sprite = BUCKET end
  w, h = GSRCHUD.sprite.getSize(sprite, scale)

  -- draw weapon icons
  for pos, weapon in pairs(weapons) do
    if not IsValid(weapon) then continue end -- do not draw if it's invalid

    local _colour = slotCol

    -- override colour if there no ammo left
    if not slotCol and not weapon:HasAmmo() then _colour = true end

    -- select slot colour
    _colour = GSRCHUD.sprite.userColour(GSRCHUD.config.getWeapon_selectorColour(), _colour)

    -- draw icon
    if slotSelected then
      local selected = curPos == pos

      -- in case of the mode not being classic, make unselected weapons less opaque
      local alpha = 255
      if mode == GSRCHUD.switcher.MODE_NOSPRITE and not selected then
        alpha = NOSPRITE_ALPHA
      end

      -- draw weapon icon
      GSRCHUD.weapon.draw(x, y, weapon, mode == GSRCHUD.switcher.MODE_CLASSIC and selected, _colour, scale, alpha * _alpha)

      -- draw selection brackets
      if selected then
        GSRCHUD.sprite.draw(SELECTION, x, y, _colour, nil, nil, scale, DEFAULT_ALPHA * _alpha, theme)
      end

      -- get information to render ammunition bars
      local _, primary, secondary, _, reserve, alt = GSRCHUD.weapon.ammo(weapon)
      local _scale = w/BUCKET_WIDTH/scale -- bucket size scale

      -- draw primary ammunition bar
      if reserve > 0 then
        drawBar(x + BAR_ORIGIN * scale * _scale, y, reserve / game.GetAmmoMax(primary), _colour, scale * _scale, _alpha)
      end

      -- draw secondary ammunition bar
      if alt > 0 then
        drawBar(x + (BAR_ORIGIN + BAR_MARGIN + BAR_WIDTH) * scale * _scale, y, alt / game.GetAmmoMax(secondary), _colour, scale * _scale, _alpha)
      end
    else
      GSRCHUD.sprite.draw(BUCKET0, x, y, _colour, nil, nil, scale, DEFAULT_ALPHA * _alpha)
    end
    y = y + h + (margin * scale)
  end

  return w, h
end

-- draw
function ELEMENT:draw()
  local cache, cacheLength, curSlot, curPos, cacheWeapons = GSRCHUD.switcher.import()
  local scale = GSRCHUD.sprite.scale()

  -- cache weapons
  cacheWeapons()

  -- check whether it should be drawn
  if not LocalPlayer():Alive() or curSlot <= 0 then return end

  -- sort parameters
  local x = self.parameters.x or 10
  local y = self.parameters.y or 10
  local margin = self.parameters.margin or 5
  local mode = self.parameters.mode or GSRCHUD.switcher.MODE_CLASSIC
  local hCol = self.parameters.headerColour
  local sCol = self.parameters.slotColour

  -- draw slots
  for i=1, 6 do
    local w, h = drawSlot(x, y, i, cache[i], curSlot == i, curPos, margin, hCol, sCol, mode, scale)
    x = x + w + (margin * scale)
  end
end

-- register
GSRCHUD.element.register('weapon_selector', {}, ELEMENT)

-- paint into overlay if the camera is out
hook.Add('DrawOverlay', GSRCHUD.hookname .. '_overlay', function()
  if not LocalPlayer or not LocalPlayer().GetActiveWeapon then return end -- avoid pre-init errors
  if not GSRCHUD.isEnabled() or not GSRCHUD.config.getWeapon_selector() then return end -- do not draw if it's disabled
  local weapon = LocalPlayer():GetActiveWeapon()
  if not IsValid(weapon) or weapon:GetClass() ~= CAMERA or gui.IsGameUIVisible() then return end -- only show with camera out
  ELEMENT:draw()
end)
