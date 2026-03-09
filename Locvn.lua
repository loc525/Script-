local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "TSB Loc",
   LoadingTitle = "Rayfield UI",
   LoadingSubtitle = "loc.lua",

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MyRayfield",
      FileName = "Config"
   }
})

local Tab = Window:CreateTab("Scripts", 4483362458)

-- Suba Tech
Tab:CreateButton({
   Name = "Suba Tech 1",
   Callback = function()
      loadstring(game:HttpGet("https://api.jkine.com/api/v1/luascripts/public/665ce52316cff766428b4de62c71086e947c40c3fceb403d88ecc16a5339997f/download"))()
   end
})

-- Trash
Tab:CreateButton({
   Name = "Trash 2",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/main/Trashcan%20Man"))()
   end
})

-- Kiba
Tab:CreateButton({
   Name = "Kiba Tech 3",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yqantg-pixel/Find/main/Protected_1593573630798166.lua.txt"))()
   end
})

-- Auto Farm
Tab:CreateButton({
   Name = "Auto Farm",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/minhnhatdepzai8-cloud/FARM-KILL/main/TSB"))()
   end
})
