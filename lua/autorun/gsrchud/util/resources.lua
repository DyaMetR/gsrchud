--[[
  DOWNLOADABLE RESOURCES
]]

if SERVER then

  local DIRECTORY = "materials/gsrchud/";
  local files, directories = file.Find("materials/gsrchud/*", "GAME");

  for _, v in pairs(directories) do
    local files, directories = file.Find(DIRECTORY .. v .. "/*", "GAME");
    for _, b in pairs(files) do
      resource.AddFile( DIRECTORY .. v .. "/" .. b);
    end
  end

end
