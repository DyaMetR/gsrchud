--[[------------------------------------------------------------------
  Custom fake loading screen derma control
]]--------------------------------------------------------------------

local FONT_NAME = 'gsrchud_loading'
local BACKGROUND = Material('gsrchud/background.png')
local OVERLAY = surface.GetTextureID('gsrchud/loading')
local DEFAULT = Color(255, 255, 255)

local PANEL = {}

--[[------------------------------------------------------------------
  Creates the LOADING label font
  @param {number} scale
]]--------------------------------------------------------------------
local function createFont(scale)
  scale = scale or ScrW() / 640
  surface.CreateFont(FONT_NAME, {
    font = 'Trebuchet MS',
    size = 38 * scale
  })
end

-- initialize to avoid errors
createFont()

--[[------------------------------------------------------------------
  Create all components.
]]--------------------------------------------------------------------
function PANEL:Init()
  self.player = NULL -- player to get model and colour from
  self.offset = 0 -- vertical screen offset scale (0-1)
  self.lblOrigin = 0
  self.camPosCache = Vector(77, 4, 58)
  self.lookAtCache = Vector(0, -4, 58)
  self.colourCache = Color(0, 0, 0)

  -- create background
  self.frame = vgui.Create('DPanel', self)
  self.frame.Paint = function()
    -- draw background
    surface.SetMaterial(BACKGROUND)
    surface.SetDrawColor(DEFAULT)
    surface.DrawTexturedRect(0, -self:GetTall() * self.offset, self:GetWide(), self:GetTall())

    -- draw foreground
    surface.SetTexture(OVERLAY)
    surface.SetDrawColor(self.colourCache)
    surface.DrawTexturedRect(0, -self:GetTall() * self.offset, (2048 / 1706) * self:GetWide(), (1024 / 960) * self:GetTall())
  end

  -- create model panel
  local model = vgui.Create('DModelPanel', self)
  model:SetFOV(20)
  model.LayoutEntity = function(self, ent) return end -- disable rotation
  self.mdl = model

  -- initialize label
  local label = vgui.Create('DLabel', self)
  label:SetFont(FONT_NAME)
  label:SetText('L   O   A   D   I   N   G')
  self.label = label
end

--[[------------------------------------------------------------------
  Paint nothing.
]]--------------------------------------------------------------------
function PANEL:Paint() end

--[[------------------------------------------------------------------
  Called when the screen size has changed.
  @param {number} width
  @param {number} height
]]--------------------------------------------------------------------
function PANEL:OnSizeChanged(w, h)
  -- regenerate font
  createFont(w / 640)

  -- resize and reposition label (horizontally)
  self.label:SizeToContents()
  self.label:SetX((self:GetWide() * .5) - self.label:GetWide() * .5)
  self.lblOrigin = (self:GetTall() * .75) - self.label:GetTall() * .5

  -- resize background (horizontally)
  self.frame:SetWide(self:GetWide())

  -- resize and reposition model panel (horizontally)
  self.mdl:SetWide(self:GetWide() * .5)
  self.mdl:SetX(self:GetWide() * .5)
end

--[[------------------------------------------------------------------
  Sets a new offset, resizing all components.
  @param {number} offset scale (0-1)
]]--------------------------------------------------------------------
function PANEL:SetOffset(offset)
  local h = self:GetTall() * (1 - offset)

  -- store
  self.offset = offset

  -- resize background
  self.frame:SetTall(h)

  -- relocate label
  self.label:SetY(self.lblOrigin - self:GetTall() * offset)

  -- resize model panel (and move model upwards)
  local displace = 13.5
  self.camPosCache.z = 58 - displace * offset
  self.lookAtCache.z = 58 - displace * offset
  self.mdl:SetTall(h)
  self.mdl:SetCamPos(self.camPosCache)
  self.mdl:SetLookAt(self.lookAtCache)

  -- make panel visible based on completion
  self:SetVisible(offset < 1)
end

--[[------------------------------------------------------------------
  Refreshes the model panel's model and colour.
  @param {Player} player to use as a reference
]]--------------------------------------------------------------------
function PANEL:SetupPlayer(_player)
  _player = _player or self.player
  if not IsValid(_player) then return end
  -- set new model
  self.mdl:SetModel(_player:GetModel())

  -- get entity
  local model = self.mdl.Entity

  -- set skin
  model:SetSkin(_player:GetSkin())

  -- set body groups
  local bodygroups = _player:GetBodyGroups()
  for _, bodygroup in pairs(bodygroups) do
    model:SetBodygroup(bodygroup.id, _player:GetBodygroup(bodygroup.id))
  end

  -- set player colour
  self.colourCache = _player:GetPlayerColor():ToColor()
  model.GetPlayerColor = function(self) return _player:GetPlayerColor() end

  -- give animation
  model:SetSequence(model:SelectWeightedSequence(ACT_HL2MP_IDLE_PASSIVE))

  -- make it look forward
  local pos = model:EyePos()
  local ang = model:EyeAngles()
  model:SetEyeTarget(pos + ang:Forward() * 1000)
end

--[[------------------------------------------------------------------
  Makes the panel track the given player's colour and model.
  @param {Player} player
]]--------------------------------------------------------------------
function PANEL:SetPlayer(_player)
  self:SetupPlayer(_player)
  self.player = _player
end

vgui.Register('DLoadingScreen', PANEL, 'Panel')
