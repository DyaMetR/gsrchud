--[[
  NUMBERS
]]

if CLIENT then

  -- Hazards list
  GSRCHUD.Hazards = {};

  -- Methods
  --[[
    Adds a new hazard based on a damage type and links it to a sprite
    @param {number} dmgType
    @param {string} sprite
    @void
  ]]
  function GSRCHUD:AddHazard(dmgType, sprite)
    self.Hazards[dmgType] = sprite;
  end

  --[[
    Returns the sprite linked to a damage type
    @param {number} dmgType
    @return {string} sprite
  ]]
  function GSRCHUD:GetHazard(dmgType)
    return self.Hazards[dmgType];
  end

  --[[
    Returns the table of hazards
    @return {table} GSRCHUD.Hazards
  ]]
  function GSRCHUD:GetHazards()
    return self.Hazards;
  end

  --[[
    Returns whether the specified damage type has an sprite linked to it
    @param {number} dmgType
    @return {boolean} hasSprite
  ]]
  function GSRCHUD:IsValidHazard(dmgType)
    return self:GetHazard(dmgType) ~= nil;
  end

end
