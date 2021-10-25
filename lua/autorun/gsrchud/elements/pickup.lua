--[[------------------------------------------------------------------
  Pickup history
]]--------------------------------------------------------------------

local PICKUP_AMMO, PICKUP_WEAPON, PICKUP_ITEM = 0, 1, 2
local FREQ, TIME = .03, 3
local WEAPON_PICKUP_SOUND = 'gsrchud/default/gunpickup2.wav'
local BUCKET = 'bucket'
local FONT = 'gsrchud_ammopickup'
local DEFAULT_ALPHA = 255

local SOUND_HOOK = 'PickupSound'

local height = 0 -- relative position to origin where the next icon will appear
local _next = 1 -- next position in tray
local count = 0 -- optimize table counting
local history = {} -- current pickups being displayed

local _scale = 1
local tick = 0
local colour = Color(0, 0, 0) -- optimize font colour usage

--[[ Create ammunition pickup font ]]--
--[[------------------------------------------------------------------
  Generates the ammunition pickup font.
]]--------------------------------------------------------------------
local function generate()
  _scale = GSRCHUD.sprite.scale()
  surface.CreateFont(FONT, {
    font = 'Trebuchet MS',
    size = 20 * _scale,
    weight = 1000,
    additive = true
  })
end

-- generate first instance
generate()

--[[ Create element ]]--
local ELEMENT = GSRCHUD.element.create()

--[[------------------------------------------------------------------
  Draws a weapon pickup.
  @param {number} x
  @param {number} y
  @param {table} pickup data
]]--------------------------------------------------------------------
local function drawWeaponPickup(x, y, pickup)
  if not IsValid(pickup.weapon) then return end
  local alpha = DEFAULT_ALPHA * math.min(GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA, 1)

  -- get bucket's size
  local w, h = GSRCHUD.sprite.getSize(BUCKET)

  -- get colour
  local _colour = GSRCHUD.sprite.userColour(GSRCHUD.config.getPickupColour(), not LocalPlayer():HasWeapon(pickup.weapon:GetClass()) or not pickup.weapon:HasAmmo())

  -- draw weapon icon
  GSRCHUD.weapon.draw(x - w, y, pickup.weapon, nil, _colour, nil, alpha * pickup.alpha)
end

