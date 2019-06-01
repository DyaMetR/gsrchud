--[[
  CORE ELEMENTS
]]

-- Add the override
GSRCHUD:IncludeFile("util/override.lua");
GSRCHUD:IncludeFile("util/deathcam_override.lua");

if CLIENT then
  -- Paramteres
  GSRCHUD.DefaultConfig = {
    Enabled = 1,
    WeaponSelectorEnabled = 1,
    PickupEnabled = 1,
    HealthEnabled = 1,
    AmmoEnabled = 1,
    DamageEnabled = 1,
    HazardEnabled = 1,
    HUDScale = 1,
    DirDamageSeparation = 100,
    SkipEmptyWeapons = 1,
    DefaultTheme = "Half-Life",
    BaseAlpha = 130,
    HighlightAlpha = 150,
    WeaponBaseAlpha = 160,
    WeaponHighlightAlpha = 280,
    EnableColouring = 0,
    DefaultColor = 255,
    DeathScreen = 1
  };

  -- ConVars
  GSRCHUD.Enabled = CreateClientConVar("gsrchud_enabled", GSRCHUD.DefaultConfig.Enabled);
  GSRCHUD.WeaponSelectorEnabled = CreateClientConVar("gsrchud_wpn_selector_enabled", GSRCHUD.DefaultConfig.WeaponSelectorEnabled);
  GSRCHUD.PickupEnabled = CreateClientConVar("gsrchud_pickup_enabled", GSRCHUD.DefaultConfig.PickupEnabled);
  GSRCHUD.HealthEnabled = CreateClientConVar("gsrchud_health_enabled", GSRCHUD.DefaultConfig.HealthEnabled);
  GSRCHUD.AmmoEnabled = CreateClientConVar("gsrchud_ammo_enabled", GSRCHUD.DefaultConfig.AmmoEnabled);
  GSRCHUD.DamageEnabled = CreateClientConVar("gsrchud_damage_enabled", GSRCHUD.DefaultConfig.DamageEnabled);
  GSRCHUD.HazardEnabled = CreateClientConVar("gsrchud_hazard_enabled", GSRCHUD.DefaultConfig.HazardEnabled);
  GSRCHUD.HUDScale = CreateClientConVar("gsrchud_scale", GSRCHUD.DefaultConfig.HUDScale);
  GSRCHUD.DirDamageSeparation = CreateClientConVar("gsrchud_dmg_separation", GSRCHUD.DefaultConfig.DirDamageSeparation);
  GSRCHUD.SkipEmptyWeapons = CreateClientConVar("gsrchud_skip_empty_weapons", GSRCHUD.DefaultConfig.SkipEmptyWeapons);
  GSRCHUD.DeathScreen = CreateClientConVar("gsrchud_death_screen_enabled", GSRCHUD.DefaultConfig.DeathScreen);

  GSRCHUD.Theme = CreateClientConVar("gsrchud_theme", GSRCHUD.DefaultConfig.DefaultTheme);

  GSRCHUD.BaseAlpha = CreateClientConVar("gsrchud_alpha_base", GSRCHUD.DefaultConfig.BaseAlpha);
  GSRCHUD.HighlightAlpha = CreateClientConVar("gsrchud_alpha_highlight", GSRCHUD.DefaultConfig.HighlightAlpha);
  GSRCHUD.WeaponBaseAlpha = CreateClientConVar("gsrchud_alpha_base_weapon", GSRCHUD.DefaultConfig.WeaponBaseAlpha);
  GSRCHUD.WeaponHighlightAlpha = CreateClientConVar("gsrchud_alpha_highlight_weapon", GSRCHUD.DefaultConfig.WeaponHighlightAlpha);

  GSRCHUD.EnableColouring = CreateClientConVar("gsrchud_color_enable", GSRCHUD.DefaultConfig.EnableColouring);

  GSRCHUD.CritColorR = CreateClientConVar("gsrchud_crit_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.CritColorG = CreateClientConVar("gsrchud_crit_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.CritColorB = CreateClientConVar("gsrchud_crit_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.HealthColorR = CreateClientConVar("gsrchud_health_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.HealthColorG = CreateClientConVar("gsrchud_health_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.HealthColorB = CreateClientConVar("gsrchud_health_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.ArmorColorR = CreateClientConVar("gsrchud_armor_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.ArmorColorG = CreateClientConVar("gsrchud_armor_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.ArmorColorB = CreateClientConVar("gsrchud_armor_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.LSepColorR = CreateClientConVar("gsrchud_lsep_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.LSepColorG = CreateClientConVar("gsrchud_lsep_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.LSepColorB = CreateClientConVar("gsrchud_lsep_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.ClipColorR = CreateClientConVar("gsrchud_clip_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.ClipColorG = CreateClientConVar("gsrchud_clip_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.ClipColorB = CreateClientConVar("gsrchud_clip_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.AmmoColorR = CreateClientConVar("gsrchud_ammo_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.AmmoColorG = CreateClientConVar("gsrchud_ammo_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.AmmoColorB = CreateClientConVar("gsrchud_ammo_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.RSepColorR = CreateClientConVar("gsrchud_rsep_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.RSepColorG = CreateClientConVar("gsrchud_rsep_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.RSepColorB = CreateClientConVar("gsrchud_rsep_color_b", GSRCHUD.DefaultConfig.DefaultColor);

  GSRCHUD.SelectorColorR = CreateClientConVar("gsrchud_selector_color_r", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.SelectorColorG = CreateClientConVar("gsrchud_selector_color_g", GSRCHUD.DefaultConfig.DefaultColor);
  GSRCHUD.SelectorColorB = CreateClientConVar("gsrchud_selector_color_b", GSRCHUD.DefaultConfig.DefaultColor);


  --[[
    Returns whether the HUD is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsEnabled()
    local hasOverride, isOverriden = GSRCHUD:IsHUDOverriden();
    return (hasOverride and isOverriden) or (not hasOverride and self.Enabled:GetInt() > 0);
  end

  --[[
    Returns whether the death screen is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsDeathScreenEnabled()
    local hasOverride, isOverriden = GSRCHUD:IsDeathScreenOverriden();
    return (hasOverride and isOverriden) or (not hasOverride and self.DeathScreen:GetInt() > 0);
  end


  --[[
    Returns whether the weapon selector HUD is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsWeaponSelectorEnabled()
    return self.WeaponSelectorEnabled:GetInt() > 0;
  end

  --[[
    Returns whether the item pickup HUD is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsPickupEnabled()
    return self.PickupEnabled:GetInt() > 0;
  end

  --[[
    Returns whether the health HUD panel is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsHealthEnabled()
    return self.HealthEnabled:GetInt() > 0;
  end

  --[[
    Returns whether the ammo HUD panel is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsAmmoEnabled()
    return self.AmmoEnabled:GetInt() > 0;
  end

  --[[
    Returns whether the custom damage indicator is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsDamageEnabled()
    return self.DamageEnabled:GetInt() > 0;
  end

  --[[
    Returns whether the hazard indicator is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsHazardEnabled()
    return self.HazardEnabled:GetInt() > 0;
  end

  --[[
    Returns the currently selected theme
    @return {string} theme
  ]]
  function GSRCHUD:GetCurrentTheme()
    if (self:GetTheme(self.Theme:GetString()) == nil) then
      return self.DefaultConfig.DefaultTheme;
    else
      return self.Theme:GetString();
    end
  end

  --[[
    Returns the HUD scale
    @return {float} gsrchud_scale
  ]]
  function GSRCHUD:GetHUDScale()
    return self.HUDScale:GetFloat();
  end

  --[[
    Returns the separation between the center of the screen and the directional damage indicators
    @return {float} gsrchud_dmg_separation
  ]]
  function GSRCHUD:GetDirDamageSeparation()
    return self.DirDamageSeparation:GetInt();
  end

  --[[
    Returns whether the weapon selector should ignore the empty weapons
    @return {boolean} gsrchud_skip_empty_weapons
  ]]
  function GSRCHUD:GetSkipEmptyWeapons()
    return self.SkipEmptyWeapons:GetInt() > 0;
  end

  --[[
    Returns the base alpha amount used in numbers
    @return {number} gsrchud_alpha_base
  ]]
  function GSRCHUD:GetBaseAlpha()
    return self.BaseAlpha:GetInt();
  end

  --[[
    Returns the alpha added to numbers when highlighted
    @return {number} gsrchud_alpha_highlight
  ]]
  function GSRCHUD:GetHighlightAlpha()
    return self.HighlightAlpha:GetInt();
  end

  --[[
    Returns the base alpha amount used in the weapon selector
    @return {number} gsrchud_alpha_base_weapon
  ]]
  function GSRCHUD:GetWeaponBaseAlpha()
    return self.WeaponBaseAlpha:GetInt();
  end

  --[[
    Returns the alpha added to weapon icons when highlighted
    @return {number} gsrchud_alpha_highlight_weapon
  ]]
  function GSRCHUD:GetWeaponHighlightAlpha()
    return self.WeaponHighlightAlpha:GetInt();
  end

  --[[
    Returns whether the custom coloring of elements is enabled
    @return {boolean} isEnabled
  ]]
  function GSRCHUD:IsCustomColouringEnabled()
    return self.EnableColouring:GetInt() > 0;
  end

  --[[
    Returns the custom color for the critical information
    @return {color} color
  ]]
  function GSRCHUD:GetCustomCritColor()
    return Color(self.CritColorR:GetInt(), self.CritColorG:GetInt(), self.CritColorB:GetInt());
  end

  --[[
    Returns the custom color for the health
    @return {color} color
  ]]
  function GSRCHUD:GetCustomHealthColor()
    return Color(self.HealthColorR:GetInt(), self.HealthColorG:GetInt(), self.HealthColorB:GetInt());
  end

  --[[
    Returns the custom color for the armor
    @return {color} color
  ]]
  function GSRCHUD:GetCustomArmorColor()
    return Color(self.ArmorColorR:GetInt(), self.ArmorColorG:GetInt(), self.ArmorColorB:GetInt());
  end

  --[[
    Returns the custom color for the left separator
    @return {color} color
  ]]
  function GSRCHUD:GetCustomLSepColor()
    return Color(self.LSepColorR:GetInt(), self.LSepColorG:GetInt(), self.LSepColorB:GetInt());
  end

  --[[
    Returns the custom color for the clip
    @return {color} color
  ]]
  function GSRCHUD:GetCustomClipColor()
    return Color(self.ClipColorR:GetInt(), self.ClipColorG:GetInt(), self.ClipColorB:GetInt());
  end

  --[[
    Returns the custom color for the reserve ammunition
    @return {color} color
  ]]
  function GSRCHUD:GetCustomAmmoColor()
    return Color(self.AmmoColorR:GetInt(), self.AmmoColorG:GetInt(), self.AmmoColorB:GetInt());
  end

  --[[
    Returns the custom color for the right separator
    @return {color} color
  ]]
  function GSRCHUD:GetCustomRSepColor()
    return Color(self.RSepColorR:GetInt(), self.RSepColorG:GetInt(), self.RSepColorB:GetInt());
  end

  --[[
    Returns the custom color for the weapon selector
    @return {color} color
  ]]
  function GSRCHUD:GetCustomSelectorColor()
    return Color(self.SelectorColorR:GetInt(), self.SelectorColorG:GetInt(), self.SelectorColorB:GetInt());
  end

  -- Convar resetting commands
  concommand.Add("gsrchud_reset_alpha", function()
    RunConsoleCommand("gsrchud_alpha_base", GSRCHUD.DefaultConfig.BaseAlpha);
    RunConsoleCommand("gsrchud_alpha_highlight", GSRCHUD.DefaultConfig.HighlightAlpha);
    RunConsoleCommand("gsrchud_alpha_base_weapon", GSRCHUD.DefaultConfig.WeaponBaseAlpha);
    RunConsoleCommand("gsrchud_alpha_highlight_weapon", GSRCHUD.DefaultConfig.WeaponHighlightAlpha);
  end);

  concommand.Add("gsrchud_reset_util", function()
    RunConsoleCommand("gsrchud_skip_empty_weapons", GSRCHUD.DefaultConfig.SkipEmptyWeapons);
    RunConsoleCommand("gsrchud_dmg_separation", GSRCHUD.DefaultConfig.DirDamageSeparation);
  end);

  concommand.Add("gsrchud_reset_composition", function()
    RunConsoleCommand("gsrchud_death_screen_enabled", GSRCHUD.DefaultConfig.DeathScreen);
    RunConsoleCommand("gsrchud_wpn_selector_enabled", GSRCHUD.DefaultConfig.WeaponSelectorEnabled);
    RunConsoleCommand("gsrchud_pickup_enabled", GSRCHUD.DefaultConfig.PickupEnabled);
    RunConsoleCommand("gsrchud_health_enabled", GSRCHUD.DefaultConfig.HealthEnabled);
    RunConsoleCommand("gsrchud_ammo_enabled", GSRCHUD.DefaultConfig.AmmoEnabled);
    RunConsoleCommand("gsrchud_damage_enabled", GSRCHUD.DefaultConfig.DamageEnabled);
  end);

  -- Hide default HUD
  local hide = {
  	CHudHealth = true,
  	CHudBattery = true,
    CHudDamageIndicator = true,
    CHudAmmo = true,
    CHudSecondaryAmmo = true,
    CHudPoisonDamageIndicator = true,
    CHudHistoryResource = true
  }

  hook.Add( "HUDShouldDraw", "gsrchud_hide_default_hud", function( name )
    hide["CHudHealth"] = GSRCHUD:IsHealthEnabled();
    hide["CHudBattery"] = GSRCHUD:IsHealthEnabled();
    hide["CHudDamageIndicator"] = GSRCHUD:IsDamageEnabled();
    hide["CHudAmmo"] = GSRCHUD:IsAmmoEnabled();
    hide["CHudSecondaryAmmo"] = GSRCHUD:IsAmmoEnabled();
    hide["CHudPoisonDamageIndicator"] = GSRCHUD:IsHazardEnabled();
    hide["CHudHistoryResource"] = GSRCHUD:IsPickupEnabled();
  	if ( hide[ name ] and GSRCHUD:IsEnabled()) then return false end;
  end )

end

-- Utils
GSRCHUD:IncludeFile("util/spectate_block.lua");
GSRCHUD:IncludeFile("util/themes.lua");
GSRCHUD:IncludeFile("util/sprites.lua");
GSRCHUD:IncludeFile("util/numbers.lua");
GSRCHUD:IncludeFile("util/composition.lua");
GSRCHUD:IncludeFile("util/ammo.lua");
GSRCHUD:IncludeFile("util/hazards.lua");
GSRCHUD:IncludeFile("util/items.lua");
GSRCHUD:IncludeFile("util/weapons.lua");
GSRCHUD:IncludeFile("util/wpn_selector.lua");
GSRCHUD:IncludeFile("util/sprites_custom.lua");

-- Elements to draw
GSRCHUD:IncludeFile("elements/health.lua");
GSRCHUD:IncludeFile("elements/ammo.lua");
GSRCHUD:IncludeFile("elements/hazards.lua");
GSRCHUD:IncludeFile("elements/pickup.lua");
GSRCHUD:IncludeFile("elements/damage.lua");
GSRCHUD:IncludeFile("elements/death.lua");

-- Load data
GSRCHUD:IncludeFile("data/sprites.lua");
GSRCHUD:IncludeFile("data/hazards.lua");
GSRCHUD:IncludeFile("data/items.lua");
GSRCHUD:IncludeFile("data/ammo.lua");
GSRCHUD:IncludeFile("data/weapons.lua");

-- Load custom themes
GSRCHUD:IncludeFile("data/themes/default.lua"); -- Default theme [REQUIRED TO WORK]
local files, directories = file.Find("autorun/gsrchud/data/themes/*.lua", "LUA");
for _, file in pairs(files) do
  GSRCHUD:IncludeFile("data/themes/"..file);
end

-- Load add-ons
local files, directories = file.Find("autorun/gsrchud/add-ons/*.lua", "LUA");
for _, file in pairs(files) do
  GSRCHUD:IncludeFile("add-ons/"..file);
end

GSRCHUD:IncludeFile("util/config.lua"); -- At last, load the menu

-- Add the materials for downloading
GSRCHUD:IncludeFile("util/resources.lua");

--[[
  code_gs Weapon Selector
  Thanks a lot for this one, this has saved me tremendous time.
  https://github.com/Kefta/Weapon-Switcher-Skeleton
]]
GSRCHUD:IncludeFile("util/gs_switcher.lua");
