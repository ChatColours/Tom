local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

const BaseFile = "Tom/"

-- check files --
if not isfolder("Tom") then
    makefolder("Tom")
end

if not isfolder(BaseFile.. "/assets") then
    makefolder(BaseFile.. "/assets")
end
const exename = identifyexecutor()

local executors = {
    shit = {
        ["xeno"] = "Fucking shit. Get something better and delete xeno",
        ["solara"] = "As bad as xeno."
    },
    meh = {
        ["madium"] = "Idk about this executor man, madium is decent ig"
    },
    good = {
        ["potassium"] = "Fuck yeah potassium",
        ["volt"] = "Volt is probably the best executor",
        ["wave"] = "Wave is good but not as good as volt",
        ["real"] = "No opinion but sunc and unc seems really good for ur executor"
    }
}

local function LoadAsset(fileName, link : string)
    local res = isfile(BaseFile.. fileName)
    if not res then
        res = game:HttpGet(link)
        writefile(BaseFile.. fileName, res)
    end
    if res then
        return getcustomasset(BaseFile.. fileName)
    end
end

local function checkfunct(funct)
    if type(funct) == "function" then
        return true
    else
        return false
    end
end

local function BoolToEmoji(val)
    if val == true then
        return "✅"
    else
        return "❌"
    end
end

local supported = {
    ["hookfunction"] = checkfunct(hookfunction),
    ["replicatesignal"] = checkfunct(replicatesignal)
}

local Window = WindUI:CreateWindow({
    Title = "Talking Dog",
    Icon = LoadAsset("assets/icon.png", "https://raw.githubusercontent.com/ChatColours/Tom/refs/heads/main/assets/icon.png"), -- lucide icon
    Author = "Lalala",
    Folder = "VerityHumper69",
    
    -- ↓ This all is Optional. You can remove it.
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
    
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },
})

local Tab = Window:Tab({
    Title = "Home",
    Icon = LoadAsset("", "https://raw.githubusercontent.com/ChatColours/Tom/refs/heads/main/assets/verity.png"), -- optional
    Locked = false,
})
local support_txt = ""
local functTitle = "Idk what executor ur using lols no rating"

for i, v in pairs(executors) do
    if v[exename:lower()] then
        functTitle = v[exename:lower()]
    end
end

for i, v in pairs(supported) do
    if v == true then

    end
    support_txt = i.. ": ".. BoolToEmoji(v).. "\n"
end

local functionparagraph = Tab:Paragraph({
    Title = functTitle,
    Desc = support_txt,
    Color = "Grey",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "Button",
            Callback = function() print("1 Button") end,
        }
    }
})