--[[------------------------------------------------------------------
  Draws an ammunition pickup.
  @param {number} x
  @param {number} y
  @param {table} pickup data
]]--------------------------------------------------------------------
local function drawAmmoPickup(x, y, pickup)
  local scale = GSRCHUD.sprite.scale()
  local alpha = DEFAULT_ALPHA * math.min(GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA, 1)
  local _colour = GSRCHUD.sprite.userColour(GSRCHUD.config.getPickupColour())
  local w, h = GSRCHUD.ammunition.draw(x, y, pickup.ammoType, nil, _colour, TEXT_ALIGN_RIGHT, nil, nil, alpha * pickup.alpha)
  local _x, _y = 9 * scale, -2 * scale

  -- set colour
  colour.r = _colour.r
  colour.g = _colour.g
  colour.b = _colour.b
  colour.a = alpha * pickup.alpha

  -- draw
  draw.SimpleText(pickup.amount, FONT, x - w - _x, y + (h * .5) + _y, colour, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

--[[------------------------------------------------------------------
  Draws an item pickup.
  @param {number} x
  @param {number} y
  @param {table} pickup data
]]--------------------------------------------------------------------
local function drawItemPickup(x, y, pickup)
  GSRCHUD.item.draw(x, y, pickup.item, GSRCHUD.sprite.userColour(GSRCHUD.config.getPickupColour()), TEXT_ALIGN_RIGHT, nil, nil, DEFAULT_ALPHA * math.min(GSRCHUD.sprite.alpha() / GSRCHUD.DEFAULT_ALPHA, 1) * pickup.alpha)
end

--[[------------------------------------------------------------------
  Adds a pickup to the history to display.
  @param {PICKUP_} type
  @param {table} pickup information
]]--------------------------------------------------------------------
local function addPickup(_type, data)
  local scale = GSRCHUD.sprite.scale()
  local margin = (ELEMENT.parameters.margin or 5) * scale
  local size = (ELEMENT.parameters.size or 45) * scale
  local max = ELEMENT.parameters.max or math.floor((ScrH() / scale) / 90)

  -- call hook
  local _return = hook.Run('GSRCHUDPickup', _type, data)
  if _return then return end

  -- reserve pickup's height
  height = height + size

  -- complete pickup information
  data.type = _type
  data.y = height
  data.alpha = 1
  data.time = CurTime() + TIME

  -- add element to tray
  history[_next] = data
  _next = _next + 1
  count = count + 1

  -- add margin
  height = height + margin

  -- if the maximum amount has been reached, reset
  if _next > max then
    height = 0
    _next = 1
  end
end

-- draw
function ELEMENT:draw()
  local scale = GSRCHUD.sprite.scale()

  -- update font size
  if _scale ~= scale then generate() end

  -- sort parameters
  local x = self.parameters.x or ScrW()
  local y = self.parameters.y or (ScrH() - 72 * scale)

  -- draw
  for i, pickup in pairs(history) do
    if pickup.type == PICKUP_WEAPON then
      drawWeaponPickup(x, y - pickup.y, pickup)
    elseif pickup.type == PICKUP_AMMO then
      drawAmmoPickup(x, y - pickup.y, pickup)
    elseif pickup.type == PICKUP_ITEM then
      drawItemPickup(x, y - pickup.y, pickup)
    end
  end

  -- animate
  if tick < CurTime() then
    for i, pickup in pairs(history) do
      if pickup.time < CurTime() then
        if pickup.alpha > 0 then
          pickup.alpha = math.max(pickup.alpha - FREQ, 0) -- fade out
        else
          -- remove itself from history
          history[i] = nil
          count = count - 1

          -- reset height and count if no more are available
          if count <= 0 then
            _next = 1
            height = 0
          end
        end
      end
    end
    tick = CurTime() + .05
  end
end

-- register
GSRCHUD.element.register('pickup', {}, ELEMENT)

--[[ Hide default pickup history ]]--
hook.Add('HUDDrawPickupHistory', GSRCHUD.hookname, function()
  return GSRCHUD.isEnabled() and GSRCHUD.hasSuit() and GSRCHUD.config.getPickup() or nil
end)

--[[ Picked up ammunition ]]--
hook.Add('HUDAmmoPickedUp', GSRCHUD.hookname, function(ammoType, amount)
  if not GSRCHUD.isEnabled() or not GSRCHUD.hasSuit() or not GSRCHUD.config.getPickup() then return end
  addPickup(PICKUP_AMMO, {ammoType = ammoType, amount = amount})
end)

--[[ Picked up weapon ]]--
hook.Add('HUDWeaponPickedUp', GSRCHUD.hookname, function(weapon)
  if not GSRCHUD.isEnabled() or not GSRCHUD.hasSuit() or not GSRCHUD.config.getPickup() then return end
  addPickup(PICKUP_WEAPON, {weapon = weapon}) -- add pickup to screen

  -- select sound
  local sound = WEAPON_PICKUP_SOUND
  local override = GSRCHUD.hook.run(SOUND_HOOK)
  if override ~= nil then
    if isbool(override) then
      if not override then return end
    elseif isstring(override) then
      sound = override
    end
  end

  -- play sound
  surface.PlaySound(sound)
end)

--[[ Picked up item ]]--
hook.Add('HUDItemPickedUp', GSRCHUD.hookname, function(item)
  if not GSRCHUD.isEnabled() or not GSRCHUD.hasSuit() or not GSRCHUD.config.getPickup() or not GSRCHUD.item.has(item) then return end
  addPickup(PICKUP_ITEM, {item = item})
end)
