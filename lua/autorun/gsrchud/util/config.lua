
--[[
  MENU
]]
if CLIENT then
  local function menuComposition( panel )
  	panel:ClearControls();

    panel:AddControl( "CheckBox", {
  		Label = "Enabled",
  		Command = "gsrchud_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Hide default quick info",
  		Command = "gsrchud_quickinfo",
  		}
  	);

    -- Style
    panel:AddControl( "Label" , { Text = ""} );
    panel:AddControl( "Label" , { Text = "Style"} );
    panel:AddControl( "Slider", {
      Label = "HUD Scale",
      Type = "Float",
      Min = "0",
      Max = "10",
      Command = "gsrchud_scale"}
    );

    local combobox, label = panel:ComboBox("Theme", "gsrchud_theme");
    for theme, _ in pairs(GSRCHUD:GetThemes()) do
  		combobox:AddChoice(theme);
    end

    -- Visibility
    panel:AddControl( "Label" , { Text = ""} );
    panel:AddControl( "Label" , { Text = "Visibility"} );
    panel:AddControl( "Slider", {
      Label = "Base alpha",
      Type = "Float",
      Min = "0",
      Max = "510",
      Command = "gsrchud_alpha_base"}
    );

    panel:AddControl( "Slider", {
      Label = "Highlight alpha",
      Type = "Float",
      Min = "0",
      Max = "510",
      Command = "gsrchud_alpha_highlight"}
    );

    panel:AddControl( "Slider", {
      Label = "Weapon selector base alpha",
      Type = "Float",
      Min = "0",
      Max = "510",
      Command = "gsrchud_alpha_base_weapon"}
    );

    panel:AddControl( "Slider", {
      Label = "Weapon selector highlight alpha",
      Type = "Float",
      Min = "0",
      Max = "510",
      Command = "gsrchud_alpha_highlight_weapon"}
    );

    panel:AddControl("Button", {
  		Label = "Reset alpha",
  		Command = "gsrchud_reset_alpha"
  	})

    -- Util
    panel:AddControl( "Label" , { Text = ""} );
    panel:AddControl( "Label" , { Text = "Utilities"} );
    panel:AddControl( "CheckBox", {
  		Label = "Skip empty weapons",
  		Command = "gsrchud_skip_empty_weapons",
  		}
  	);

    panel:AddControl( "Slider", {
      Label = "Damage indicators separation",
      Type = "Float",
      Min = "0",
      Max = ScrW(),
      Command = "gsrchud_dmg_separation"}
    );

    panel:AddControl("Button", {
  		Label = "Reset utilities",
  		Command = "gsrchud_reset_util"
  	})

    -- Composition
    panel:AddControl( "Label" , { Text = ""} );
  	panel:AddControl( "Label" , { Text = "Composition"} );

    panel:AddControl( "CheckBox", {
  		Label = "Death screen",
  		Command = "gsrchud_death_screen_enabled",
  		}
  	);

  	panel:AddControl( "CheckBox", {
  		Label = "Weapon selector enabled",
  		Command = "gsrchud_wpn_selector_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Damage indicator enabled",
  		Command = "gsrchud_damage_enabled",
  		}
  	);

  	panel:AddControl( "CheckBox", {
  		Label = "Pickup history enabled",
  		Command = "gsrchud_pickup_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Hazards panel enabled",
  		Command = "gsrchud_hazard_enabled",
  		}
  	);

  	panel:AddControl( "CheckBox", {
  		Label = "Health & armor panel enabled",
  		Command = "gsrchud_health_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Ammo panel enabled",
  		Command = "gsrchud_ammo_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Auxiliary power enabled",
  		Command = "gsrchud_auxpow_enabled",
  		}
  	);

    panel:AddControl("Button", {
  		Label = "Reset composition",
  		Command = "gsrchud_reset_composition"
  	})

    -- Colouring
    panel:AddControl( "Label" , { Text = ""} );
  	panel:AddControl( "Label" , { Text = "Colouring"} );
    panel:AddControl( "CheckBox", {
  		Label = "Enable custom colouring",
  		Command = "gsrchud_color_enable",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Critical information",
      Red = "gsrchud_crit_color_r",
      Green = "gsrchud_crit_color_g",
      Blue = "gsrchud_crit_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Health",
      Red = "gsrchud_health_color_r",
      Green = "gsrchud_health_color_g",
      Blue = "gsrchud_health_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Armor",
      Red = "gsrchud_armor_color_r",
      Green = "gsrchud_armor_color_g",
      Blue = "gsrchud_armor_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Left separator",
      Red = "gsrchud_lsep_color_r",
      Green = "gsrchud_lsep_color_g",
      Blue = "gsrchud_lsep_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Current clip",
      Red = "gsrchud_clip_color_r",
      Green = "gsrchud_clip_color_g",
      Blue = "gsrchud_clip_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Reserve ammunition",
      Red = "gsrchud_ammo_color_r",
      Green = "gsrchud_ammo_color_g",
      Blue = "gsrchud_ammo_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Right separator",
      Red = "gsrchud_rsep_color_r",
      Green = "gsrchud_rsep_color_g",
      Blue = "gsrchud_rsep_color_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Weapon selector",
      Red = "gsrchud_selector_color_r",
      Green = "gsrchud_selector_color_g",
      Blue = "gsrchud_selector_color_b"
  		}
  	);

    -- Credits
    panel:AddControl( "Label",  { Text = ""});
    panel:AddControl( "Label",  { Text = "Version " .. GSRCHUD.Version});
    panel:AddControl( "Label",  { Text = ""});
  	panel:AddControl( "Label",  { Text = "Credits"});
    panel:AddControl( "Label",  { Text = "Main script: DyaMetR"});
    panel:AddControl( "Label",  { Text = "Sprite-sheets: The respective game developers"});
    panel:AddControl( "Label",  { Text = "Weapon selector base: code_gs"});
    panel:AddControl( "Label",  { Text = "Special thanks to Matsilagi for letting me know about code_gs's code"});
  end

  local function menuCreation()
  	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "GSRCHUD", "GoldSrc HUD", "", "", menuComposition );
  end
  hook.Add( "PopulateToolMenu", "gsrchud_menu", menuCreation );
end
