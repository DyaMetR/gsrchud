--[[
  NUMBERS
]]

if CLIENT then

  -- Hazards list
  GSRCHUD.Hazards = {};

  -- Methods
  --[[
    Adds a new hazard based on a damage type and links it to a sprite
    @param {number} damage type
    @param {string} sprite
    @void
  ]]
  function GSRCHUD:AddHazard(dmgType, sprite)
    self.Hazards[dmgType] = {custom = false, sprite = sprite};
  end

  --[[
    Adds a new hazard based on a damage type and links it to a custom sprite
    @param {number} damage type
    @param {string} custom sprite
    @void
  ]]
  function GSRCHUD:AddHazardCustomSprite(dmgType, customSprite)
    self.Hazards[dmgType] = {custom = true, sprite = customSprite};
  end

  --[[
    Returns the sprite linked to a damage type
    @param {number} damage type
    @return {string} sprite
  ]]
  function GSRCHUD:GetHazard(dmgType)
    return self.Hazards[dmgType].sprite;
  end

  --[[
    Returns whether the hazard uses a custom sprite
    @param {number} damage type
    @return {bool} has custom sprite
  ]]
  function GSRCHUD:HasHazardCustomSprite(dmgType)
    return self.Hazards[dmgType].custom
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
    @param {number} damage type
    @return {boolean} has sprite
  ]]
  function GSRCHUD:IsValidHazard(dmgType)
    return self.Hazards[dmgType] ~= nil;
  end

end
