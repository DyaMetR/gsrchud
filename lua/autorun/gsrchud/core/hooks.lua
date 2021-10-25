--[[------------------------------------------------------------------
  Hooks for gamemode integration.
]]--------------------------------------------------------------------

GSRCHUD.hook = {} -- namespace

local hooks = {} -- registered hooks

--[[------------------------------------------------------------------
  Adds a function to the hook.
  @param {string} hook name
  @param {string} identifier
  @param {function} function to run
]]--------------------------------------------------------------------
function GSRCHUD.hook.add(_hook, name, func)
  if not hooks[_hook] then hooks[_hook] = {} end
  hooks[_hook][name] = func
end

--[[------------------------------------------------------------------
  Removes the given function from the hook.
  @param {string} hook name
  @param {string} identifier
]]--------------------------------------------------------------------
function GSRCHUD.hook.remove(_hook, name)
  if not hooks[_hook] then return end
  hooks[_hook][name] = nil
end

--[[------------------------------------------------------------------
  Runs all functions attached to the given hook.
  @param {string} hook name
  @param {varargs} arguments
  @return {any} returning value
]]--------------------------------------------------------------------
function GSRCHUD.hook.run(_hook, ...)
  if not hooks[_hook] then return end
  for _, func in pairs(hooks[_hook]) do
    local a, b, c, d, e, f = func(...) -- run function

    -- if a value was provided, return them
    if a ~= nil then
      return a, b, c, d, e, f
    end
  end
end
