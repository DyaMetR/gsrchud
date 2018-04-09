--[[
  NUMBERS
]]

if CLIENT then

  -- Number list
  GSRCHUD.Numbers = {};

  -- Methods
  --[[
    Adds a number to the table
    @param {string} id
    @param {number} value
    @void
  ]]
  function GSRCHUD:AddNumber(id, value)
    self.Numbers[id] = {value = value, old = value, alpha = 0};
  end

  --[[
    Returns the entire number list
    @return GSRCHUD.Numbers
  ]]
  function GSRCHUD:GetNumbers()
    return self.Numbers;
  end

  --[[
    Returns a number based on the given id
    @param {string} id
    @return {table} number
  ]]
  function GSRCHUD:GetNumber(id)
    return self:GetNumbers()[id];
  end

  --[[
    Returns whether a number exists or not
    @param {string} id
    @return {boolean} exists
  ]]
  function GSRCHUD:NumberExists(id)
    return self:GetNumber(id) ~= nil;
  end

  --[[
    Sets a custom crit amount for a specific number
    @param {string} id
    @param {boolean} crit
    @void
  ]]
  function GSRCHUD:SetCustomNumberCrit(id, crit)
    if self:GetNumber(id) == nil then return false end;
    self:GetNumber(id).crit = crit;
  end

  --[[
    Clears all of the custom crit modifications
    @void
  ]]
  function GSRCHUD:ClearCustomNumberCrit()
    for _, number in pairs(self:GetNumbers()) do
      if (number.crit ~= nil) then
        number.crit = nil;
      end
    end
  end

  --[[
    Returns the custom crit amount for the specific number (if there's any)
    @param {string} id
    @return {number} crit
  ]]
  function GSRCHUD:GetCustomNumberCrit(id)
    if self:GetNumber(id) == nil then return false end;
    return self:GetNumber(id).crit or false;
  end

  --[[
    Updates a number value
    @param {string} id
    @param {number} value
    @void
  ]]
  function GSRCHUD:UpdateNumber(id, value)
    self:GetNumber(id).value = value;

    if (self:GetNumber(id).old ~= value) then
      self:GetNumber(id).alpha = 1;
      self:GetNumber(id).old = value;
    end
  end

  --[[
    Renders the given number on the given position
    @param {number} x
    @param {number} y
    @param {number} value
    @param {int} alpha
    @void
  ]]
  function GSRCHUD:RenderNumber(x, y, value, scale, crit, alpha, small, color)
    small = small or false;
    scale = scale or 1;
    alpha = alpha or 0;
    crit = crit or false;
    local tab = string.Explode("", tostring(value));
    local s = "";

    if small then
      s = "s";
    end

    local i = #tab;
    while (i>0) do
      local k = (#tab - i)+1;
      local w, h = self:GetSpriteDimensions(s..tab[k]);
      self:DrawSprite(x - ((w-1)*k) * scale, y, s..tab[i], scale, alpha, crit, nil, color, nil, true);
      i = i - 1;
    end
  end

  --[[
    Adds the number and renders it
    @param {number} x
    @param {number} y
    @param {string} id
    @param {number} value
    @void
  ]]
  function GSRCHUD:DrawNumber(x, y, id, value, scale, crit, alpha, color)
    alpha = alpha or self:GetNumberAlpha(id);
    crit = crit or self:GetCustomNumberCrit(id);

    if not self:NumberExists(id) then
      self:AddNumber(id, value);
    else
      self:UpdateNumber(id, value);
    end
    self:RenderNumber(x, y, self:GetNumber(id).value, scale, crit, alpha, nil, color);
  end

  --[[
    Forces a custom number alpha
    @param {string} id
    @param {number} alpha
    @void
  ]]
  function GSRCHUD:SetNumberAlpha(id, alpha)
    if self:GetNumber(id) == nil then return nil end;
    self:GetNumber(id).alpha = alpha;
  end

  --[[
    Returns the alpha channel of a number
    @param {string} id
    @return {number} alpha
  ]]
  function GSRCHUD:GetNumberAlpha(id)
    if self:GetNumber(id) == nil then return nil end;
    return self:GetBaseAlpha() + (self:GetHighlightAlpha()*self:GetNumber(id).alpha);
  end

  -- Hooks
  local think = 0;
  hook.Add("Tick", "gsrchud_numanim", function()
    if (table.Count(GSRCHUD:GetNumbers()) > 0) then
      if think < CurTime() then
        for k, num in pairs(GSRCHUD:GetNumbers()) do
          if num.alpha > 0 then
            num.alpha = math.Clamp(num.alpha - 0.01, 0, 1);
          end
        end
        think = CurTime() + 0.1;
      end
    end
  end);

end
