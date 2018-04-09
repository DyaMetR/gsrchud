# GoldSrc HUD
This addon for Garry's Mod attempts to replicate the Heads Up Display feature from the game Half-Life and its mods.

## Features
+   Health indicator
+   Armor indicator
+   Ammunition indicator
+   Damage indicator
+   Hazard indicator
+   Weapon selector
+   Custom item pickup history
+	Custom death screen

## Customization includes
+   Toggle HUD
+   Change HUD scale
+   Change HUD theme (spritesheet)
+   Toggle each feature separately
+   Custom colouring of every component

## Available themes by default
+	Half-Life (Default theme)
+	Half-Life: Opposing Force
+	Half-Life: Blue Shift
+   Half-Life: Weapon Edition
+	Counter-Strike
+	Counter-Strike Condition Zero: Deleted Scenes
+	Afraid of Monsters
+	Sven Co-op

## Adding custom content
There are two main things you can do customization-wise:

+   Add a new theme
+   Add new weapon icons, ammo types, items and hazards.

For any of these two, if you don't have the legacy addon installed (a.k.a the source code inside your 'addons' folder) you'll have to create a new folder.

Then, inside, you must create the directories until you've got `/lua/autorun/gsrchud/`. Now, depending on what kind of customization addition you want to make, you'll have to follow different instructions.

### Adding a custom theme
Inside the directories you've just created, create another couple of directories until you get `/data/themes/`.

Now, in total, inside your custom addon folder you'll have enough directories (and subdirectories) to be able to access `/lua/autorun/gsrchud/data/themes/`.

Get inside that folder, and there you can add your custom themes. They'll be **automatically added to the game and will be available**.

_Now, but how can you create a theme correctly?_ It's really simple.

Since you can see the source code, go to the themes folder and copy the _**default theme**_ (called _default.lua_) and paste it into your custom folder. Rename it for something that doesn't already exist, and open it.

Inside the default theme you'll have all of the available options and a quick guide on how to add additional parameters to each sprite.

### Adding custom content such as weapons, ammo types, items and hazards' icons
This is simplier. Similar to the steps above, you need to create the required directories until you've got `/lua/autorun/gsrchud/add-ons/`.

Here, on the add-ons folder, you can add your files that contain the declarations for the new custom icons for items, weapons, etc. and they'll all be added to the game _automatically_.

You can check out the following files where you can see the functions that can allow you to achieve this:

+   `lua/autorun/gsrchud/util/ammo.lua`
+   `lua/autorun/gsrchud/util/items.lua`
+   `lua/autorun/gsrchud/util/themes.lua`
+   `lua/autorun/gsrchud/util/weapons.lua`

## Have fun!