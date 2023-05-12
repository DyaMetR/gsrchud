--[[------------------------------------------------------------------
  Options menu
]]--------------------------------------------------------------------

GSRCHUD.toolmenu = {}

local CATEGORY = 'Utilities'
local UID = GSRCHUD.hookname

local themes
local options = {} -- third party options

--[[------------------------------------------------------------------
  Adds a theme to the tool menu list.
  @param {THEME_} theme identifier
  @param {string} theme name
]]--------------------------------------------------------------------
function GSRCHUD.toolmenu.registerTheme(_theme, name)
  if not themes then return end
  themes:AddChoice(name, theme)
end

--[[------------------------------------------------------------------
  Adds a function that will interact with the tool menu options.
  @param {string} section name
  @param {function} func
]]--------------------------------------------------------------------
function GSRCHUD.toolmenu.addOption(section, func)
  table.insert(options, {section = section, func = func})
end

--[[------------------------------------------------------------------
  Adds a control to change a colour.
  @param {Panel} panel to add control to
  @param {string} label
  @param {string} console variable name
]]--------------------------------------------------------------------
local function addColour(panel, label, name)
  panel:AddControl( 'Color', {
    Label = label,
    Red = name .. '_r',
    Green = name .. '_g',
    Blue = name .. '_b'
    }
  )
end

--[[------------------------------------------------------------------
  Adds a colour console variable to a presets control.
  @param {Panel} presets control
  @param {string} colour console variable name
]]--------------------------------------------------------------------
local function addColourPreset(presets, colour)
  presets:AddConVar(colour .. '_r')
  presets:AddConVar(colour .. '_g')
  presets:AddConVar(colour .. '_b')
end

-- populate tool menu
hook.Add('PopulateToolMenu', UID, function()
  -- add option
  spawnmenu.AddToolMenuOption(CATEGORY, GSRCHUD.name, UID, 'Settings', nil, nil, function(panel)
    panel:ClearControls()
    panel:CheckBox('Enabled', 'gsrchud_enabled')
    panel:NumSlider('Scale', 'gsrchud_scale', 0, 5, 2)

    themes, _ = panel:ComboBox('Theme', 'gsrchud_theme')
    for i, theme in pairs(GSRCHUD.theme.all()) do
      themes:AddChoice(theme.name, i)
    end

    panel:CheckBox('Texture filtering', 'gsrchud_filter')
    panel:CheckBox('Draw without suit', 'gsrchud_nosuit')

    panel:Help('\nComposition')
    panel:CheckBox('Health indicator', 'gsrchud_health')
    panel:CheckBox('Suit battery indicator', 'gsrchud_suit')
    panel:CheckBox('Ammunition indicator', 'gsrchud_ammo')
    panel:CheckBox('Weapon selector', 'gsrchud_weapon_selector')
    panel:CheckBox('Skip empty weapons', 'gsrchud_skipempty')
    panel:CheckBox('Enable weapon scrolling sounds', 'gsrchud_switcherscrollsound')
    panel:CheckBox('Pickup history', 'gsrchud_pickup')
    panel:CheckBox('Death screen', 'gsrchud_deathcam')
    panel:CheckBox('Damage indicators', 'gsrchud_damage')
    panel:NumSlider('Damage indicators offset', 'gsrchud_damageoffset', 0, ScrH())
    panel:CheckBox('Hazards tray', 'gsrchud_hazards')
    panel:CheckBox('Flashlight meter', 'gsrchud_flashlight')
    panel:CheckBox('Loading screen', 'gsrchud_loading')
		panel:CheckBox('Show loading screen on respawn', 'gsrchud_loadingonrespawn')
    panel:Button('Show loading screen', 'gsrchud_reset_loading')
    panel:CheckBox('Dynamic spacing', 'gsrchud_dynamicspacing')

    panel:Help('\nVisibility')
    panel:NumSlider('Opacity', 'gsrchud_alpha', 0, 255)
    panel:NumSlider('Highlight opacity', 'gsrchud_highlight', 0, 255)

    -- register third party options
    if #options > 0 then
      panel:Help('\nAdd-ons')
      for _, option in pairs(options) do
        panel:ControlHelp(option.section)
        option.func(panel)
      end
    end

    panel:Help('\nDeveloper')
    panel:CheckBox('Console warnings', 'gsrchud_consolewarn')

    panel:Button('Reset to default', 'gsrchud_reset')

    panel:Help('\nColouring')
    panel:CheckBox('Custom colouring', 'gsrchud_colouring')

    -- add theme colouring
    addColour(panel, 'Set all colours to the same one', 'gsrchud_theme')

    -- reset colours
    panel:Button('Reset colours to default', 'gsrchud_reset_colours')

    -- add presets control
    panel:Help('Presets')
    local presets = vgui.Create('ControlPresets')
    presets:SetPreset('gsrchud')
    addColourPreset(presets, 'gsrchud_theme')
    addColourPreset(presets, 'gsrchud_crit')
    addColourPreset(presets, 'gsrchud_health')
    addColourPreset(presets, 'gsrchud_lseparator')
    addColourPreset(presets, 'gsrchud_suit')
    addColourPreset(presets, 'gsrchud_clip')
    addColourPreset(presets, 'gsrchud_rseparator')
    addColourPreset(presets, 'gsrchud_ammo')
    addColourPreset(presets, 'gsrchud_weapon_selector')
    addColourPreset(presets, 'gsrchud_pickup')
    addColourPreset(presets, 'gsrchud_flashlight')
    panel:AddItem(presets)

    -- add colours
    addColour(panel, 'Critical information colour', 'gsrchud_crit')
    addColour(panel, 'Health colour', 'gsrchud_health')
    addColour(panel, 'Health/suit separator colour', 'gsrchud_lseparator')
    addColour(panel, 'Suit battery colour', 'gsrchud_suit')
    addColour(panel, 'Clip colour', 'gsrchud_clip')
    addColour(panel, 'Ammunition separator colour', 'gsrchud_rseparator')
    addColour(panel, 'Ammunition colour', 'gsrchud_ammo')
    addColour(panel, 'Weapon selector colour', 'gsrchud_weapon_selector')
    addColour(panel, 'Pickup history colour', 'gsrchud_pickup')
    addColour(panel, 'Flashlight colour', 'gsrchud_flashlight')

    panel:Help('\nCredits') -- separator
    for i=1, #GSRCHUD.credits do
      local credit = GSRCHUD.credits[i]
      panel:Help(credit[1])
      panel:ControlHelp(credit[2])
    end
    panel:Help('\n' .. GSRCHUD.date)
    panel:ControlHelp('Version ' .. GSRCHUD.version)
  end)
end)
