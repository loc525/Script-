local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "TSB LOC VN",
    LoadingTitle = "Rayfield UI",
    LoadingSubtitle = "loc.lua",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyRayfield",
        FileName = "Config"
    }
})

local Tab = Window:CreateTab("Scripts", 4483362458)

-- Suba Tech 1
Tab:CreateButton({
    Name = "Suba Tech 1",
    Callback = function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/665ce52316cff766428b4de62c71086e947c40c3fceb403d88ecc16a5339997f/download"))()
    end
})

-- Trash 2
Tab:CreateButton({
    Name = "Trash 2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man"))()
    end
})

-- Kiba Tech 3
Tab:CreateButton({
    Name = "Kiba Tech 3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yqantg-pixel/Find/refs/heads/main/Protected_1593573630798166.lua.txt"))()
    end
})

-- Auto Farm 4
Tab:CreateButton({
    Name = "Auto Farm 4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhnhatdepzai8-cloud/FARM-KILL/refs/heads/main/TSB"))()
    end
})
