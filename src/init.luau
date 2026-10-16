local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Config = {
    BaseFolder = "Tom",
    AssetFolder = "Tom/assets",

    Assets = {
        Icon = "https://raw.githubusercontent.com/ChatColours/Tom/refs/heads/main/assets/icon.png",
        Verity = "https://raw.githubusercontent.com/ChatColours/Tom/refs/heads/main/assets/verity.png"
    }
}

local ExecutorRatings = {
    xeno = "Fucking shit. Get something better and delete xeno",
    solara = "As bad as xeno.",
    madium = "Idk about this executor man, madium is decent ig",
    potassium = "Fuck yeah potassium",
    volt = "Volt is probably the best executor",
    wave = "Wave is good but not as good as volt",
    real = "No opinion but sunc and unc seems really good for ur executor"
}

local Functions = {
    ["hookfunction"] = function() return hookfunction end,
    ["hookmetamethod"] = function() return hookmetamethod end,
    ["newcclosure"] = function() return newcclosure end,
    ["newlclosure"] = function() return newlclosure end,
    ["oth.hook"] = function() return oth and oth.hook end,
    ["replicatesignal"] = function() return replicatesignal end
}

local function EnsureFolder(Path)
    if not isfolder(Path) then
        makefolder(Path)
    end
end

local function LoadAsset(Name, URL)
    local Path = Config.AssetFolder .. "/" .. Name

    if not isfile(Path) then
        local Success, Result = pcall(function()
            return game:HttpGet(URL)
        end)

        if not Success then
            warn("Failed to fetch asset:", Name, Result)
            return nil
        end

        writefile(Path, Result)
    end

    local Success, Result = pcall(getcustomasset, Path)

    if not Success then
        warn("Failed to load asset:", Name, Result)
        return nil
    end

    return Result
end

local function GetExecutor()
    if type(identifyexecutor) ~= "function" then
        return "Unknown"
    end

    local Success, Name = pcall(identifyexecutor)

    return Success and tostring(Name) or "Unknown"
end

local function CheckFunctions()
    local Supported = {}

    for Name, Getter in pairs(Functions) do
        local Success, Result = pcall(Getter)
        Supported[Name] = Success and type(Result) == "function"
    end

    return Supported
end

local function FormatSupport(Supported)
    local Lines = {}
    local Names = {}

    for Name in pairs(Supported) do
        table.insert(Names, Name)
    end

    table.sort(Names)

    for _, Name in ipairs(Names) do
        local Emoji = Supported[Name] and "✅" or "❌"
        table.insert(Lines, Name .. ": " .. Emoji)
    end

    return table.concat(Lines, "\n")
end

--// Initialization
EnsureFolder(Config.BaseFolder)
EnsureFolder(Config.AssetFolder)

local ExecutorName = GetExecutor()
local Supported = CheckFunctions()

local ExecutorRating = ExecutorRatings[ExecutorName:lower()]
    or "Idk what executor ur using lols no rating"

local SupportText = FormatSupport(Supported)

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

--// Window
local Window = WindUI:CreateWindow({
    Title = "Talking Dog",
    Icon = LoadAsset("icon.png", Config.Assets.Icon),
    Author = "Lalala",
    Folder = "VerityHumper69",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),

    ToggleKey = Enum.KeyCode.LeftShift,
    Transparent = true,
    Theme = "Dark",
    Resizable = true,

    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end
    }
})

--// Home
local HomeTab = Window:Tab({
    Title = "Home",
    Icon = LoadAsset("verity.png", Config.Assets.Verity)
})

HomeTab:Paragraph({
    Title = ExecutorRating,
    Desc = SupportText,
    Color = "Grey",
    ImageSize = 30,
    ThumbnailSize = 80,
    Locked = false
})

--// Bypasses
local BypassTab = Window:Tab({
    Title = "Bypasses",
    Icon = "bird"
})

-- Creates a supported/unsupported toggle.
local function AddToggle(Options)
    local Toggle = BypassTab:Toggle({
        Title = Options.Title,
        Desc = Options.Desc,
        Icon = Options.Icon or "bird",
        Type = "Checkbox",
        Value = false,

        Callback = function(State)
            if Options.Requirement
                and not Supported[Options.Requirement] then
                return
            end

            Options.Callback(State)
        end
    })

    if Options.Requirement
        and not Supported[Options.Requirement] then
        Toggle:Lock()
    end

    return Toggle
end

--// Toggle definitions
local ToggleDefinitions = {
    {
        Title = "Hook getfenv",
        Desc = "Requires hookfunction.",
        Requirement = "hookfunction",

        Callback = function(State)
            -- Add your testing logic here.
            print("getfenv toggle:", State)
        end
    },

    {
        Title = "Hook getfenv (OTH)",
        Desc = "Requires oth.hook.",
        Requirement = "oth.hook",

        Callback = function(State)
            -- Add your testing logic here.
            print("OTH toggle:", State)
        end
    },

    {
        Title = "Client Speed Detection",
        Desc = "Client-side property testing.",
        Requirement = "hookmetamethod",

        Callback = function(State)
            -- Add your testing logic here.
            print("Speed toggle:", State)
        end
    }
}

for _, Definition in ipairs(ToggleDefinitions) do
    AddToggle(Definition)
end
